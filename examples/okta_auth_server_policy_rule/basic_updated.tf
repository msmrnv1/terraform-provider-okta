data "okta_group" "all" {
  name = "Everyone"
}

resource "okta_auth_server_policy_rule" "test" {
  auth_server_id = "${okta_auth_server.test.id}"
  policy_id      = "${okta_auth_server_policy.test.id}"
  status         = "INACTIVE"
  name           = "test_updated"
  priority       = 2

  assignments = {
    group_whitelist = ["${okta_group.all.id}"]
  }

  grant_type_whitelist = ["password"]
}

resource "okta_auth_server" "test" {
  name        = "testAcc_%[1]d"
  description = "test"
  audiences   = ["whatever.rise.zone"]
}

resource "okta_auth_server_policy" "test" {
  name             = "test_updated"
  description      = "test updated"
  priority         = 2
  client_whitelist = ["ALL_CLIENTS"]
  auth_server_id   = "${okta_auth_server.test.id}"
}