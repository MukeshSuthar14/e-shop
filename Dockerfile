# Use a base image that has PHP + nginx or php-fpm + web server
FROM richarvey/nginx-php-fpm:3.1.6

# Copy your repo contents
COPY . .

# (Optional) if you need to install npm & build assets
RUN apk update && \
    apk add --no-cache npm && \
    npm install && \
    npm run build

# Set appropriate environmental configurations
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel production config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer install
ENV COMPOSER_ALLOW_SUPERUSER 1

CMD ["/start.sh"]
