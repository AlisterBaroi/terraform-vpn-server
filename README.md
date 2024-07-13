# Terraaform VPN server for GCP (WireGuard Server)
The codes in this folder (/CloudSQL) create and deploy the GCP ``Cloud SQL Instance`` automatically, with the following configurations:
| Database Configuration  |           Value         |
|-------------------------|-------------------------|
|      Database Type      |        MySQL 8.0        |
|      CPU                |             1           |
|    CPU Type             |        Dedicated        |
|      RAM                |         3.75 GB         |
|    Storage              |         10 GB           |
|  Storage Type           | Sold State Drive (SSD)  |
|    Delete Protection    |         True            |
|    Region               |      europe-west2       |

## Table of Contents
<img src="https://github.com/user-attachments/assets/20962071-ddff-46b3-b1c8-7627c8423f17"  width="500" align="right" margin_left="200" title="Terraform" alt="Terraform Logo" >

- [Overview](#overview)
- [Setup](#setup)
- [Deploy](#deploy)
- [Clean-up](#clean-up)
- [Terraform](#terraform)

## 1. Setup
- Set the GCP project info in the ``provider.tf`` file, according to the project details from the cloud console.

- Get or create the credential file (json key) for a Service Account with the required roles, downnlaod, and paste it to this folder, renaming it as ``cred.json``.

- Initialize the project, as follows:
    ```
    terraform init
    ```
## 2. Deploy
- Make changes according to your requirements (if needed).

- Review the infrastructures and configurations that are to be created:
    ```
    terraform plan
    ```
- Deploy the infrastructure to the cloud:
    ```
    terraform apply
    ```
- After vpn server is provisioned, run the following script to create wireguard vpn clients: \
  ***Note:** Change the ```PEERS``` value to how many clients you want to create.*
    ```
    docker run -d \
      --name=wireguard \
      --cap-add=NET_ADMIN \
      -e PUID=1000 \
      -e PGID=1000 \
      -e TZ=Etc/UTC \
      -e PEERS=1 \
      -p 51820:51820/udp \
      -v /var/config:/config \
      --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
      --restart unless-stopped \
      lscr.io/linuxserver/wireguard:latest
    ```
- Next, run the following command for each ``PEER`` and copy paste the code to WireGuard clent, or save as ``.conf`` file:
    ```
    sudo cat /var/config/peer1/peer1.conf
    ```

## 3. Clean-up
If and when the cloud infrastructure needs to be deleted/destroyed, run the following command:
```
terraform destroy
```

## 4. Terraform
Managing infrastructure manually can be error-prone, time-consuming, and difficult to replicate across environments. Infrastructure as Code (IaC) addresses these challenges by allowing us to define our infrastructure using code, which can then be versioned, tested, and automated. This repository serves as the central location for all the code related to our GCP infrastructure. It includes configurations, templates, and scripts necessary for provisioning and managing resources such as virtual machines, networking components, databases, and more:   
- ***Declarative Configuration:*** Define infrastructure using declarative configuration files, making it easy to understand and maintain.
- ***Version Control:*** Store infrastructure configurations alongside application code for versioning and collaboration.
- ***Automated Provisioning:*** Automate the provisioning and configuration of infrastructure, reducing manual errors and saving time.
- ***Scalability:*** Easily scale infrastructure up or down by modifying configuration files and re-running deployments.
- ***Consistency:*** Ensure consistency across environments (development, staging, production) by using the same configuration.
