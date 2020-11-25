#!/bin/bash
echo "Deploying template specs..."
echo "Resource Group: $RESOURCE_GROUP"
echo "Location:       $LOCATION"
echo "Version:        $VERSION"

RGP=$(az group create -l $LOCATION -n $RESOURCE_GROUP)
echo "Resource group $RESOURCE_GROUP created/updated"

RESPONSE=$(az ts create \
    --name "cloudoven-appInsights" \
    --display-name "Cloudoven-AppInsights" \
    --description "Application Insight component" \
    --version $VERSION \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --template-file "./appInsights/component.json" \
    --yes \
    --query 'id' -o json)

echo "Done: $RESPONSE"

RESPONSE=$(az ts create \
    --name "cloudoven-hostingplan" \
    --display-name "Cloudoven-HostingPlan" \
    --description "Hosting plan component" \
    --version $VERSION \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --template-file "./server-farm/component.json" \
    --yes\
    --query 'id' -o json)

echo "Done: $RESPONSE"

RESPONSE=$(az ts create \
    --name "cloudoven-container-app" \
    --display-name "Cloudoven-ContainerApp" \
    --description "Docker container based Linux web app" \
    --version $VERSION \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --template-file "./web-app/component.json" \
    --yes\
    --query 'id' -o json)

echo "Done: $RESPONSE"

RESPONSE=$(az ts create \
    --name "cloudoven-django-app" \
    --display-name "Cloudoven-DjangoApp" \
    --description "Docker container based Django Linux web app" \
    --version $VERSION \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --template-file "./django-app/component.json" \
    --yes\
    --query 'id' -o json)
    
echo "Done: $RESPONSE"