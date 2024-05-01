FROM alpine:3.16

ENV VERSION=3.3.0
ENV ARCH=amd64_linux
ENV DOMAIN=localhost
ENV LISTENPORT=8080
ENV SSHPORT=2022
ENV REVERSEPROXYPORT=2022

WORKDIR /app

RUN apk add ca-certificates wget unzip \
    && wget -q https://downloads.hak5.org/api/devices/cloudc2/firmwares/${VERSION}-stable -O cloudc2.zip \ 
    && unzip cloudc2.zip \
    && test "$(cat sha256sums | grep ${VERSION}_${ARCH})" = "$(sha256sum c2-${VERSION}_${ARCH})" && echo "Checksum valid" || exit 1 \
    && mkdir /db
    
CMD /app/c2-${VERSION}_${ARCH} -hostname ${DOMAIN} -listenport ${LISTENPORT} -sshport ${SSHPORT} -reverseProxy -reverseProxyPort ${REVERSEPROXYPORT} -db /db/c2.db

