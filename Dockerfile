FROM alpine:3.10
WORKDIR /app
RUN apk add --update --no-cache make gcc musl-dev
COPY Makefile tiny.c ./
RUN make
RUN rm tiny.c Makefile
RUN chmod +x tiny 

FROM alpine:3.10
ENV htdocs=/htdocs
COPY --from=0 /app/tiny /bin/tiny
EXPOSE 9999/tcp
CMD ["/bin/tiny", "$htdocs", "9999"]
