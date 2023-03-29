variable "sqs_queues" {
  description = "creating list of lots queue (deadletter or not)"
  type        = any
  default     = {}
}