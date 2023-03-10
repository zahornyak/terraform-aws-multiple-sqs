resource "aws_sqs_queue" "queue" {
  count = length(var.sqs_queues)

  name = var.sqs_queues[count.index].name

  delay_seconds              = var.sqs_queues[count.index].delay_seconds != null ? var.sqs_queues[count.index].delay_seconds : 0
  max_message_size           = var.sqs_queues[count.index].max_message_size != null ? var.sqs_queues[count.index].max_message_size : 262144
  message_retention_seconds  = var.sqs_queues[count.index].message_retention_seconds != null ? var.sqs_queues[count.index].message_retention_seconds : 345600
  receive_wait_time_seconds  = var.sqs_queues[count.index].receive_wait_time_seconds != null ? var.sqs_queues[count.index].receive_wait_time_seconds : 0
  visibility_timeout_seconds = var.sqs_queues[count.index].visibility_timeout_seconds != null ? var.sqs_queues[count.index].visibility_timeout_seconds : 30
  #redrive
  redrive_policy = var.sqs_queues[count.index].create_dead_letter != null ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue[count.index].arn
    maxReceiveCount     = var.sqs_queues[count.index].redrive_policy.max_receive_count
  }) : null

  #fifo
  fifo_queue                  = var.sqs_queues[count.index].queue_type == "fifo" ? true : false
  content_based_deduplication = var.sqs_queues[count.index].queue_type == "fifo" ? true : false
  deduplication_scope         = var.sqs_queues[count.index].deduplication_scope
  fifo_throughput_limit       = var.sqs_queues[count.index].fifo_throughput_limit
}

resource "aws_sqs_queue" "dead_letter_queue" {
  count = length([for q in var.sqs_queues : q.redrive_policy if q.create_dead_letter == true && q.redrive_policy != null])

  name                       = coalesce(var.sqs_queues[count.index].redrive_policy.dead_letter_queue_name, "")
  message_retention_seconds  = coalesce(var.sqs_queues[count.index].redrive_policy.dead_letter_queue_message_retention_seconds, 0)
  visibility_timeout_seconds = coalesce(var.sqs_queues[count.index].redrive_policy.dead_letter_queue_visibility_timeout_seconds, 30)
}
