FROM public.ecr.aws/amazonlinux/amazonlinux:latest AS build

RUN curl -sL https://honeycomb.io/download/honeyaws/v1.4.0/honeycloudfront-linux-amd64 --output honeycloudfront && \
    echo '5ba3bc3c9972f45ada7a9bf82dcd27ac05dc0af75a7361a28178478909c8a648  honeycloudfront' | sha256sum -c
RUN curl -sL https://honeycomb.io/download/honeyaws/v1.4.0/honeycloudtrail-linux-amd64 --output honeycloudtrail && \
    echo '45bc50eeb40bc8705057c6e04ae9bc44fc2efa9cdbe6a851f0b3e02a45484523  honeycloudtrail' | sha256sum -c
RUN curl -sL https://honeycomb.io/download/honeyaws/v1.4.0/honeyalb-linux-amd64 --output honeyalb && \
    echo 'f03c3199b8284743b9f40ee717628d1737be8b9dcceeb2bc604464896870b2de  honeyalb' | sha256sum -c
RUN curl -sL https://honeycomb.io/download/honeyaws/v1.4.0/honeyelb-linux-amd64 --output honeyelb && \
    echo '01629098f45d1ae5a59b37e73bcf7e10a96ddcc171e5dd38b726cb07f9c9c959  honeyelb' | sha256sum -c
RUN chmod 755 ./honey*

FROM public.ecr.aws/lts/ubuntu:20.04
COPY --from=build honey* /usr/local/bin/
