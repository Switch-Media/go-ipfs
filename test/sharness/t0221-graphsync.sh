#!/usr/bin/env bash

test_description="Test mount command in conjunction with publishing"

# imports
. lib/test-lib.sh

test_init_ipfs

test_expect_success 'configuring ipfs' '
  ipfs config --json Experimental.GraphsyncEnabled true
'

test_expect_success 'add content' '
  HASH=$(random 1000000 | ipfs add -q)
'

test_launch_ipfs_daemon

test_expect_success 'get addrs' '
  ADDR="$(ipfs id --format="<addrs>" | head -1)"
'

test_expect_success 'fetch' '
  graphsync-get "$ADDR" "$HASH"
'
