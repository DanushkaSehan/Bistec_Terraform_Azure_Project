# AKS IaC and Deployment Assignment

## Introduction
This project demonstrates how to set up an **Azure Kubernetes Service (AKS) cluster** using **Terraform** (Infrastructure as Code) and deploy a **simple containerized application** to it. The goal is to gain hands-on experience with AKS, Kubernetes, and deployment automation.

## Prerequisites
Ensure you have the following installed before proceeding:

- [Git](https://git-scm.com/downloads)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or any virtualization software
- [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Local Testing with Minikube

### Step 1: Setting up Minikube Cluster
```sh
minikube start
```
If you encounter errors, ensure virtualization is enabled in your BIOS settings. If using Hyper-V, disable the default Hyper-V and restart.

### Step 2: Deploy Application Locally

1. Create a Kubernetes directory:
   ```sh
   mkdir -p K8s && cd K8s
   ```

2. Create a `deployment.yaml` file:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: echoserver-deployment
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: echoserver
     template:
       metadata:
         labels:
           app: echoserver
       spec:
         containers:
         - name: echoserver
           image: k8s.gcr.io/echoserver:1.4
           ports:
           - containerPort: 8080
   ```

3. Apply the deployment:
   ```sh
   kubectl apply -f deployment.yaml
   ```

4. Create a `service.yaml` file:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: echoserver-service
   spec:
     selector:
       app: echoserver
     ports:
     - protocol: TCP
       port: 80
       targetPort: 8080
     type: LoadBalancer
   ```

5. Apply the service:
   ```sh
   kubectl apply -f service.yaml
   ```

6. Get the service details:
   ```sh
   kubectl get svc
   ```

7. Open in browser:
   ```sh
   minikube service echoserver-service
   ```
   _(You should see server response in the browser.)_

## Deploying to Azure AKS

### Step 1: Terraform Setup
1. Create a `main.tf` file and define the AKS cluster.
2. Log in to Azure:
   ```sh
   az login
   ```
3. Initialize Terraform:
   ```sh
   terraform init
   ```
4. Preview the changes:
   ```sh
   terraform plan
   ```
5. Apply the configuration:
   ```sh
   terraform apply --auto-approve
   ```

### Step 2: Connect to AKS Cluster
```sh
az aks get-credentials --resource-group <your-resource-group> --name <your-cluster-name>
kubectl get nodes
```

### Step 3: Deploy Application to AKS
1. Apply the deployment:
   ```sh
   kubectl apply -f deployment.yaml
   ```
2. Apply the service:
   ```sh
   kubectl apply -f service.yaml
   ```
3. Check running pods:
   ```sh
   kubectl get pods
   ```
4. Get the external IP:
   ```sh
   kubectl get svc
   ```
   Access the app using the external IP in your browser.

## Troubleshooting & Issues Faced
- **Error: `subscription_id` is a required provider property** → Ensure Azure subscription ID is set in Terraform.
- **Limited resources in KodeKloud sandbox** → Used `Standard_D2s_v3` VM with a single resource group.
- **Service not accessible?** → Ensure the service type is `LoadBalancer` and check `kubectl get svc`.

## Repository Structure
```
├── K8s
│   ├── deployment.yaml
│   ├── service.yaml
├── terraform
│   ├── main.tf
├── README.md
```

## Conclusion
This project covers setting up an AKS cluster using Terraform, deploying a containerized application, and testing it both locally (Minikube) and in Azure. It provides hands-on experience with Kubernetes and Infrastructure as Code (IaC).
