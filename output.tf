output "jenkins_public_ip" {
  description = "List of public IP addresses assigned to the Master Node, if applicable"
  value       = aws_instance.jenkins.public_ip
}

output "webserver_public_ip" {
  description = "List of public IP addresses assigned to the Master Node, if applicable"
  value       = aws_instance.webserver.public_ip
}

/*output "woker_node_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_instance.worker.*.public_ip}"]
}*/

