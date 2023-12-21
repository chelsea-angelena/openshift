###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine AS dev

WORKDIR /app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD ["npm", "run", "start"]

###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine AS build

WORKDIR /app

COPY --chown=node:node package*.json ./

COPY --chown=node:node --from=development /app/node_modules ./node_modules

COPY --chown=node:node . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --only=production && npm cache clean --force

USER node

###################
# PRODUCTION
###################

FROM node:18-alpine AS production

COPY --chown=node:node --from=build /app/node_modules ./node_modules
COPY --chown=node:node --from=build /app/build ./build

CMD [ "npm", "run", "start:prod" ]
