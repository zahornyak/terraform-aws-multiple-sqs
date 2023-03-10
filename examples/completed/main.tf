module "sqs" {
  source = "../../"

  sqs_queues = [
    {
      name                       = "queue1"
      delay_seconds              = 0
      max_message_size           = 262144
      message_retention_seconds  = 345600
      receive_wait_time_seconds  = 20
      visibility_timeout_seconds = 300
      #creates 2 queue: main queue and deadletter queue + connecting them
      create_dead_letter = true
      redrive_policy = {
        max_receive_count = 10
        # name of dead letter queue
        dead_letter_queue                           = "queue1_dead_letter"
        dead_letter_queue_message_retention_seconds = 60
        visibility_timeout_seconds                  = 300
      }
    },
    {
      name                       = "queue2"
      delay_seconds              = 10
      max_message_size           = 65536
      message_retention_seconds  = 86400
      receive_wait_time_seconds  = 5
      visibility_timeout_seconds = 30
      # set redrive_policy to null and create_dead_letter to false  if you dont need to create dead letter configuration
      redrive_policy     = null
      create_dead_letter = false
    }
  ]
}