# change 
FROM golang:{GO_VERSION} as base

FROM base as dev

RUN curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh -s -- -b $(go env GOPATH)/bin

WORKDIR /opt/app

RUN go install github.com/go-delve/delve/cmd/dlv@latest

CMD ["air"]
EXPOSE {GO_PORT} 2345