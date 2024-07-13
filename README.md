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

## 3. Clean Up
If and when the cloud infrastructure needs to be deleted/destroyed, run the following command:
```
terraform destroy
```
