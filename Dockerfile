FROM nginx:alpine

COPY nginx/nginx.conf  /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/*
COPY nginx/conf.d/* /etc/nginx/conf.d/
COPY ssl /etc/nginx/ssl

