###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine AS dev

WORKDIR /app

COPY  package*.json .

COPY server.js .

RUN npm ci

COPY  . .

EXPOSE 3000


###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine AS build

WORKDIR /app

COPY  package*.json ./

COPY server.js .

COPY  --from=dev /app/node_modules ./node_modules

COPY  . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --omit=dev



###################
# PRODUCTION
###################

FROM node:18-alpine AS production

COPY  --from=build /app/node_modules ./node_modules
COPY  --from=build /app/build ./build
COPY --from=build /app/server.js .

CMD [ "node", "server.js" ]
