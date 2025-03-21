 # AKS IaC and Deployment Assignment

## Introduction
This project demonstrates how to set up an **AKS cluster** using **Terraform** and deploy a **simple containerized application** to it. The goal is to gain hands on experience with AKS, Kubernetes, and deployment automation.

## Prerequisites
Ensure you have the following installed before proceeding:

- [Git](https://git-scm.com/downloads)
- [Azure Account](https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or any virtualization software
- [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

To Learn about Docker, Kubernetes, Terraform:
- [Docker](https://www.youtube.com/watch?v=slcKUz6CyLg)
- [Kubernetes 1)](https://www.youtube.com/watch?v=xvxXEK3WDfI)
- [Kubernetes 2)](https://www.youtube.com/watch?v=MIxJ9_kfP54)
- [Kubernetes 3)](https://kodekloud.com/courses/kubernetes-for-the-absolute-beginners-hands-on)
- [Kubernetes Resource limit](https://sysdig.com/blog/kubernetes-limits-requests/)
- [Terraform](https://www.youtube.com/watch?v=VZbrzp0dkCo)

Deployment Information:
This project is deployed using **KodeKloud Playground**, which is valid for **only 1h-3h hours** per session. 
(The deployment's external IP address will change each time)

### Important Notes:
- If you are using the **free tier** or **pay-as-you-go** subscription, some settings or limitations may vary.

## Local Testing with Minikube

### Step 1: Setting up Minikube Cluster
```sh
minikube start
```
![Screenshot 2025-03-21 131519](https://github.com/user-attachments/assets/2d379121-0d59-424c-ae37-a4806eeb0b06)

If you encounter errors, ensure virtualization is enabled in your BIOS settings. If you have enabled Hyper-V, disable the default Hyper-V and restart.
Error:

(C:\Windows\System32>minikube start --driver=virtualboxW0320 10:52:29.081445   23344 main.go:291] Unable to resolve the current Docker CLI context "default": context "default": context not found: open C:\Users\DELL\.docker\contexts\meta\37a8eec1ce19687d132fe29051dca629d164e2c4958ba141d5f4133a33f0688f\meta.json: The system cannot find the path specified....)

Check if Hyper-V is Enabled
```sh
systeminfo | find "Hyper-V Requirements"
```
Disable Hyper-V
```sh
bcdedit /set hypervisorlaunchtype off
```
### Step 2: Deploy Application Locally

1. Create a project directory and Kubernetes directory:
   ```sh
   mkdir -p ProjectAKS && cd ProjectAKS
   mkdir -p K8s
   ```

2. Create a `deployment.yaml` file:

3. Apply the deployment:
   ```sh
   kubectl apply -f K8s/deployment.yaml
   ```
4. Create a `service.yaml` file:

5. Apply the service:
   ```sh
   kubectl apply -f K8s/service.yaml
   ```

6. Get the service details:
   ```sh
   kubectl get svc
   ```
   ![Screenshot 2025-03-21 131519](https://github.com/user-attachments/assets/f2031cfc-5b72-4f44-91b7-ca9841d3e5b7)

7. Open in browser:
   ```sh
   minikube service nginx-service
   ```
   _(You should see server response in the browser.)_
   ![Screenshot 2025-03-21 132409](https://github.com/user-attachments/assets/b4a22005-c99c-4cb8-8e27-532f90e19fac)

7. Delete a Specific Service:
   ```sh
   kubectl delete service <service-name>
   ```

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
   ![Screenshot 2025-03-21 140816](https://github.com/user-attachments/assets/15085558-a56e-403c-aa7a-91261f6ada75)

4. Preview the changes:
   ```sh
   terraform plan
   ```
   ![Screenshot 2025-03-21 140754](https://github.com/user-attachments/assets/e18aad6f-b616-45af-adb5-2cfefa93b915)

5. Apply the configuration:
   ```sh
   terraform apply
   ```
   ![Screenshot 2025-03-21 140738](https://github.com/user-attachments/assets/199486db-8d90-44d1-9552-6d0d302fffcf)


### Step 2: Connect to AKS Cluster
```sh
az aks get-credentials --resource-group <your-resource-group> --name <your-cluster-name>
kubectl get nodes
```
![Screenshot 2025-03-21 124623](https://github.com/user-attachments/assets/da9fa579-ff5a-4ec9-b877-f9cbd15d81c7)

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
   ![Screenshot 2025-03-21 124936](https://github.com/user-attachments/assets/2d1efc67-efe1-4166-bb10-5a02b0e256e6)
   ![Screenshot 2025-03-21 125610](https://github.com/user-attachments/assets/46ca079c-6b37-4c6a-b11c-36b3d963ac70)
   ![Screenshot 2025-03-21 124128](https://github.com/user-attachments/assets/cdf1d5c7-9858-4925-a864-5658790d5a59)

   Access the app using the external IP in your browser.
   
   ![Screenshot 2025-03-21 125236](https://github.com/user-attachments/assets/282c58df-e304-491e-b676-ff0056160231)

## Troubleshooting & Issues Faced
- **Error: `subscription_id` is a required provider property ** → Ensure Azure subscription ID is set in Terraform.
- **Error: Access denited Resource Group ** → Ensure Azure Default resource group is set in azure.
- **[Error: Terraform does not have the necessary permissions to register Resource Providers](https://stackoverflow.com/questions/57892557/terraform-azure-as-a-provider-and-limited-access-account)
  ![Screenshot 2025-03-19 182942](https://github.com/user-attachments/assets/2f588dc5-7726-400c-8162-d57b6844dbb9)
- **Limited resources in KodeKloud sandbox** → Used `Standard_D2s_v3` VM with a single resource group.
- ![Screenshot 2025-03-19 183136](https://github.com/user-attachments/assets/25da7e92-c4e1-4e64-b7cd-421c103d05a0)
- **Service not accessible?** → Ensure the service type is `LoadBalancer` and check `kubectl get svc`.

## Repository Structure
```
├── ProjectAKS
│     ├──K8s
│         ├── deployment.yaml
│         ├── service.yaml
├
│     ├── main.tf
├── README.md
```

## Conclusion
This project covers setting up an AKS cluster using Terraform, deploying a containerized application, and testing it both locally (Minikube) and in Azure.
