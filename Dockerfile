ARG NODE_ENV=production

FROM node:18-slim as builder

ENV NODE_ENV=${NODE_ENV}


RUN apt update && \
    apt dist-upgrade -y

WORKDIR /srv

COPY ./package.json ./package-lock.json /srv

RUN npm install --production

# ================================================

ARG NODE_ENV=production

FROM node:18-slim

ENV NODE_ENV=${NODE_ENV}

RUN apt-get update &&  \
    apt-get install -y libvips-dev make curl git tini && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget curl lsb-release && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv

COPY ./ /srv
COPY --from=builder /srv/node_modules /srv/node_modules

RUN npm run build

EXPOSE 1337

ENTRYPOINT ["tini", "--", "/srv/entrypoint.sh"]
