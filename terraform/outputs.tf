output "container_names" {
  value = [
    docker_container.mongo.name,
    docker_container.backend.name
  ]
}

output "backend_url" {
  value = "http://localhost:3002"
}