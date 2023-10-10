FROM golang:1.21-alpine3.18 AS build
RUN apk add gcc musl-dev
WORKDIR /src
RUN go install github.com/cespare/reflex@latest
COPY go.mod ./
RUN go mod download -x
COPY . .
RUN go build -o /app/whoami-go -ldflags "-s -w" .

FROM alpine:3.18
RUN apk --no-cache -U upgrade
WORKDIR /app
COPY --from=build /app/whoami-go .
USER guest
CMD ["/app/whoami-go"]
