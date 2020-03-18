FROM nurwahid/landing_page

WORKDIR /usr/share/nginx/html
COPY . /usr/share/nginx/html

RUN ls
