#!/bin/bash
set -euo pipefail

cluster_url="${cluster_url:-http://localhost:9200}"
index_name="${index_name:-pelias-2017.11.18-001123}"

echo "setting pelias alias to $index_name on $cluster_url"

curl -XPOST "$cluster_url/_aliases" \
  -H 'Content-Type: application/json' \
  -d "{
  \"actions\": [{
    \"add\": {
	  \"index\": \"$index_name\",
	  \"alias\": \"pelias\"
	}
  }]
}"
