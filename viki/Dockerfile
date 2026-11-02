# VIKI — pi-backed Slack Code agent.
#
# The image carries:
#   - the Bolt JS glue (Socket Mode; no public ports)
#   - the pi CLI (baked config under /opt/viki/pi → Bifrost)
#   - the slack-code pi extension (loaded via --extension by the worker)
#
# Secrets are environment only (see src/nomad-jobs/viki.hcl): SLACK_* tokens,
# GitHub credentials (read-only in v1), nothing baked in.

# Debian 12 (bookworm); the explicit -bookworm tag was removed from Docker Hub.
FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        openssh-client \
        procps \
        curl \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# pi CLI, pinned (the extension is written against its API surface).
RUN npm install -g @earendil-works/pi-coding-agent@1.4.0

# Non-root: the pi config dir and the workspaces root are the only writable
# places the process needs.
RUN useradd --create-home --shell /usr/sbin/nologin viki \
    && mkdir -p /opt/viki /workspaces \
    && chown viki:viki /opt/viki /workspaces

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev && chown -R viki:viki /app

# pi config: models.json (Bifrost provider) + settings.json (xhigh thinking).
# The agent dir is PI_CODING_AGENT_DIR so pi never touches the host home.
COPY pi/ /opt/viki/pi/
COPY extensions/ /opt/viki/extensions/
COPY app.js ./
COPY listeners/ listeners/
COPY src/ src/
COPY scripts/ scripts/
RUN chown -R viki:viki /opt/viki

ENV PI_CODING_AGENT_DIR=/opt/viki/pi
ENV VIKI_EXTENSION_PATH=/opt/viki/extensions/slack-code/index.ts

USER viki
ENTRYPOINT ["node", "app.js"]
