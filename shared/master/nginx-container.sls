run.nginx.container:
  docker_container.running:
    - image: nginx:latest
    - name: salt-nginx
    - port_bindings:
        - 80:80
