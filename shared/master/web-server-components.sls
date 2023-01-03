{% if grains['os_family'] == 'RedHat' %}
{%   set vpackage = 'httpd' %}
{% else %}
{%   set vpackage = 'apache2' %}
{% endif %}

stop_selinux:
  cmd.run:
    - name: sudo setenforce 0

install.webserver:
  pkg:
    - name: {{ vpackage }}
    - installed

install.php:
  pkg.installed:
    - pkgs:
      - php
      - php-mysqlnd
      - policycoreutils
      - policycoreutils-python-utils

/var/www/html:
  file.recurse:
    - source: salt://bgapp/web

run.webserver:
  service.running:
    - name: {{ vpackage }}
    - require:
      - pkg: {{ vpackage }}

allow.port:
  firewalld.present:
    - name: public
    - ports:
      - 80/tcp
