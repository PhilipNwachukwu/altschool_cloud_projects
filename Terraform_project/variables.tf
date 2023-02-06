variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS Region to use for resources"
  default     = "eu-west-2"
}

variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for AWS VPC"
  default     = "10.0.0.0/16"
}

variable "subnets_cidr" {
  type        = list(string)
  description = "cidr block for AWS VPC subnets"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnames in VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public ip address to subnet instances"
  default     = true
}

variable "apache_sg_name" {
  type        = string
  description = "Security group name for EC2 instances"
}

variable "apache_lb_sg_name" {
  type        = string
  description = "Security group name for Load balancer"
}

variable "instance_type" {
  type        = string
  description = "AWS EC2 instance size"
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Philmatrix"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}

variable "lb_name" {
  type        = string
  description = "Name of Load Balancer"
}

variable "lb_type" {
  type        = string
  description = "Type of load balancer"
}

variable "lb_target_group_name" {
  type        = string
  description = "Name of load balancer target group"
}

variable "lb_target_group_protocol" {
  type        = string
  description = "Network protocol for load balancer target group"
}

variable "lb_target_group_port" {
  type        = number
  description = "Network port for load balancer target group"
}

variable "lb_listener_port" {
  type        = number
  description = "Network port for load balancer listener"
}

variable "lb_listener_protocol" {
  type        = string
  description = "Network protocol for load balancer listener"
}

variable "lb_target_group_attachment_port" {
  type        = number
  description = "Network port for load balancer target group"
}

