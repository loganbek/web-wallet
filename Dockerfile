FROM node:12.16.1-alpine3.11

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh make gcc g++ python

RUN addgroup -g 10000 -S omg && \
    adduser -u 10000 -S omg -G omg
USER omg
WORKDIR /home/omg

COPY package.json .
COPY yarn.lock .
RUN yarn install

COPY . .
RUN yarn build

EXPOSE 3000
CMD ["yarn", "serve"]
