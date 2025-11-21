## Use an official PHP image with Apache pre-installed
FROM php:8.3-apache

# Set the working directory to Apache's default document root
WORKDIR /var/www/html

# Copy your PHP application code from your host machine into the container
COPY . /var/www/html/

# The base image automatically starts the Apache server
# when the container runs. No CMD is strictly necessary.
