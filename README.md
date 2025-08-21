<h1 align="center">🚀 Terraform EKS Cluster Deployment</h1>

<p align="center">
  <img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/kubernetes/icon/color/kubernetes-icon-color.svg" alt="Kubernetes" width="70"/>
  <img src="https://www.svgrepo.com/show/448253/terraform.svg" alt="Terraform" width="70"/>
  <img src="https://www.svgrepo.com/show/376354/amazon-eks.svg" alt="Amazon EKS" width="70"/>
</p>

<p align="center">
  <b>Automating Amazon EKS Cluster Creation with Terraform</b><br>
  Infrastructure as Code (IaC) for Kubernetes on AWS
</p>

<hr>

<h2>📌 Project Overview</h2>
<p>
This repository contains Terraform configuration files to provision an <b>Amazon EKS Cluster</b> along with the required AWS resources.  
Using Terraform as an <b>Infrastructure as Code (IaC)</b> tool, the cluster setup is automated, reproducible, and scalable.  
</p>

<hr>

<h2>⚡ Prerequisites</h2>
<ul>
  <li>AWS Account with IAM permissions</li>
  <li>Linux environment (Ubuntu preferred)</li>
  <li><a href="https://developer.hashicorp.com/terraform/downloads">Terraform</a></li>
  <li><a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html">AWS CLI</a></li>
  <li><a href="https://kubernetes.io/docs/tasks/tools/">kubectl</a></li>
  <li><a href="https://eksctl.io/">eksctl</a></li>
</ul>

<hr>

<h2>🛠️ Installation & Setup</h2>

<h3>1. Install AWS CLI</h3>
<pre>
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws configure
</pre>

<h3>2. Install Terraform</h3>
<pre>
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform -y
terraform -version
</pre>

<h3>3. Configure Kubeconfig</h3>
<pre>
aws eks --region ap-south-1 update-kubeconfig --name devopsshack-cluster
</pre>

<h3>4. Install kubectl</h3>
<pre>
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
</pre>

<h3>5. Install eksctl</h3>
<pre>
curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz
sudo mv eksctl /usr/local/bin
eksctl version
</pre>

<hr>

<h2>🚀 Deploying the EKS Cluster</h2>

<h3>1. Initialize & Apply Terraform</h3>
<pre>
terraform init
terraform plan
terraform apply -auto-approve
</pre>

<h3>2. Associate IAM OIDC Provider</h3>
<pre>
eksctl utils associate-iam-oidc-provider \
  --region ap-south-1 \
  --cluster devopsshack-cluster \
  --approve
</pre>

<h3>3. Create IAM Service Account for EBS CSI Driver</h3>
<pre>
eksctl create iamserviceaccount \
  --region ap-south-1 \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster devopsshack-cluster \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve \
  --override-existing-serviceaccounts
</pre>

<h3>4. Deploy Add-ons</h3>
<pre>
# EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"

# NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Cert-Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
</pre>

<hr>

<h2>📊 Project Structure</h2>
<pre>
├── main.tf        # Terraform main configuration
├── variable.tf    # Input variables
├── output.tf      # Cluster outputs
├── README.md      # Documentation
</pre>

<hr>

<h2>✅ Verification</h2>
<pre>
kubectl get nodes
kubectl get pods --all-namespaces
</pre>

<hr>

<h2>📌 Author</h2>
<p align="center">
  <b>Uday Kiran</b> <br>
  <em>Developed with ❤️ using Terraform & AWS EKS</em> <br>
  <a href="https://github.com/p-udaykiran">GitHub</a> | 
  <a href="https://www.linkedin.com/in/udaykiran-pagidimari-30275725a/">LinkedIn</a>
</p>

