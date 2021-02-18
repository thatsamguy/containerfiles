FROM amazon/opendistro-for-elasticsearch:1.13.0

ADD docker-entrypoint-patch.sh /

# Patch to allow setting ESOPT_cluster_name formatted env vars
RUN /docker-entrypoint-patch.sh && \
    rm -f /docker-entrypoint-patch.sh

CMD ["eswrapper"]
