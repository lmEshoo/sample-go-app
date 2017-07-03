FROM golang:1.9-alpine

ADD . /go

ENTRYPOINT go run sample.go

EXPOSE 5200
