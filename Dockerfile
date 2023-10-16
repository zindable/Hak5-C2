FROM alpine:3.16

ENV VERSION=3.3.0
ENV ARCH=amd64_linux

WORKDIR /app

RUN apk add ca-certificates wget unzip \
    && wget -q https://downloads.hak5.org/api/devices/cloudc2/firmwares/${VERSION}-stable -O cloudc2.zip \ 
    && unzip cloudc2.zip \
    && test "$(cat sha256sums | grep ${VERSION}_${ARCH})" = "$(sha256sum c2-${VERSION}_${ARCH})" && echo "Checksum valid" || exit 1 \
    && mkdir /db
    
CMD /app/c2-${VERSION}_${ARCH} -hostname localhost -reverseProxy -reverseProxyPort 8080 -db /db/c2.db

