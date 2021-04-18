#!/bin/bash

envir=$(kubectl config current-context | awk -F '_' '{print $4}' | awk -F '-' '{print $1}')
subject="unused kubernetes objects on $envir"
token_secret=$(kubectl get secret | grep default-token | awk '{print $1}')
token=$(kubectl describe secret $token_secret | grep token: | awk '{print $2}')
endpoint=$(kubectl cluster-info | grep 'Kubernetes master' | awk '{print $6}'| sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
message=$(python /opt/k8s-objects.py "$endpoint" "$token")

echo -e "$message" | mailx -S smtp="smtp.mailgun.org:2525" -S nss-config-dir="/etc/pki/nssdb/" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="prod-monitoring@linkpool.org" -S smtp-auth-password="{{ smtp-auth-password }}" -S ssl-verify=ignore -v -r "$envir-jenkins@linkpool.org" -s "$subject" techsupport@linkpool.org
