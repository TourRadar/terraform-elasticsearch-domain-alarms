variable "actions" {
  description = "List of actions what should be executed"
  type        = list(string)
}

variable "ok_actions" {
  description = "List of actions what should be executed"
  type        = list(string)
  default = []
}

variable "elasticsearch_domain_arn" {
  type = string
}

variable "alarm_prefix" {
  type = string
}

variable "dedicated_master_enabled" {
  type    = bool
  default = true
}

variable "tags" {
  default = {}
}



variable "cluster_master_jvm_memory_pressure_threshold" {
  type    = number
  default = 80
}

variable "cluster_master_jvm_memory_pressure_evaluation_periods" {
  type    = number
  default = 5
}

variable "cluster_master_jvm_memory_pressure_period" {
  type    = number
  default = 60
}

variable "cluster_master_jvm_memory_pressure_treat_missing_data" {
  type    = string
  default = "notBreaching"
}



variable "cluster_5xx_threshold" {
  type    = number
  default = 2
}

variable "cluster_5xx_evaluation_periods" {
  type    = number
  default = 3
}

variable "cluster_5xx_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_5xx_evaluation_treat_missing_data" {
  type    = string
  default = "notBreaching"
}




variable "cluster_4xx_threshold" {
  type    = number
  default = 2
}

variable "cluster_4xx_evaluation_periods" {
  type    = number
  default = 3
}

variable "cluster_4xx_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_4xx_evaluation_treat_missing_data" {
  type    = string
  default = "notBreaching"
}




variable "health_red_threshold" {
  type    = number
  default = 1
}

variable "health_red_evaluation_periods" {
  type    = number
  default = 1
}

variable "health_red_evaluation_period" {
  type    = number
  default = 60
}

variable "health_red_treat_missing_data" {
  type    = string
  default = "notBreaching"
}





variable "health_yellow_threshold" {
  type    = number
  default = 1
}

variable "health_yellow_evaluation_periods" {
  type    = number
  default = 1
}

variable "health_yellow_evaluation_period" {
  type    = number
  default = 60
}

variable "health_yellow_treat_missing_data" {
  type    = string
  default = "notBreaching"
}




variable "sql_unhealthy_threshold" {
  type    = number
  default = 1
}

variable "sql_unhealthy_evaluation_periods" {
  type    = number
  default = 1
}

variable "sql_unhealthy_evaluation_period" {
  type    = number
  default = 60
}

variable "sql_unhealthy_treat_missing_data" {
  type    = string
  default = "notBreaching"
}



variable "freestorage_low_checks" {
  type    = set(string)
  default = [15, 10, 5, 1]
}

variable "freestorage_low_evaluation_periods" {
  type    = number
  default = 2
}

variable "freestorage_low_evaluation_period" {
  type    = number
  default = 60
}

variable "freestorage_low_treat_missing_data" {
  type    = string
  default = "notBreaching"
}





variable "cluster_index_writes_blocked_threshold" {
  type    = number
  default = 1
}

variable "cluster_index_writes_blocked_evaluation_periods" {
  type    = number
  default = 2
}

variable "cluster_index_writes_blocked_evaluation_period" {
  type    = number
  default = 5 * 60
}

variable "cluster_index_writes_blocked_treat_missing_data" {
  type    = string
  default = "notBreaching"
}




variable "cluster_automated_snapshot_failure_threshold" {
  type    = number
  default = 1
}

variable "cluster_automated_snapshot_failure_evaluation_periods" {
  type    = number
  default = 1
}

variable "cluster_automated_snapshot_failure_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_automated_snapshot_failure_treat_missing_data" {
  type    = string
  default = "ignore"
}





variable "cluster_cpu_utilization_threshold" {
  type    = number
  default = 80
}

variable "cluster_cpu_utilization_evaluation_periods" {
  type    = number
  default = 10
}

variable "cluster_cpu_utilization_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_cpu_utilization_treat_missing_data" {
  type    = string
  default = "notBreaching"
}





variable "cluster_jvm_memory_pressure_threshold" {
  type    = number
  default = 80
}

variable "cluster_jvm_memory_pressure_evaluation_periods" {
  type    = number
  default = 10
}

variable "cluster_jvm_memory_pressure_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_jvm_memory_pressure_treat_missing_data" {
  type    = string
  default = "notBreaching"
}




variable "cluster_master_cpu_utilization_threshold" {
  type    = number
  default = 50
}

variable "cluster_master_cpu_utilization_evaluation_periods" {
  type    = number
  default = 10
}

variable "cluster_master_cpu_utilization_evaluation_period" {
  type    = number
  default = 60
}

variable "cluster_master_cpu_utilization_treat_missing_data" {
  type    = string
  default = "notBreaching"
}