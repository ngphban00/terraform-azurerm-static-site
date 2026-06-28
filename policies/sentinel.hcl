policy "restrict-storage-tier-dev" {
  source            = "./restrict-storage-tier-dev.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "require-mandatory-tags" {
  source            = "./require-mandatory-tags.sentinel"
  enforcement_level = "advisory"
}
