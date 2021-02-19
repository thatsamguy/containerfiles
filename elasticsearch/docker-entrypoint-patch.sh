#!/usr/bin/env bash
cp -f /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh.orig && \
head -n -1 /usr/local/bin/docker-entrypoint.sh.orig > /usr/local/bin/docker-entrypoint.sh && \
{
cat <<EOF
# Also expand env vars in the format:
#  ESOPT_cluster_name
# to
#  -Ecluster.name
while IFS='=' read -r envvar_key envvar_value
do
    # Elasticsearch settings need to have at least two dot separated lowercase
    # words, e.g. 'cluster.name', except for 'processors' which we handle
    # specially
    if [[ "\$envvar_key" =~ ^ESOPT_[a-z0-9_]+\_[a-z0-9_]+ || "\$envvar_key" == "ESOPT_processors" ]]; then
        if [[ ! -z \$envvar_value ]]; then
            envvar_real_key="$(echo "\${envvar_key}" | cut -c7-256 | sed '0,/_/s//./' )"
            es_opt="-E\${envvar_real_key}=\${envvar_value}"
            es_opts+=("\${es_opt}")
        fi
    fi
done < <(env)

# echo out final command
set -x
EOF
} >> /usr/local/bin/docker-entrypoint.sh && \
tail -n 1 /usr/local/bin/docker-entrypoint.sh.orig >> /usr/local/bin/docker-entrypoint.sh && \
rm -f /usr/local/bin/docker-entrypoint.sh.orig
