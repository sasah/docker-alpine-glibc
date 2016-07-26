FROM alpine:latest

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

RUN GLIBC_VERSION="2.23-r3" && \

    apk --no-cache add --virtual .build-deps \
        wget \
        ca-certificates && \

    wget -nv -O /etc/apk/keys/sgerrand.rsa.pub https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/sgerrand.rsa.pub && \

    wget -nv https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
        https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk && \

    apk --no-cache add glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    echo "export LANG=en_US.UTF-8" > /etc/profile.d/locale.sh && \

    apk del glibc-bin glibc-i18n .build-deps && \

    rm -rvf /*.apk /etc/apk/keys/sgerrand.rsa.pub /root/.wget-hsts
