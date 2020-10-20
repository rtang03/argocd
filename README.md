## Custom argocd docker image
Argo CD Custom Image for adding helm-secret plugin

```shell script
# naming convention v[Argo CD origin release]-rel.[revision number]
git tag v1.7.7-rel.1
git push origin v1.7.7-rel.1 
```

### External Reference
- [sample 1a: custom argocd](https://github.com/camptocamp/docker-argocd)
- [sample 1b: custom argocd example](https://github.com/camptocamp/argocd-helm-sops-example)
- [sample 2: custom argocd](https://medium.com/faun/handling-kubernetes-secrets-with-argocd-and-sops-650df91de173)
- [helm-secrets plugin](https://github.com/zendesk/helm-secrets)
- [sample 3: custom argocd](https://gitlab.com/iotops/container-images/argocd/-/blob/master/Dockerfile)
- [helm chart for argocd](https://github.com/argoproj/argo-helm/tree/master/charts/argo-cd)
- [dockerfile for helm & GKE](https://hub.docker.com/r/devth/helm/dockerfile)
