output "contact_flow_id" {
  description = "ID of the deployed contact flow"
  value       = aws_connect_contact_flow.main_menu.contact_flow_id
}

output "contact_flow_arn" {
  description = "ARN of the deployed contact flow"
  value       = aws_connect_contact_flow.main_menu.arn
}
