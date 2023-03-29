module "sqs" {
  source = "../../"

  sqs_queues = {

    simple_sqs = {
      name = "simple"
    }

    deadletter_sqs = {
      name              = "deadletter_sqs"
      create_deadletter = true
      maxReceiveCount   = 100
    }

    example_all_functions = {
      name                       = "all"
      delay_seconds              = 60
      max_message_size           = 100
      message_retention_seconds  = 60
      receive_wait_time_seconds  = 60
      visibility_timeout_seconds = 70

      create_deadletter = true
      maxReceiveCount   = 100
    }
  }
}