FROM wordpress:latest

RUN apt-get update && apt-get install -y --no-install-recommends git-core

RUN cd /tmp \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && composer require "phpunit/phpunit:~5.5.0" --prefer-source --no-interaction \
  && ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

RUN apt-get remove -y git-core \
  && apt-get autoremove -y \
  && apt-get clean

ENTRYPOINT ["/usr/local/bin/phpunit"]
