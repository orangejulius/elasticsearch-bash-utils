#!/bin/bash
set -euo pipefail

echo "setting optimal index recovery settings for higher performance on $cluster_url"

curl -XPUT "$cluster_url/_cluster/settings" -d '{
  "persistent": {
    "indices.recovery.max_bytes_per_sec": "4000mb",
    "cluster.routing.allocation.node_concurrent_recoveries": 24,
    "cluster.routing.allocation.node_initial_primaries_recoveries": 24
  }
}'
