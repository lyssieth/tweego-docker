FROM golang AS builder

RUN git clone https://github.com/tmedwards/tweego.git /tweego

WORKDIR /tweego

RUN go get

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-w'

RUN strip tweego

FROM gcr.io/distroless/static AS runner

COPY --from=builder /tweego/tweego /bin/tweego

ADD ./storyformats /usr/local/storyformats

ENV TWEEGO_PATH=/usr/local/storyformats

VOLUME [ "/work" ]
WORKDIR /work

ENTRYPOINT [ "tweego" ]
