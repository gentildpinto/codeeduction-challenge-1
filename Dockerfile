FROM golang:1.17-alpine as builder

WORKDIR /app
COPY . /app/

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

FROM scratch
COPY --from=builder /app/main /app/
WORKDIR /app
CMD [ "./main" ]
