resource "aws_sqs_queue" "queue" {
  for_each                   = var.sqs_queues
  name                       = lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
  delay_seconds              = lookup(each.value, "delay_seconds", null)
  max_message_size           = lookup(each.value, "max_message_size", null)
  message_retention_seconds  = lookup(each.value, "message_retention_seconds", null)
  receive_wait_time_seconds  = lookup(each.value, "receive_wait_time_seconds", null)
  visibility_timeout_seconds = lookup(each.value, "visibility_timeout_seconds", null)

  redrive_policy = lookup(each.value, "create_deadletter", false) ? jsonencode({
    deadLetterTargetArn = try(
      aws_sqs_queue.dead_letter_queue[each.key].arn,
      null
    )
    maxReceiveCount = lookup(each.value, "maxReceiveCount", null)
  }) : null
}

resource "aws_sqs_queue" "dead_letter_queue" {
  for_each = { for k, v in var.sqs_queues : k => v if lookup(v, "create_deadletter", false) }

  name                       = lookup(each.value, "name", null) == null ? "${each.key}-deadletter" : "${lookup(each.value, "name")}-deadletter"
  message_retention_seconds  = lookup(each.value, "message_retention_seconds", null)
  visibility_timeout_seconds = lookup(each.value, "visibility_timeout_seconds", null)
}