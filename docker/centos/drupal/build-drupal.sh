#!/bin/bash

# build drupal
composer create-project \
	drupal-composer/drupal-project:8.x-dev \
	/var/www/html \
	--stability dev \
	--no-interaction
