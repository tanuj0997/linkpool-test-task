# linkpool-test-task
Linkpool Test Task

## ansible 

Ansible folder contains files related to deployment.

- Jenkins
- Postgresql
- Redis

Sample command to run ansible playbook : 

```
ansible-playbook -i deployment/production/postgres11 -u linkpool --ansible-vault-password=xxxxxxx postgres-v2.yml
```

## terraform

Terraform folder contains files related to infrastructure as code.

- GCP
- GKE
- VM instances
- Databases

Sample command to create resources :

```
terraform init
terraform plan
terraform apply

```

## DockerFile

DockerFile is used to fetch and build image from sample app repository

Sample command to build and push Docker image :

```
docker build . -t linkpool/testtask:latest
docker push linkpool/testtask:latest
```

## Project Structure

```
.
├── ansible
│   ├── deployment
│   │   └── production
│   │       ├── coreapp-redis
│   │       ├── gcp_jenkins
│   │       ├── postgres11
│   │       └── redis
│   ├── jenkins.yml
│   ├── postgres-v2.yml
│   ├── redis-sentinel.yml
│   └── roles
│       ├── jenkins
│       │   ├── defaults
│       │   │   └── main.yml
│       │   ├── files
│       │   │   └── k8s-objects.py
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── tasks
│       │   │   ├── development.yml
│       │   │   ├── gce.yml
│       │   │   └── main.yml
│       │   ├── templates
│       │   │   ├── check-k8s-deployments.sh
│       │   │   ├── check-k8s-objects.sh
│       │   │   └── postinstall-setup.groovy.j2
│       │   └── vars
│       │       ├── production.yml
│       │       └── staging.yml
│       ├── jenkins-git
│       │   ├── meta
│       │   │   └── main.yml
│       │   └── tasks
│       │       └── main.yml
│       ├── memcached
│       │   ├── tasks
│       │   │   └── main.yml
│       │   └── templates
│       │       └── memcached
│       ├── postgres-v2
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── README.md
│       │   ├── tasks
│       │   │   ├── exporter.yml
│       │   │   ├── main.yml
│       │   │   ├── primary.yml
│       │   │   └── replica.yml
│       │   └── vars
│       │       ├── benchmark.yml
│       │       ├── development.yml
│       │       ├── dr.yml
│       │       ├── production.yml
│       │       └── staging.yml
│       ├── redis
│       │   ├── defaults
│       │   │   └── main.yml
│       │   ├── files
│       │   │   └── redis-exporter.service
│       │   ├── tasks
│       │   │   ├── exporter.yml
│       │   │   └── main.yml
│       │   └── vars
│       │       └── main.yml
│       └── sentinel
│           ├── files
│           │   └── redis-sentinel.service
│           ├── tasks
│           │   └── main.yml
│           └── templates
│               └── sentinel.conf
├── DockerFile
├── README.md
└── terraform
    ├── modules
    │   ├── gce_app_instances
    │   │   ├── jenkins.tf
    │   │   └── variables.tf
    │   ├── memcached
    │   │   ├── instance.tf
    │   │   └── variables.tf
    │   └── redis_sentinels
    │       ├── sentinels.tf
    │       └── variables.tf
    └── production
        ├── kubernetes.tf
        ├── postgresql11.tf
        ├── provider.tf
        ├── redis.tf
        └── variables.tf
```
