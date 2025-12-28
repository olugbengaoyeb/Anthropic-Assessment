#!/usr/bin/env bats

@test "Script fails if region is missing" {
  run ./cleanup.sh
  [ "$status" -ne 0 ]
}

@test "Dry run executes successfully" {
  run ./cleanup.sh -r us-east-1
  [ "$status" -eq 0 ]
}
