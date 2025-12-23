FROM node:20-alpine AS builder
WORKDIR /app
COPY . .

FROM nginx:alpine
COPY --from=builder /app /usr/share/nginx/html
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]