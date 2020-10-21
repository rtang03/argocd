## Custom ArgoCD docker image
Argo CD Custom Image for adding `helm-secret` plugin, and `gcloud`.      

See [introduction](https://medium.com/faun/handling-kubernetes-secrets-with-argocd-and-sops-650df91de173)  

In order to adopt sops encryption/decryption during Argo CD. We need a custom Argo CD Custom, which add `helm secret` plug-in. 
It decrypts `secrets.yaml` for Argo CD application creation. Also, this implementation will currently support GCP Cloud 
KMS; will later support AWS KMS. It is intended not to use local PGP.   

Pre-requisite: in order to use GCP KMS, it needs to mount the service-account with KMS `encrypt/decrypt` access to below path.  
 
```shell script
GOOGLE_APPLICATION_CREDENTIALS=/app/config/gcp/kms-service-account.json
```

The image will be built upon tagging, with below naming convention. 
```shell script
# naming convention v[Argo CD origin release]-rel.[revision number]
git tag v1.7.7-rel.1
git push origin v1.7.7-rel.1

# Delete tag
git tag -d v1.7.7-rel.1
git push origin --delete v1.7.7-rel.1
```

### External Reference
- [sample 1a: custom argocd](https://github.com/camptocamp/docker-argocd)
- [sample 1b: custom argocd example](https://github.com/camptocamp/argocd-helm-sops-example)
- [helm-secrets plugin](https://github.com/zendesk/helm-secrets)
- [sample 3: custom argocd](https://gitlab.com/iotops/container-images/argocd/-/blob/master/Dockerfile)
- [helm chart for argocd](https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd)
- [dockerfile for helm & GKE](https://hub.docker.com/r/devth/helm/dockerfile)
