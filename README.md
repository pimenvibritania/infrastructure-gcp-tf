# SRE Infrastructure

## Application Deployment
Please refer [this Repository](https://gitlab.com/pimenvibritania/sre) documentation deploy application!

## Topology
![Topology](sre.svg)

## Provisioning Infrastructure
- Make sure the `0-locals.tf` file
- Create `gcs` bucket based on `1-provider.tf`
- Applying `terraform`


## Installing ingress-nginx
```
helm install my-ing ingress-nginx/ingress-nginx \
  --namespace nginx-ingress \
  --values hk8s/elm-values.yaml \
  --create-namespace
```

## Installing HA-Proxy for CloudSQL
- Go to `k8s/haproxy-dev` for development cluster
- Go to `k8s/haproxy-prod` for production cluster
- Make sure the `cm.yaml`, change with your CloudSQL private IP
- Apply

## Installing gitlab runner
- Go to gitlab repo > settings > CI/CD > Runners > Create New project runner
- SSH into agent & install runner agent:
```
# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
```
- Register your runner into agent
```
gitlab-runner register  --url https://gitlab.com  --token <TOKEN>
```
- Run the agent
```
gitlab-runner run
```

## Installing APPLICATION with Helm
- Install cert manager first by applying `YAML` on `k8s/cert-manager.yaml`
- Look at `helm-sre-app` directory
- Make sure the `values.yaml` & `dev-values.yaml`
- Run the helm with
```
helm install sre-application helm-sre-app/ --values helm-sre-app/values.yaml --namespace sre-application --create-namespace
```