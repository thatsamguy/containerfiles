FROM public.ecr.aws/amazonlinux/amazonlinux:latest

ENV HONEY_VERSION "1.4.2"
ENV HONEY_ARCH "amd64"

RUN curl -sL https://github.com/honeycombio/honeyaws/releases/download/v${HONEY_VERSION}/honeycloudfront-linux-${HONEY_ARCH} --output honeycloudfront
RUN curl -sL https://github.com/honeycombio/honeyaws/releases/download/v${HONEY_VERSION}/honeytrail-linux-${HONEY_ARCH} --output honeytrail
RUN curl -sL https://github.com/honeycombio/honeyaws/releases/download/v${HONEY_VERSION}/honeyalb-linux-${HONEY_ARCH} --output honeyalb
RUN curl -sL https://github.com/honeycombio/honeyaws/releases/download/v${HONEY_VERSION}/honeyelb-linux-${HONEY_ARCH} --output honeyelb
RUN chmod 755 ./honey* && mv -v honey* /usr/local/bin/
