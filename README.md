# SRE-Infra

installing ingress-nginx
```
helm install my-ing ingress-nginx/ingress-nginx \
  --namespace nginx-ingress \
  --values helm-values.yaml \
  --create-namespace
```