variable "region" {
  type        = string
  description = "AWS Region"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of availability zones in which to provision VPC subnets"
}

variable "region_availability_zones" {
  type        = list(string)
  default     = []
  description = "List of availability zones in region, to be used as default when `availability_zones` is not supplied"
}

variable "ipv4_primary_cidr_block" {
  type        = string
  description = <<-EOT
    The primary IPv4 CIDR block for the VPC.
    Either `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both.
    EOT
  default     = null
}

variable "nat_gateway_enabled" {
  type        = bool
  description = "Flag to enable/disable NAT gateways"
}

variable "nat_instance_enabled" {
  type        = bool
  description = "Flag to enable/disable NAT instances"
}

variable "nat_instance_type" {
  type        = string
  description = "NAT Instance type"
  default     = "t3.micro"
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = true
  description = "Instances launched into a public subnet should be assigned a public IP address"
}

variable "subnet_type_tag_key" {
  type        = string
  description = "Key for subnet type tag to provide information about the type of subnets, e.g. `cpco/subnet/type=private` or `cpcp/subnet/type=public`"
}

variable "max_subnet_count" {
  type        = number
  default     = 0
  description = "Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availability zone (in `region_availability_zones` variable) within the region"
}

variable "vpc_flow_logs_enabled" {
  type        = bool
  description = "Enable or disable the VPC Flow Logs"
  default     = true
}

variable "vpc_flow_logs_traffic_type" {
  type        = string
  description = "The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL`"
  default     = "ALL"
}

variable "vpc_flow_logs_log_destination_type" {
  type        = string
  description = "The type of the logging destination. Valid values: `cloud-watch-logs`, `s3`"
  default     = "s3"
}

variable "vpc_flow_logs_bucket_environment_name" {
  type        = string
  description = "The name of the environment where the VPC Flow Logs bucket is provisioned"
  default     = ""
}

variable "vpc_flow_logs_bucket_stage_name" {
  type        = string
  description = "The stage (account) name where the VPC Flow Logs bucket is provisioned"
  default     = ""
}

variable "vpc_flow_logs_bucket_tenant_name" {
  type        = string
  description = <<-EOT
  The name of the tenant where the VPC Flow Logs bucket is provisioned.

  If the `tenant` label is not used, leave this as `null`.
  EOT
  default     = null
}

variable "ec2_vpc_endpoint_enabled" {
  type        = bool
  description = "Enable or disable an EC2 interface VPC Endpoint in this VPC."
  default     = false
}

variable "nat_eip_aws_shield_protection_enabled" {
  type        = bool
  description = "Enable or disable AWS Shield Advanced protection for NAT EIPs. If set to 'true', a subscription to AWS Shield Advanced must exist in this account."
  default     = false
}

variable "eks_tags_enabled" {
  type        = bool
  description = "Whether or not to apply EKS-releated tags to resources"
  default     = false
}

variable "eks_component_names" {
  type        = set(string)
  description = "The names of the eks components"
  default     = ["eks/cluster"]
}

variable "ipv4_primary_cidr_block_association" {
  type = object({
    # ipv4_ipam_pool_id   = string
    ipv4_netmask_length = number
  })
  description = <<-EOT
    Configuration of the VPC's primary IPv4 CIDR block via IPAM. Conflicts with `ipv4_primary_cidr_block`.
    One of `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set.
    Additional CIDR blocks can be set via `ipv4_additional_cidr_block_associations`.
    EOT
  default     = null
}
