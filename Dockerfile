FROM node:10-alpine

LABEL maintaner="jaruba"
LABEL description="Docker container to run RPDB Folders"

ARG version=0.2.5

RUN apk update && \
    apk --no-cache add git && \
    apk --no-cache add util-linux && \
    apk --no-cache add --virtual builds-deps build-base python

WORKDIR /app

RUN git clone -b main https://www.github.com/jaruba/rpdb-folders.git && \
    mkdir -p /rpdb/config && \
    mkdir -p /rpdb/mounts && \
    cd rpdb-folders && \
    echo bW9kdWxlLmV4cG9ydHMgPSB7IGtleTogJzA1OTAxY2RlYzVmYWFkNGRjODFjYWI1NTY5ZTg1MzhjJyB9 | base64 -d > tmdbKey.js && \
    npm install --production

WORKDIR /app/rpdb-folders

VOLUME ["/rpdb/config"]
VOLUME ["/rpdb/mounts"]
RUN npm i -f
EXPOSE 8750
USER 1000
CMD ["npm", "start"]
