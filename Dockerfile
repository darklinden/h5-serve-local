FROM nginx:alpine

COPY nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/media
COPY nginx/media/favicon.ico /etc/nginx/media/favicon.ico

RUN rm -rf /etc/nginx/conf.d/*
COPY nginx/conf.d/* /etc/nginx/conf.d/

COPY ssl /etc/nginx/ssl

RUN mkdir -p /usr/share/html
RUN rm -rf /usr/share/html/*
COPY test/index.html /usr/share/html/index.html

