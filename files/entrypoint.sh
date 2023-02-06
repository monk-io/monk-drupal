#!/usr/bin/env bash

if [[ ! -f /.init ]]; then
  cp /opt/drupal/web/sites/default/default.settings.php.monk /opt/drupal/web/sites/default/settings.php
  chmod 666 /opt/drupal/web/sites/default/settings.php
  touch /.init
fi

apache2-foreground
