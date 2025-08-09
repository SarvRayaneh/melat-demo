FROM registry.sarvrayaneh.com/test/nginx:stable-alpine

RUN chgrp -R 0 /var/cache/nginx /var/run /etc/nginx /usr/share/nginx/html && \
    chmod -R g=u /var/cache/nginx /var/run /etc/nginx /usr/share/nginx/html

COPY index.html /usr/share/nginx/html
COPY styles.css /usr/share/nginx/html
COPY logo.png /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
