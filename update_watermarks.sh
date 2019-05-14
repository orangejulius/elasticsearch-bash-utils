#!/bin/bash
set -euo pipefail

cluster_url="${cluster_url:-http://localhost:9200}"
echo "setting disk watermark levels for $cluster_url"

curl -XPUT "$cluster_url/_cluster/settings" -d '{
  "persistent": {
    "cluster.routing.allocation.disk.watermark.low": "95%",
    "cluster.routing.allocation.disk.watermark.high": "95%"
  }
}'
