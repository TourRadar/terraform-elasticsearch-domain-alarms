locals {
  parts       = split(":", var.elasticsearch_domain_arn)
  partsDomain = split("/", local.parts[5])

  alarmDimensions = {
    DomainName = local.partsDomain[1]
    ClientId   = local.parts[4]
  }
}


resource "aws_cloudwatch_metric_alarm" "health_red" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch health is red"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.health_red_evaluation_periods
  threshold           = var.health_red_threshold
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = var.health_red_evaluation_period
  statistic           = "Maximum"
  alarm_description   = "At least one primary shard and its replicas are not allocated to a node. See Red Cluster Status."
  treat_missing_data  = var.health_red_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "health_yellow" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch health is yellow"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.health_yellow_evaluation_periods
  threshold           = var.health_yellow_threshold
  metric_name         = "ClusterStatus.yellow"
  namespace           = "AWS/ES"
  period              = var.health_yellow_evaluation_period
  statistic           = "Maximum"
  alarm_description   = "At least one replica shard is not allocated to a node. See Yellow Cluster Status."
  treat_missing_data  = var.health_yellow_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "sql_unhealthy" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch SQL Unhealthy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.sql_unhealthy_evaluation_periods
  threshold           = var.sql_unhealthy_threshold
  metric_name         = "SQLUnhealthy"
  namespace           = "AWS/ES"
  period              = var.sql_unhealthy_evaluation_period
  statistic           = "Maximum"
  alarm_description   = "SQLUnhealthy triggring problems"
  treat_missing_data  = var.sql_unhealthy_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}


resource "aws_cloudwatch_metric_alarm" "freestorage_low" {
  for_each            = var.freestorage_low_checks
  alarm_name          = "${var.alarm_prefix}: ElasticSearch free storage is bellow ${each.value}GB"
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = each.value * 1024
  evaluation_periods  = var.freestorage_low_evaluation_periods
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = var.freestorage_low_evaluation_period
  statistic           = "Minimum"
  alarm_description   = "A node in your cluster is down to ${each.value} GiB of free storage space. See Lack of Available Storage Space. This value is in MiB, so rather than 10480, we recommend setting it to 25% of the storage space for each node."
  treat_missing_data  = var.freestorage_low_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}


resource "aws_cloudwatch_metric_alarm" "cluster_index_writes_blocked" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch index writes blocked"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_index_writes_blocked_evaluation_periods
  threshold           = var.cluster_index_writes_blocked_threshold
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = var.cluster_index_writes_blocked_evaluation_period
  statistic           = "Maximum"
  alarm_description   = "Your cluster is blocking write requests. See ClusterBlockException"
  treat_missing_data  = var.cluster_index_writes_blocked_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}



resource "aws_cloudwatch_metric_alarm" "cluster_automated_snapshot_failure" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch automated snapshot failure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_automated_snapshot_failure_evaluation_periods
  threshold           = var.cluster_automated_snapshot_failure_threshold
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = var.cluster_automated_snapshot_failure_evaluation_period
  statistic           = "Maximum"
  alarm_description   = "An automated snapshot failed. This failure is often the result of a red cluster health status. See Red Cluster Status."
  treat_missing_data  = var.cluster_automated_snapshot_failure_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "cluster_cpu_utilization" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch CPU utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_cpu_utilization_evaluation_periods
  threshold           = var.cluster_cpu_utilization_threshold
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = var.cluster_cpu_utilization_evaluation_period
  statistic           = "Average"
  alarm_description   = "100% CPU utilization isn't uncommon, but sustained high averages are problematic. Consider using larger instance types or adding instances."
  treat_missing_data  = var.cluster_cpu_utilization_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}


resource "aws_cloudwatch_metric_alarm" "cluster_jvm_memory_pressure" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch JVM memory pressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_jvm_memory_pressure_evaluation_periods
  threshold           = var.cluster_jvm_memory_pressure_threshold
  metric_name         = "JVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.cluster_jvm_memory_pressure_evaluation_period
  statistic           = "Average"
  alarm_description   = "The cluster could encounter out of memory errors if usage increases. Consider scaling vertically. Amazon ES uses half of an instance's RAM for the Java heap, up to a heap size of 32 GiB. You can scale instances vertically up to 64 GiB of RAM, at which point you can scale horizontally by adding instances."
  treat_missing_data  = var.cluster_jvm_memory_pressure_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "cluster_master_cpu_utilization" {
  count               = var.dedicated_master_enabled ? 1 : 0
  alarm_name          = "${var.alarm_prefix}: ElasticSearch master cpu utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_master_cpu_utilization_evaluation_periods
  threshold           = var.cluster_master_cpu_utilization_threshold
  metric_name         = "MasterCPUUtilization"
  namespace           = "AWS/ES"
  period              = var.cluster_master_cpu_utilization_evaluation_period
  statistic           = "Average"
  alarm_description   = "Consider using larger instance types for your dedicated master nodes. Because of their role in cluster stability and blue/green deployments, dedicated master nodes should have lower average CPU usage than data nodes."
  treat_missing_data  = var.cluster_master_cpu_utilization_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}


resource "aws_cloudwatch_metric_alarm" "cluster_master_jvm_memory_pressure" {
  count               = var.dedicated_master_enabled ? 1 : 0
  alarm_name          = "${var.alarm_prefix}: ElasticSearch master JVM memory presure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_master_jvm_memory_pressure_evaluation_periods
  threshold           = var.cluster_master_jvm_memory_pressure_threshold
  metric_name         = "MasterJVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.cluster_master_jvm_memory_pressure_period
  statistic           = "Average"
  alarm_description   = "Consider using larger instance types for your dedicated master nodes. Because of their role in cluster stability and blue/green deployments, dedicated master nodes should have lower average CPU usage than data nodes."
  treat_missing_data  = var.cluster_master_jvm_memory_pressure_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "cluster_5xx" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch 5xx errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_5xx_evaluation_periods
  threshold           = var.cluster_5xx_threshold
  metric_name         = "5xx"
  namespace           = "AWS/ES"
  period              = var.cluster_5xx_evaluation_period
  statistic           = "Sum"
  alarm_description   = "ElasticSearch triggering 5xx http errors"
  treat_missing_data  = var.cluster_5xx_evaluation_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}

resource "aws_cloudwatch_metric_alarm" "cluster_4xx" {
  alarm_name          = "${var.alarm_prefix}: ElasticSearch 4xx errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_4xx_evaluation_periods
  threshold           = var.cluster_4xx_threshold
  metric_name         = "4xx"
  namespace           = "AWS/ES"
  period              = var.cluster_4xx_evaluation_period
  statistic           = "Sum"
  alarm_description   = "ElasticSearch triggering 4xx http errors"
  treat_missing_data  = var.cluster_4xx_evaluation_treat_missing_data
  alarm_actions       = var.actions
  ok_actions          = var.ok_actions
  tags                = var.tags
  dimensions          = local.alarmDimensions
}
