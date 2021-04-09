FROM golang:buster
RUN apt-get update && apt-get install make git

RUN mkdir /sqldef && git -C /sqldef init
WORKDIR /sqldef
ARG VERSION
RUN git remote add origin https://github.com/k0kubun/sqldef && \
  git fetch origin --depth=1 "${VERSION:-master}" && \
  git reset --hard FETCH_HEAD

RUN export GOPATH=/go/; \
  export GOBIN=$HOME/bin; \
  make all && sh -ec "mv build/*/mysqldef /usr/bin/ && mv build/*/psqldef /usr/bin/ && mv build/*/sqlite3def /usr/bin/"
