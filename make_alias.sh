#!/bin/bash
set -euo pipefail

echo "setting pelias alias to $index_name on $cluster_url


curl -XPOST "$cluster_url/_aliases" -d "{
  \"actions\": [{
    \"add\": {
	  \"index\": \"$index_name\",
	  \"alias\": \"pelias\"
	}
  }]
}"
