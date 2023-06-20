FROM golang:1.20 as builder

WORKDIR ${GOPATH:-/go}/src/kibble

COPY . .
RUN go mod download
RUN go get -d -v ./...

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${GOPATH:-/go}/bin/ ${GOPATH:-/go}/src/kibble/cmd/kibble

FROM centos:latest

COPY --from=builder ${GOPATH:-/go}/bin/kibble /

CMD ["/kibble"]
