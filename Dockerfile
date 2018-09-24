FROM wordpress:4.9.8-php7.2-apache

# WORKDIR /var/www/html

# RUN echo "define( 'WP_USE_THEMES', false );" >> wp-config.php 
# RUN echo "echo 'WP_USE_THEMES';" >> index.php 
# RUN touch xer.php

COPY startup.sh /usr/local/bin/
ADD content /usr/src/farma
# RUN echo "//de boas" >> /usr/src/wordpress/wp-config-sample.php
ENTRYPOINT [ "startup.sh" ]
CMD ["apache2-foreground"]