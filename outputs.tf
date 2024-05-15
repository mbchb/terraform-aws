# Output the allocated Elastic IP address
output "instance_eip_addresses" {
  description = "Elastic IP addresses associated with each EC2 instance"
  value = {
    for instance_name, instance in aws_instance.ec2_instances : instance_name => aws_eip_association.eip_association[instance_name].public_ip
  }
}


/*output "eip_address" {
  value = aws_eip.eip.public_ip
}


output "elastic_ips" {
  value = [for eip in aws_eip.eip : eip.id]
}
*/
