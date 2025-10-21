#
# N8n Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:bookworm

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"
ENV NODE_MAJOR=22
ENV N8N_VERSION=1.117.0

# Install curl
RUN apt-get update && \
    apt-get install -y curl gnupg2 ca-certificates vim

# Fetch Nodejs repository
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Update & install packages for installing n8n
RUN apt-get update && \
    apt-get install -y nodejs
#
#Create n8n user
RUN adduser --uid 1000 --disabled-login --gecos 'N8n' n8n

# Install n8n
RUN npm install n8n -g

USER n8n

CMD ["n8n", "start"]
