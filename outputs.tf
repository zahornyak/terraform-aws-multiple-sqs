output "queue_ids" {
  value       = aws_sqs_queue.queue[*].id
  description = "output for queue_ids"
}

output "dead_letter_queue_ids" {
  value = try(
    aws_sqs_queue.dead_letter_queue[*].arn,
    null
  )
  description = "output for dead_letter_queue_ids"
}