# terraform-elasticsearch-domain-alarms
Terraform module to automate creating elasticsearch domain alarms

## Example usage
```terraform
module "terraform-elasticsearch-domain-alarms" {
  source = "github.com/TourRadar/terraform-elasticsearch-domain-alarms"
  elasticsearch_domain_arn = aws_elasticsearch_domain.main.arn
  actions      = ["snsarn etc"]
  alarm_prefix = "MyAlarmPrefix"
  tags = {
    Project = "SomeProject"
  }
}
```
