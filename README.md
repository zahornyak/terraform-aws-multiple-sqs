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