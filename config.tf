provider "docker" {
  host = "tcp://192.168.64.180:2376/"
}

resource "docker_image" "nginx" {
  name = "nginx:1.11-alpine"
}

resource "docker_container" "nginx-server" {
  name = "nginx-server"
  image = "${docker_image.nginx.latest}"
  ports {
    internal = 80
  }
  volumes {
    container_path  = "/usr/share/nginx/html"
    host_path = "/home/scrapbook/tutorial/www"
    read_only = true
  }
}
