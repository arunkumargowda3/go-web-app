FROM golang:1.22.5 as arun
WORKDIR /app
#go.mod is like requrement.txt
COPY go.mod .

#it will download the dependines
RUN go mod download

COPY . .

#here main linke a artifact where we run the application .i.e main

RUN go build -o main .

#distrroless image

FROM gcr.io/distroless/base

COPY --from=arun /app/main .

COPY --from=arun /app/static ./static
EXPOSE 8080
CMD [ "./main" ]


