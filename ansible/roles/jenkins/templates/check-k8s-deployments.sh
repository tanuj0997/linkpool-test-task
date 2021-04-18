#!/bin/bash

envir=$(kubectl config current-context|awk -F '_' '{print $4}'|awk -F '-' '{print $1}')
subject="deployments with 0 pods on $envir"
deployments=$(kubectl get deployments|awk '{ if ($2 == 0) print $1}')
echo -e "$deployments" | mailx -S smtp="smtp.mailgun.org:2525" -S nss-config-dir="/etc/pki/nssdb/" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user="prod-monitoring@linkpool.org" -S smtp-auth-password="{{ smtp-auth-password }}" -S ssl-verify=ignore -v -r "$envir-jenkins@linkpool.org" -s "$subject" techsupport@linkpool.org
