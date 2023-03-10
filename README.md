# AWS multiple SQS creation Terraform module 

Terraform module which creates multiple sqs with different configurations and with ability to create additional dead-letter configuration.

## Usage

### Simple single SQS

```hcl
module "sqs" {
  source  = "zahornyak/multiple-sqs/aws"
  version = "0.0.3"

  sqs_queues = [
    {
      name = "queue2"
    }
  ]
}
```

### Multiple simple sqs's

```hcl
module "sqs" {
  source  = "zahornyak/multiple-sqs/aws"
  version = "0.0.2"

  sqs_queues = [
    {
      name                       = "queue2"
      delay_seconds              = 10
      max_message_size           = 65536
      message_retention_seconds  = 86400
      receive_wait_time_seconds  = 5
      visibility_timeout_seconds = 30
    },
    {
      name = "sqs"
    },
    {
      name       = "sqs.fifo"
      queue_type = "fifo"
    },
    {
      name                  = "example_hight_throughput.fifo"
      queue_type            = "fifo"
      deduplication_scope   = "messageGroup"
      fifo_throughput_limit = "perMessageGroupId"
    }
  ]
}
```


### Deadletter single SQS
### BETA. Works only if index is 0

```hcl
module "sqs" {
  source  = "zahornyak/multiple-sqs/aws"
  version = "0.0.2"

  sqs_queues = [
    {
      name               = "queue1"
      create_dead_letter = true
      redrive_policy = {
        dead_letter_queue = "queue1_dead_letter"
      }
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
| <a name="input_sqs_queues"></a> [sqs\_queues](#input\_sqs\_queues) | creating list of lots queue (deadletter or not) | <pre>list(object({<br>    name                       = string<br>    delay_seconds              = optional(number)<br>    max_message_size           = optional(number)<br>    message_retention_seconds  = optional(number)<br>    receive_wait_time_seconds  = optional(number)<br>    visibility_timeout_seconds = optional(number)<br>    create_dead_letter         = optional(bool)<br>    redrive_policy = optional(object({<br>      max_receive_count                            = number<br>      dead_letter_queue_name                       = string<br>      dead_letter_queue_message_retention_seconds  = number<br>      dead_letter_queue_visibility_timeout_seconds = number<br>    }))<br>    queue_type            = optional(string)<br>    deduplication_scope   = optional(string)<br>    fifo_throughput_limit = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dead_letter_queue_ids"></a> [dead\_letter\_queue\_ids](#output\_dead\_letter\_queue\_ids) | output for dead\_letter\_queue\_ids |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | output for queue\_ids |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->