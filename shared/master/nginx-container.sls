run.nginx.container:
  docker_container.running:
    - image: nginx:latest
    - name: slat-nginx
    - port_bindings:
        - 80:80