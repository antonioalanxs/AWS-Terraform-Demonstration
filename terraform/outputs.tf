output "instance_name" {
  value = aws_instance.instance.tags["Name"]
}

output "instance_type" {
  value = aws_instance.instance.instance_type
}
