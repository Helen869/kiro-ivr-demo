variable "aws_region" {
  description = "AWS region of the Connect instance"
  type        = string
  default     = "us-east-1"
}

variable "connect_instance_id" {
  description = "Amazon Connect instance ID (UUID, not the alias)"
  type        = string
}

variable "flow_name" {
  description = "Name of the contact flow in Connect"
  type        = string
  default     = "MainMenu"
}

variable "billing_queue_arn" {
  description = "ARN of the queue callers reach when they press 1"
  type        = string
}

variable "general_queue_arn" {
  description = "ARN of the queue callers reach when they press 3"
  type        = string
}

variable "tags" {
  description = "Tags applied to the contact flow"
  type        = map(string)
  default = {
    ManagedBy = "terraform"
  }
}
