# Rozszerzony frontend
# syntax=docker/dockerfile:1.3

# Etap pierwszy - budowa aplikacji
FROM alpine:3.19.1 as builder

# Zmienna VERSION przekazywana do procesu budowy obrazu 
ARG VERSION

# Aktualizacja i instalacja potrzebnych pakietów
RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs=20.12.1-r0 \
    npm=10.2.5-r0 \
    openssh-client \
    git && \
    rm -rf /etc/apk/cache

# Skanowanie kluczy publicznych github
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts 

# Klonowanie repozytorium z kodem aplikacji za pomocą klucza prywatnego
RUN --mount=type=ssh,id=hpl21git git clone git@github.com:s97640/zadanie1.git tempDir

# Przejście do katalogu z kodem aplikacji
WORKDIR /tempDir

# Instalacja zależności
RUN npm install

# Etap drugi - uruchomienie aplikacji
FROM node:iron-alpine3.19

# Powtórzenie deklaracji zmiennej VERSION, aby wpisać ją w metadane obrazu
ARG VERSION
ENV VERSION=${VERSION:-v0.1}

# Metadane obrazu
LABEL org.opencontainers.image.title="Zadanie 1"
LABEL org.opencontainers.image.authors="Jakub Kopacki"
LABEL org.opencontainers.image.version="$VERSION"

# Instalacja curl
RUN apk add --update --no-cache curl

# Przejście na użytkownika node
USER node

# Utworzenie katalogu na aplikację
RUN mkdir -p /home/node/app

# Przejście do katalogu z aplikacją
WORKDIR /home/node/app

# Kopiowanie plików z etapu pierwszego
COPY --from=builder --chown=node:node /tempDir/index.js ./index.js
COPY --from=builder --chown=node:node /tempDir/node_modules ./node_modules

# Deklaracji portu aplikacji w kontenerze
EXPOSE 3000

# Monitorowanie stanu aplikacji
HEALTHCHECK --interval=4s --timeout=20s --start-period=2s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

# Uruchomienie aplikacji
ENTRYPOINT ["node", "index.js"]