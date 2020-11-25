#!/bin/bash
echo "Provisioning environments..."

RESOURCEGROUP="blue-team-resources"
LOCATION="westeurope"
TSRGP="CloudOven-Trusted-TemplateSpecs"
TSNAME="cloudoven-django-app"
VERSION="1.0"

RGP=$(az group create -l $LOCATION -n $RESOURCEGROUP)
echo "Resource group $RESOURCEGROUP created/updated"

APPINS_TSID=$(az ts show --resource-group $TSRGP --name $TSNAME --version $VERSION --query 'id' -o json)


RES=$(az deployment group create \
  --resource-group $RESOURCEGROUP \
  --template-spec $APPINS_TSID \
  --parameters "./blue-parameters.json")

# az deployment group what-if \
#   --resource-group $RESOURCEGROUP \
#   --template-spec $APPINS_TSID \
#   --parameters "./blue-parameters.json"