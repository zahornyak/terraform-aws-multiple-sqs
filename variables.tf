variable "sqs_queues" {
  description = "creating list of lots queue (deadletter or not)"
  type = list(object({
    name                       = string
    delay_seconds              = optional(number)
    max_message_size           = optional(number)
    message_retention_seconds  = optional(number)
    receive_wait_time_seconds  = optional(number)
    visibility_timeout_seconds = optional(number)
    create_dead_letter         = optional(bool)
    redrive_policy = optional(object({
      max_receive_count                            = number
      dead_letter_queue_name                       = string
      dead_letter_queue_message_retention_seconds  = number
      dead_letter_queue_visibility_timeout_seconds = number
    }))
    queue_type            = optional(string)
    deduplication_scope   = optional(string)
    fifo_throughput_limit = optional(string)
  }))
  default = []
}