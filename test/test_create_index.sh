#!/bin/bash
set -euo pipefail

curl -XPUT "$cluster_url/twitter?pretty" \
  -H 'Content-Type: application/json' \
  -d '{
  "settings" : {
    "index" : {
      "number_of_shards" : 3,
      "number_of_replicas" : 2
    }
  }
}'

curl -XDELETE "$cluster_url/twitter"
