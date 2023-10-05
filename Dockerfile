FROM httpd:2.4
# Copy your custom index.html file into the Apache document root

RUN apt-get update && apt-get install -y vim
COPY index.html /usr/local/apache2/htdocs/
Expose 8080
