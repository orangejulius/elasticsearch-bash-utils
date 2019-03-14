#!/bin/bash -ue

set -ue

cluster_url="${cluster_url:-http://localhost:9200}"

curl -s -XPUT "$cluster_url/_cluster/settings" -d '{
  "persistent" : {
    "cluster.blocks.read_only" : false
  }
}'
