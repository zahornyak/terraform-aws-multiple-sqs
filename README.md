# AWS multiple SQS creation Terraform module 
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/zahornyak/terraform-aws-multiple-sqs)


Terraform module which creates multiple sqs with different configurations and with ability to create additional dead-letter configuration.
Especially comfortable with Terragrunt.

## Usage

### Use any possible by module sqs

```hcl
module "sqs" {
  source  = "zahornyak/multiple-sqs/aws"
  version = "0.0.3"

  sqs_queues = {

    simple_sqs = {
      name = "simple"
    }
    
    foo = {
      name = "bar"
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
| <a name="input_sqs_queues"></a> [sqs\_queues](#input\_sqs\_queues) | creating list of lots queue (deadletter or not) | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dead_letter_queue_ids"></a> [dead\_letter\_queue\_ids](#output\_dead\_letter\_queue\_ids) | output for dead\_letter\_queue\_ids |
| <a name="output_queue_ids"></a> [queue\_ids](#output\_queue\_ids) | output for queue\_ids |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->