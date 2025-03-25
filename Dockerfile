# Build stage
FROM node:lts-alpine as build

ARG MODE=production
ENV NODE_ENV=$MODE

WORKDIR /app

COPY package*.json ./
RUN npm install --include=dev

COPY . .

RUN npm run build;

# Runtime stage with NGINX
FROM nginx as runtime
COPY --from=build /app/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d