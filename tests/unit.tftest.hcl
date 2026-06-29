mock_provider "azurerm" {}
mock_provider "random" {}

# Shared variables for most test cases
variables {
  name            = "acme-order-portal"
  environment     = "dev"
  cost_center     = "ecommerce"
  owner           = "order-team"
  index_html_path = "./tests/fixtures/index.html"
}

# ── Default values ────────────────────────────────────────────────────────────

run "default_access_tier_is_hot" {
  assert {
    condition     = azurerm_storage_account.site.access_tier == "Hot"
    error_message = "Default access_tier must be Hot"
  }
}

run "default_replication_is_lrs" {
  assert {
    condition     = azurerm_storage_account.site.account_replication_type == "LRS"
    error_message = "Default replication_type must be LRS"
  }
}

run "default_tls_is_1_2" {
  assert {
    condition     = azurerm_storage_account.site.min_tls_version == "TLS1_2"
    error_message = "Default min_tls_version must be TLS1_2"
  }
}

# ── Mandatory tags ────────────────────────────────────────────────────────────

run "mandatory_tags_are_applied" {
  assert {
    condition     = azurerm_storage_account.site.tags["managed_by"] == "terraform"
    error_message = "managed_by tag must be 'terraform'"
  }

  assert {
    condition     = azurerm_storage_account.site.tags["environment"] == "dev"
    error_message = "environment tag must match var.environment"
  }

  assert {
    condition     = azurerm_storage_account.site.tags["cost_center"] == "ecommerce"
    error_message = "cost_center tag must match var.cost_center"
  }

  assert {
    condition     = azurerm_storage_account.site.tags["owner"] == "order-team"
    error_message = "owner tag must match var.owner"
  }
}

# ── Variable validation ───────────────────────────────────────────────────────

run "rejects_invalid_environment" {
  variables {
    environment = "production"
  }
  expect_failures = [var.environment]
}

run "rejects_invalid_access_tier" {
  variables {
    access_tier = "Archive"
  }
  expect_failures = [var.access_tier]
}

run "rejects_invalid_replication_type" {
  variables {
    replication_type = "ERS"
  }
  expect_failures = [var.replication_type]
}

run "rejects_invalid_tls_version" {
  variables {
    min_tls_version = "TLS1_3"
  }
  expect_failures = [var.min_tls_version]
}

# ── Custom values pass through ────────────────────────────────────────────────

run "custom_access_tier_respected" {
  variables {
    access_tier = "Cool"
  }

  assert {
    condition     = azurerm_storage_account.site.access_tier == "Cool"
    error_message = "access_tier should be Cool when explicitly set"
  }
}

run "custom_replication_respected" {
  variables {
    replication_type = "GRS"
  }

  assert {
    condition     = azurerm_storage_account.site.account_replication_type == "GRS"
    error_message = "replication_type should be GRS when explicitly set"
  }
}
