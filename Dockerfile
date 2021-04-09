FROM golang:1.16-alpine
RUN apk add --no-cache build-base make gcc git

RUN mkdir /sqldef && git -C /sqldef init
WORKDIR /sqldef
ENV VERSION master
RUN git remote add origin https://github.com/k0kubun/sqldef && \
  git fetch origin --depth=1 "$VERSION" && \
  git reset --hard FETCH_HEAD

RUN export GOPATH=/go/; \
  export GOBIN=$HOME/bin; \
  make all && sh -ec "mv build/*/mysqldef /usr/bin/ && mv build/*/psqldef /usr/bin/ && mv build/*/sqlite3def /usr/bin/"
