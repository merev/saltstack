install.mariadb:
  pkg.installed:
    - pkgs:
      - mariadb-client
      - mariadb-server

config.db:
  file.line:
    - name: /etc/mysql/mariadb.conf.d/50-server.cnf
    - content: 'bind-address = 0.0.0.0'
    - mode: replace
    - match: bind-address

/tmp:
  file.recurse:
    - source: salt://bgapp/db/

import.db:
  cmd.run:
    - name: mysql -u root --default-character-set='utf8' < /tmp/db_setup.sql

start.mariadb.service:
  service.running:
    - name: mariadb
