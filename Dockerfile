FROM argoproj/argocd:v1.7.7

LABEL org.opencontainers.image.source https://github.com/rtang03/argocd

ARG SOPS_VERSION="v3.6.1"
ARG HELM_SECRETS_VERSION="2.0.2"
ENV PATH=/home/argocd/google-cloud-sdk/bin:$PATH \
    CLOUDSDK_PYTHON_SITEPACKAGES=1 \
    GOOGLE_APPLICATION_CREDENTIALS=/app/config/gcp/kms-service-account.json

USER root
COPY helm-wrapper /usr/local/bin/

RUN apt-get update && \
    apt-get install -y curl gpg wget ca-certificates zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip && \
    google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=.bashrc && \
    google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux && \
    chmod +x /usr/local/bin/sops && \
    cd /usr/local/bin && \
    mv helm helm.bin && \
    mv helm2 helm2.bin && \
    mv helm-wrapper helm && \
    ln helm helm2 && \
    chmod +x helm helm2

# helm secrets plugin should be installed as user argocd or it won't be found
USER argocd
RUN /usr/local/bin/helm.bin plugin install https://github.com/zendesk/helm-secrets --version ${HELM_SECRETS_VERSION}
ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
