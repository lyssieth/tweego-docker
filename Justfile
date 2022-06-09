push: build
    docker push lyssieth/tweego:latest

build:
    docker buildx build -t "lyssieth/tweego:latest" .
