FROM wordpress:latest

# SETTINGS

# ENV WORDPRESS_CLI_VERSION 2.0.1
ENV DOCKERIZE_VERSION v0.6.1
# WordPress default settings
ENV WORDPRESS_URL 'http://localhost'
ENV WORDPRESS_TITLE 'WordPress Site'
ENV WORDPRESS_ADMIN_USER admin
ENV WORDPRESS_ADMIN_PASSWORD admin
ENV WORDPRESS_ADMIN_MAIL admin@example.com
ENV WORDPRESS_LANGUAGE pt_BR

# Install WP-CLI (http://wp-cli.org)
RUN curl -o /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /bin/wp

# Install dockerize (https://github.com/jwilder/dockerize)
# RUN curl -sL https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
#     | tar -C /usr/bin -xzvf - 

# Install Wait For It
RUN curl -o /bin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
  && chmod +x /bin/wait-for-it

COPY startup.sh /usr/local/bin/

ADD content /usr/src/farma


ENTRYPOINT [ "startup.sh" ]
CMD ["apache2-foreground"]