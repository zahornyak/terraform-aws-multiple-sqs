variable "sqs_queues" {
  description = "creating list of lots queue (deadletter or not)"
  type = list(object({
    name                       = string
    delay_seconds              = number
    max_message_size           = number
    message_retention_seconds  = number
    receive_wait_time_seconds  = number
    visibility_timeout_seconds = number
    create_dead_letter         = bool
    redrive_policy = object({
      max_receive_count                           = number
      dead_letter_queue                           = string
      dead_letter_queue_message_retention_seconds = number
      visibility_timeout_seconds                  = number
    })
  }))
  default = []
}