<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>

<!-- Title -->
<h1 align="center">🚀 GitOps CI/CD Pipeline Project</h1>

<!-- Logos -->
<p align="center">
  <img src="https://www.jenkins.io/images/logos/jenkins/jenkins.png" alt="Jenkins" width="70"/>
  <img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/argo/icon/color/argo-icon-color.svg" alt="ArgoCD" width="70"/>
  <img src="https://raw.githubusercontent.com/cncf/artwork/master/projects/kubernetes/icon/color/kubernetes-icon-color.svg" alt="Kubernetes" width="70"/>
  <img src="https://www.svgrepo.com/show/376356/aws.svg" alt="AWS" width="70"/>
  <img src="https://www.svgrepo.com/show/448253/terraform.svg" alt="Terraform" width="70"/>
</p>

<p align="center">
  <b>End-to-End CI/CD with GitOps on AWS EKS</b><br>
  <em>Automated pipeline using Jenkins, SonarQube, Nexus, ArgoCD, Docker, Terraform & Kubernetes</em>
</p>

<hr>

<!-- Project Overview -->
<h2>📌 Project Overview</h2>
<p>
This project showcases a <b>complete DevOps pipeline</b> with <b>GitOps principles</b>.  
It integrates <b>Continuous Integration (CI)</b>, <b>Artifact Management</b>, <b>Infrastructure as Code (IaC)</b>, and <b>Continuous Delivery (CD)</b> into an automated workflow running on <b>AWS EKS</b>.  
The goal is to achieve reproducibility, scalability, and seamless deployments.
</p>

<hr>

<!-- Workflow -->
<h2>⚡ Workflow</h2>
<ol>
  <li>☁️ Provision AWS EC2 instances for Jenkins, Nexus, and SonarQube</li>
  <li>⚙️ Jenkins pipeline triggers build, test, and static code analysis</li>
  <li>📦 Store build artifacts in Nexus Repository</li>
  <li>🐳 Build & push Docker images</li>
  <li>🔄 GitOps updates Kubernetes manifests in GitHub</li>
  <li>🚀 ArgoCD continuously syncs and deploys workloads to EKS</li>
  <li>🌐 Application exposed via service/domain</li>
</ol>

<hr>

<!-- Tools & Technologies -->
<h2>🛠️ Tools & Technologies</h2>
<ul>
  <li>☁️ <b>AWS EKS</b> – Managed Kubernetes Cluster</li>
  <li>⚙️ <b>Jenkins</b> – Continuous Integration & Automation</li>
  <li>🔍 <b>SonarQube</b> – Code Quality & Security Scanning</li>
  <li>📦 <b>Nexus</b> – Artifact Repository Management</li>
  <li>🐳 <b>Docker</b> – Containerization</li>
  <li>🚀 <b>ArgoCD</b> – GitOps Continuous Delivery</li>
  <li>☸️ <b>Kubernetes</b> – Orchestration Platform</li>
  <li>📜 <b>Terraform</b> – Infrastructure as Code (IaC)</li>
</ul>

<hr>

<!-- Screenshots -->
<h2>🖼️ Project Screenshots</h2>
<p align="center"><i>Execution stages of the CI/CD pipeline with GitOps:</i></p>

<h3>1️⃣ AWS Server Setup</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/AWS%20servers.png?raw=true" alt="AWS Server" width="750"/>
</p>

<h3>2️⃣ Jenkins Pipeline</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/pipeline.png?raw=true" alt="Jenkins Pipeline" width="750"/>
</p>

<h3>3️⃣ Nexus Repository</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/nexus.png?raw=true" alt="Nexus Repo" width="750"/>
</p>

<h3>4️⃣ GitOps in Action</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/gtiops.png?raw=true" alt="GitOps Implementation" width="750"/>
</p>

<h3>5️⃣ Kubernetes Cluster</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/cluster.png?raw=true" alt="Kubernetes Cluster" width="750"/>
</p>

<h3>6️⃣ Final Application Output</h3>
<p align="center">
  <img src="https://github.com/p-udaykiran/multi-tier-ci/blob/main/src/main/resources/templates/output.png?raw=true" alt="Final Output" width="750"/>
</p>

<hr>

<!-- Outcome -->
<h2>✅ Outcome</h2>
<p>
This project delivers a <b>production-ready CI/CD workflow</b> using <b>GitOps</b>.  
Every step from <b>code commit → build → scan → artifact upload → manifest update → deployment</b> is <b>fully automated</b>.  
Key results include:
</p>
<ul>
  <li>⚡ Faster and reliable deployments</li>
  <li>🔄 Easy rollbacks with Git history</li>
  <li>🔒 Improved code quality and security</li>
  <li>🌍 Scalable and highly available application</li>
</ul>

<hr>

<!-- Author -->
<h2>📌 Author</h2>
<p align="center">
  <b>Uday Kiran</b> <br>
 
  <a href="https://github.com/p-udaykiran">🌐 GitHub</a> | 
  <a href="https://www.linkedin.com/in/udaykiran-pagidimari-30275725a/">💼 LinkedIn</a>
</p>

</body>
</html>
