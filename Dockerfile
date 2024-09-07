FROM nginx:alpine

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/conf.d/http-server.conf /etc/nginx/conf.d/http-server.conf
COPY nginx/ssl /etc/nginx/ssl

