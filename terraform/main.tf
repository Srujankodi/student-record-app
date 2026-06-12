terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_network" "student_network" {
  name = "student-record-network"
}

resource "docker_container" "mongo" {
  name  = "tf-student-mongo"
  image = "mongo:5"

  ports {
    internal = 27017
    external = 27018
  }

  networks_advanced {
    name = docker_network.student_network.name
  }
}

resource "docker_image" "backend_image" {
  name = "student-backend:terraform"
  build {
    context = "../backend"
  }
}

resource "docker_container" "backend" {
  name  = "tf-student-backend"
  image = docker_image.backend_image.name

  ports {
    internal = 3001
    external = 3002
  }

  env = [
    "PORT=3001",
    "MONGO_URI=mongodb://tf-student-mongo:27017/studentdb"
  ]

  networks_advanced {
    name = docker_network.student_network.name
  }

  depends_on = [docker_container.mongo]
}