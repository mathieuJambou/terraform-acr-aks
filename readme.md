# terraform-acr-aks

## Commands

- terraform init

- az account show

- az account list --query "[?user.name=='<microsoft_account_email>'].{Name:name, ID:id, Default:isDefault}" --output Table

- az account set --subscription ""


- terraform plan -var-file="test.tfvars"  

- terraform apply -var-file="test.tfvars"  


az acr login --name mjcr1

```
docker build -t test/http .
docker tag < IMAGE ID > mjcr1.azurecr.io/test/http
docker push mjcr1.azurecr.io/test/http
```

```
erraform output kube_config
$env:KUBECONFIG = .\azurek8s

az aks update -n 'aks-name' -g 'rg' --attach-acr 'acr'

kubectl apply -f .\deployment.yml
```