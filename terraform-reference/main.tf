data "aws_connect_instance" "this" {
  instance_id = var.connect_instance_id
}

resource "aws_connect_contact_flow" "main_menu" {
  instance_id = data.aws_connect_instance.this.id
  name        = var.flow_name
  description = "IVR main menu - managed by Terraform (Kiro demo)"
  type        = "CONTACT_FLOW"

  content = templatefile("${path.module}/../flows/main-menu.json", {
    billing_queue_arn = var.billing_queue_arn
    general_queue_arn = var.general_queue_arn
  })

  tags = var.tags
}
