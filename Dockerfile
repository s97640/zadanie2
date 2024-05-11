FROM alpine:3.19.1 as builder

ARG VERSION

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs=20.12.1-r0 \
    npm=10.2.5-r0 && \
    rm -rf /etc/apk/cache

RUN addgroup -S node && \
    adduser -S node -G node

USER node

WORKDIR /home/node/app

COPY --chown=node:node index.js ./index.js
COPY --chown=node:node package.json ./package.json

RUN npm install

FROM node:iron-alpine3.19

ARG VERSION
ENV VERSION=${VERSION:-v0.1}

LABEL org.opencontainers.image.authors="Jakub Kopacki"
LABEL org.opencontainers.image.version="$VERSION"

RUN apk add --update --no-cache curl

USER node

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY --from=builder --chown=node:node /home/node/app/index.js ./index.js
COPY --from=builder --chown=node:node /home/node/app/node_modules ./node_modules

EXPOSE 3000

HEALTHCHECK --interval=4s --timeout=20s --start-period=2s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

ENTRYPOINT ["node", "index.js"]