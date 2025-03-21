variable "vpc_name" {
  description = "EC2가 존재할 VPC의 이름"
  type        = string
}

variable "vpc_id" {
  description = "EC2가 존재할 VPC의 ID"
  type        = string
}

variable "subnet_id_map" {
  description = "서브넷 ID 맵 데이터"
  type        = map(map(string))
}

variable "sg_id_map" {
  description = "보안 그룹 ID 맵 데이터"
  type        = map(string)
}

variable "ec2_set" {
  description = "EC2별 명세 Set"
  type = map(object({
    # required
    env             = string
    team            = string
    service         = string
    ami_id          = string
    instance_type   = string
    subnet          = string
    az              = string
    security_groups = list(string)
    # optional
    os_type    = optional(string, "linux")
    ec2_key    = optional(string)
    ec2_role   = optional(string)
    private_ip = optional(string)
    # volumes
    root_volume = object({
      size = number
      type = optional(string, "gp3")
    })
    additional_volumes = optional(list(object({
      device = string
      size   = number
      type   = optional(string, "gp3")
      iops   = optional(number)
    })), [])
  }))
}

variable "tags" {
  description = "모든 리소스에 적용될 태그 (map)"
  type        = map(string)
  default     = {}
}
