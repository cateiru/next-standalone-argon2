# Based on https://github.com/vercel/next.js/tree/canary/examples/with-docker
FROM node:16-alpine AS builder
WORKDIR /app

COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN apk add gcc musl-dev libffi-dev python3

RUN yarn global add node-gyp

ENV CXX g++

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

# CMD ["node", "./.next/standalone/server.js"]

CMD yarn run start

# FROM node:16-alpine AS runner
# WORKDIR /app

# ENV NODE_ENV production

# RUN addgroup -g 1001 -S nodejs
# RUN adduser -S nextjs -u 1001

# COPY --from=builder /app/public ./public
# COPY --from=builder /app/package.json ./package.json
# COPY --from=builder /app/yarn.lock ./yarn.lock

# RUN apk --no-cache --virtual build-dependencies add \
#     git \
#     gcc \
#     && yarn global add node-gyp \
#     && apk del build-dependencies

# RUN apk add gcc clang

# COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
# COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# USER nextjs

# CMD ["node", "server.js"]
