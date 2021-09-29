module "naming" {
  source            = "../naming/monitor_alert"
  environment       = var.environment
  location_shortcut = var.location_shortcut
  service           = var.service
}

resource "azurerm_monitor_action_group" "main" {
  name                = module.naming.monitor_alert
  resource_group_name = var.resource_group
  short_name          = var.service

  email_receiver {
    name          = "Email to DBaaS Group"
    email_address = var.email_dbaas
  }
  email_receiver {
    name          = "Email to DBA Phonphan"
    email_address = "phonphan.kantahong@allianz.com"
  }
  email_receiver {
    name          = "Email to DBA Teerapong"
    email_address = "teerapong.srinarong@allianz.com"
  }
  email_receiver {
    name          = "Email to DBA Sachin"
    email_address = "sachin.fate@allianz.com"
  }


  dynamic "email_receiver" {
    for_each = var.environment == "p" ? [1] : []
    content {
      name          = "Email to GCCC"
      email_address = "gccc@allianz.com"
    }
  }
}

resource "azurerm_monitor_metric_alert" "active_con_warn" {
  name                = "${module.naming.monitor_alert}-active_con_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "active_connections"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_active_con

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "active_con_cri" {
  name                = "${module.naming.monitor_alert}-active_con_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "active_connections"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_active_con
  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}


resource "azurerm_monitor_metric_alert" "cpu_warn" {
  name                = "${module.naming.monitor_alert}-cpu_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "cpu_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_cpu

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "cpu_cri" {
  name                = "${module.naming.monitor_alert}-cpu_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "cpu_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_cpu

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "con_failed_warn" {
  name                = "${module.naming.monitor_alert}-con_failed_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "connections_failed"
    aggregation      = "Total"
    operator         = var.operator
    threshold        = var.warn_failed_con
  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "con_failed_cri" {
  name                = "${module.naming.monitor_alert}-con_failed_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "connections_failed"
    aggregation      = "Total"
    operator         = var.operator
    threshold        = var.cri_failed_con

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "mem_warn" {
  name                = "${module.naming.monitor_alert}-mem_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "memory_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_mem

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

resource "azurerm_monitor_metric_alert" "mem_cri" {
  name                = "${module.naming.monitor_alert}-mem_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "memory_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_mem

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}


resource "azurerm_monitor_metric_alert" "storage_warn" {
  name                = "${module.naming.monitor_alert}-storage_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "storage_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_storage

  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}

resource "azurerm_monitor_metric_alert" "storage_cri" {
  name                = "${module.naming.monitor_alert}-storage_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "storage_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_storage

  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}

resource "azurerm_monitor_metric_alert" "log_storage_warn" {
  name                = "${module.naming.monitor_alert}-log_storage_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "serverlog_storage_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_log_storage

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}

resource "azurerm_monitor_metric_alert" "log_storage_cri" {
  name                = "${module.naming.monitor_alert}-log_storage_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "serverlog_storage_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_log_storage

  }
  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}

resource "azurerm_monitor_metric_alert" "io_warn" {
  name                = "${module.naming.monitor_alert}-io_warn"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "1"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "io_consumption_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.warn_io

  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}

resource "azurerm_monitor_metric_alert" "io_cri" {
  name                = "${module.naming.monitor_alert}-io_cri"
  resource_group_name = var.resource_group
  scopes              = var.scopes
  description         = "${var.aggregation}-${var.operator}"
  severity            = "0"
  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = "io_consumption_percent"
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.cri_io

  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

}
