# provider region
variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-2"
  type        = string
}

# vpc cidr block
variable "vpc_cidr_block" {
  description = "making vpc cidr block a variable"
  default     = "10.0.0.0/16"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "making vpc instance_tenancy a variable"
  default     = "default"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "making enable dns hostnames a variable"
  default     = true
  type        = bool
}

variable "enable_dns_support" {
  description = "making enable dns support a variable"
  default     = true
  type        = bool
}

variable "production_vpc_name" {
  description = "making ecs_vpc_name a variable"
  default     = "ecs_vpc"
  type        = string
}

variable "public_subnet-1" {
  description = "making tag a variable"
  default     = "public_subnet-1"
  type        = string
}

variable "public_subnet-2" {
  description = "making tag a variable"
  default     = "public_subnet-2"
  type        = string
}

variable "private_subnet-1" {
  description = "making tag a variable"
  default     = "private_subnet-1"
  type        = string
}

variable "private_subnet-2" {
  description = "making tag a variable"
  default     = "private_subnet-2"
  type        = string
}

# publiic subnets
variable "public_subnet-1_cidr_block" {
  description = "making enable pub sub1 cidr block a variable"
  default     = "10.0.1.0/24"
  type        = string
}

variable "public_subnet-1_availability_zonea" {
  description = "making pub sub1 availability zone a variable"
  default     = "eu-west-2a"
  type        = string
}

variable "public_subnet-1_map_public_ip_on_launch" {
  description = "making web sub1 map_public_ip_on_launch a variable"
  default     = true
  type        = bool
}

variable "public_subnet-2_cidr_block" {
  description = "making web sub2 cidr_block a variable"
  default     = "10.0.2.0/24"
  type        = string
}

variable "public_subnet-2_availability_zoneb" {
  description = "making pub sub2 availability_zone a variable"
  default     = "eu-west-2b"
  type        = string
}

variable "public_subnet-2_map_public_ip_on_launch" {
  description = "making pub sub2 map_public_ip_on_launch a variable"
  default     = true
  type        = bool
}

# Private Subnets
variable "private_subnet-1_cidr_block" {
  description = "making priv sub1 cidr block a variable"
  default     = "10.0.3.0/24"
  type        = string
}

variable "private_subnet-1_availability_zonea" {
  description = "making priv sub1 availability zone a variable"
  default     = "eu-west-2a"
  type        = string
}

variable "private_subnet-2_cidr_block" { #database subnet
  description = "making priv sub2 cidr block a variable"
  default     = "10.0.4.0/24"
  type        = string
}

variable "private_subnet-2_availability_zoneb" {
  description = "making priv sub2 availability zone a variable"
  default     = "eu-west-2b"
  type        = string
}

variable "igw" {
  description = "making igw name a variable"
  default     = "igw"
  type        = string
}

variable "ngw_name" {
  description = "making ngw name a variable"
  default     = "ngw"
  type        = string
}
# Elastic ip

variable "elastic-ip-for-nat-gateway" {
  description = "making eip a variable"
  default     = "10.0.0.6"
  type        = string
}

#ecs
variable "ecs_cluster_name" {
  description = "making cluster name a variable"
  default     = "EcsCluster"
  type = string
}


#NAT
variable "nat-gateway-destination-cidr-block" {
  description = "making nat destinatioon cidr block a variable"
  default     = "0.0.0.0/0"
  type        = string
}

# load balancer

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/ping/"
}

variable "publicalbname" {
  description = "making albname a variable"
  default     = "Internet-Facing"
  type        = string
}

variable "internal" {
  description = "making internal alb a variable"
  default     = false
  type        = bool
}

variable "ipaddresstype" {
  description = "making internal alb a variable"
  default     = "ipv4"
  type        = string
}

variable "loadbalancertype" {
  description = "making loadbalancer type a variable"
  default     = "application"
  type        = string
}

variable "enabledeletionprotection" {
  description = "making deletion protection a variable"
  default     = false
  type        = bool
}

variable "listener_port" {
  description = "making port a variable"
  default     = 80
  type        = number
}

variable "alb_http_ingress_port" {
  description = "making port a variable"
  default     = 80
  type        = number
}

variable "alb_https_ingress_port" {
  description = "making port a variable"
  default     = 443
  type        = number
}


variable "protocol" {
  description = "making protocol a variable"
  default     = "HTTP"
  type        = string
}

variable "default_action_type" {
  description = "making default action a variable"
  default     = "forward"
  type        = string
}

variable "enablehealthcheck" {
  description = "making healthcheck a variable"
  default     = true
  type        = bool
}

variable "healthcheckinterval" {
  description = "making interval a variable"
  default     = 5
  type        = number
}

variable "healthcheckport" {
  description = "making healthcheck port a variable"
  default     = "80"
  type        = string
}

variable "healthchecktimeout" {
  description = "making timeout a variable"
  default     = 2
  type        = number
}

variable "healthythreshold" {
  description = "making healthythreshold a variable"
  default     = 5
  type        = number
}

variable "unhealthythreshold" {
  description = "making healthythreshold a variable"
  default     = 2
  type        = number
}

variable "healthcheckmatcher" {
  description = "making matcher a variable"
  default     = "200"
  type        = string
}

variable "healthcheckname" {
  description = "making name a variable"
  default     = "ecsproject"
  type        = string
}

variable "target-type" {
  description = "making target type a variable"
  default     = "ip"
  type        = string
}

variable "traffic-port" {
  description = "making port after target type a variable"
  default     = 80
  type        = number

  }
variable "certificate_arn" {
  description = "making certificate arnype a variable"
  default     = "aws_acm_certificate.e-learning.arn"
  type        = string

  }

#rds postgres

variable "public_access" {
  description = "make choosing public access a variable"
  default     = false
  type        = bool
}

variable "rds_db_name" {
  description = "RDS database name"
  default     = "mydb"
  type        = string
}
variable "rds_username" { 
  description = "Making rds username a variable"
  default     = "yougotitwrong$"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "AWS RDS Database Administrator Password"
  default     = "Kobby"
  type        = string
  sensitive   = true
}
variable "rds_instance_class" {
  description = "RDS instance type"
  default     = "db.t3.micro"
  type        = string
}

variable "db_identifier" {
  description = "Making identifier a variable"
  default     = "postgres"
  type        = string
}

variable "rds_port" {
  description = "RDS instance type"
  default     = 5432
  type        = number
}

variable "engine" {
  description = "making engine a variable"
  default     = "postgres"
  type        = string
}


variable "engine_version" {
  description = "making engine version a variable"
  default     = "13.3"
  type        = string
}

variable "db_storage" {
  description = "making allocated storage a variable"
  default     = 20
  type        = number
}

variable "storage_type" {
  description = "making storage encruption a variable"
  default     = "gp2"
  type        = string
}

variable "storage_encrypted" {
  description = "making storage encryption a variable"
  default     = false
  type        = bool
}

variable "multi_az" {
  description = "making storage encryption a variable"
  default     = false
  type        = bool
}

variable "backup_retention_period" {
  description = "making backup retention period a variable"
  default     = 7
  type        = number
}

variable "skip_final_snapshot" {
  description = "making snapshot a variable"
  default     = true
  type        = bool
}
#envrionment
# Making tag name variable
variable "envrionment_name" {
  description = "making environment name a variable"
  default     = "Development"
  type        = string
}
