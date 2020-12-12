FROM k8sathome/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

USER root

RUN \
  apt-get -qq update \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='amd64' ;; \
    'linux/arm64') export ARCH='arm64' ;; \
    'linux/arm/v7') export ARCH='armhf' ;; \
  esac \
  && \
  curl -fsSL -o /tmp/resilio-sync.deb \
    "https://download-cdn.resilio.com/${VERSION}/Debian/resilio-sync_${VERSION}-1_${ARCH}.deb" \
  && \
  dpkg -i /tmp/resilio-sync.deb \
  && \
  rm -rf /tmp/resilio-sync.deb \
  && echo "UpdateMethod=docker\nBranch=develop\nPackageVersion=${VERSION}\nPackageAuthor=[Team k8s-at-home](https://github.com/k8s-at-home)" > /app/package_info \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && echo umask ${UMASK} >> /etc/bash.bashrc \
  && update-ca-certificates

USER kah

EXPOSE 8888 55555

COPY ./resilio-sync/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
