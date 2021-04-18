from __future__ import print_function
import time
from kubernetes import client
import sys

token = sys.argv[2]
configuration = client.Configuration()
configuration.host=sys.argv[1]
configuration.verify_ssl=False
configuration.debug = False
configuration.api_key={"authorization":"Bearer "+ token}
client.Configuration.set_default(configuration)
v1 = client.CoreV1Api()

pods=v1.list_namespaced_pod('default')

def get_objects(object_list, used_objects):
  for obj in object_list.items:
    try:
      used_objects.remove(obj.metadata.name)
    except:
      print(obj.metadata.name)

u_secrets=[]
u_config_maps=[]
u_persistent_volumes=[]
for p in pods.items:
  for vols in p.spec.volumes:
    try:
      if vols.secret:
        u_secrets.append(vols.secret.secret_name)
      if vols.config_map:
        u_config_maps.append(vols.config_map.name)
      if vols.persistent_volume_claim:
        u_persistent_volumes.append(vols.persistent_volume_claim.claim_name)
    except:
      pass
  for container in p.spec.containers:
    for env in (container.env or []):
      if env.value_from:
        try:
          u_config_maps.append(env.value_from.config_map_key_ref.name)
        except:
          pass
        try:
          u_secrets.append(env.value_from.secret_key_ref.name)
        except:
          pass

u_secrets=list(set(u_secrets))
u_config_maps=list(set(u_config_maps))
u_persistent_volumes=list(set(u_persistent_volumes))

print("\n\nunused secrets")
get_objects(v1.list_namespaced_secret('default'), u_secrets)

print("\n\nunused configmaps")
get_objects(v1.list_namespaced_config_map('default'), u_config_maps)

print("\n\nunused volumes")
get_objects(v1.list_namespaced_persistent_volume_claim('default'), u_persistent_volumes)
