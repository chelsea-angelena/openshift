###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine AS dev

WORKDIR /usr/src/app

COPY  package*.json ./

RUN npm ci

COPY  . .

EXPOSE 8081


###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine AS build

WORKDIR /usr/src/app

COPY  package*.json ./

COPY  --from=dev /usr/src/app/node_modules ./node_modules

COPY  . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --omit=dev



###################
# PRODUCTION
###################

FROM node:18-alpine AS production

COPY  --from=build /usr/src/app/node_modules ./node_modules
COPY  --from=build /usr/src/app/dist ./dist

CMD [ "node", "dist/main.js" ]
