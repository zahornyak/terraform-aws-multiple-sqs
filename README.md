# AWS multiple SQS creation Terraform module 

Terraform module which creates multiple sqs with different configurations and with ability to create additional dead-letter configuration.

## Usage

### Simple single SQS

```hcl
module "sqs" {
  source = "github.com/zahornyak/multiple_sqs"

  sqs_queues = [
    {
      name                       = "queue1"
      delay_seconds              = 0
      max_message_size           = 262144
      message_retention_seconds  = 345600
      receive_wait_time_seconds  = 20
      visibility_timeout_seconds = 300
      create_dead_letter = true
      redrive_policy = {
        max_receive_count = 10
        dead_letter_queue                           = "queue1_dead_letter"
        dead_letter_queue_message_retention_seconds = 60
        visibility_timeout_seconds                  = 300
      }
    }
  ]
}
```


### Deadletter single SQS

```hcl
module "sqs" {
  source = "github.com/zahornyak/multiple_sqs"

  sqs_queues = [
    {
      name                       = "queue2"
      delay_seconds              = 10
      max_message_size           = 65536
      message_retention_seconds  = 86400
      receive_wait_time_seconds  = 5
      visibility_timeout_seconds = 30
      redrive_policy     = null
      create_dead_letter = false
    }
  ]
}
```

### Multiple simple and deadletter sqs's

```hcl
module "sqs" {
  source = "github.com/zahornyak/multiple_sqs"

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
```





<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.dead_letter_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_queues"></a> [sqs\_queues](#input\_sqs\_queues) | creating list of lots queue (deadletter or not) | <pre>list(object({<br>    name                       = string<br>    delay_seconds              = number<br>    max_message_size           = number<br>    message_retention_seconds  = number<br>    receive_wait_time_seconds  = number<br>    visibility_timeout_seconds = number<br>    create_dead_letter         = bool<br>    redrive_policy = object({<br>      max_receive_count                           = number<br>      dead_letter_queue                           = string<br>      dead_letter_queue_message_retention_seconds = number<br>      visibility_timeout_seconds                  = number<br>    })<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dead_letter_queue_ids"></a> [dead\_letter\_queue\_ids](#output\_dead\_letter\_queue\_ids) | output for dead\_letter\_queue\_ids |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | output for queue\_ids |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->