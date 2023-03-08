resource "aws_sqs_queue" "queue" {
  count                      = length(var.sqs_queues)
  name                       = var.sqs_queues[count.index].name
  delay_seconds              = var.sqs_queues[count.index].delay_seconds
  max_message_size           = var.sqs_queues[count.index].max_message_size
  message_retention_seconds  = var.sqs_queues[count.index].message_retention_seconds
  receive_wait_time_seconds  = var.sqs_queues[count.index].receive_wait_time_seconds
  visibility_timeout_seconds = var.sqs_queues[count.index].visibility_timeout_seconds
  redrive_policy = var.sqs_queues[count.index].create_dead_letter ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue[count.index].arn
    maxReceiveCount     = var.sqs_queues[count.index].redrive_policy.max_receive_count
  }) : null

}

resource "aws_sqs_queue" "dead_letter_queue" {
  count = length([for q in var.sqs_queues : q.redrive_policy if q.redrive_policy != null])

  name                       = var.sqs_queues[count.index].redrive_policy.dead_letter_queue
  message_retention_seconds  = var.sqs_queues[count.index].redrive_policy.dead_letter_queue_message_retention_seconds
  visibility_timeout_seconds = var.sqs_queues[count.index].redrive_policy.visibility_timeout_seconds
}