FROM golang:1.12.1-alpine as builder
WORKDIR /go/src/github.com/apanagiotou/hmq/
RUN apk add git
RUN apk add build-base
COPY . .
ENV GO111MODULE=on
RUN GOOS=linux go build -a -o gateway .
ENTRYPOINT ["./gateway"]

FROM alpine:edge
WORKDIR /root
COPY --from=builder /go/src/github.com/apanagiotou/hmq/gateway .
EXPOSE 1883
EXPOSE 1888
EXPOSE 8883
EXPOSE 1993

ENTRYPOINT ["/root/gateway"]
