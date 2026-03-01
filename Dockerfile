FROM golang:1.23 AS build
WORKDIR /app
COPY go.mod main.go templates/ ./
RUN CGO_ENABLED=0 go build -o myapp .

FROM scratch
COPY --from=build /app/myapp /
COPY --from=build /app/templates/ ./templates/
ENTRYPOINT ["/myapp"]
