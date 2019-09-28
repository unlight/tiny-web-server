FROM alpine:3.10
WORKDIR /app
RUN apk add --update --no-cache make gcc musl-dev
COPY Makefile tiny.c ./
RUN make
RUN rm tiny.c Makefile
RUN chmod +x tiny 

FROM scratch
COPY --from=0 /app/tiny /app/main
EXPOSE 9999/tcp
CMD ["/app/main"]
