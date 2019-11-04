#!/bin/bash -ex

##
# loads a snapshot onto a dev cluster
##

set -euo pipefail

cluster_url="${cluster_url:-http://localhost:9200}"
base_path=${base_path:-elasticsearch}
es_repo_name="pelias_snapshots"
s3_bucket="${s3_bucket:-geocodeearth-mapzen-elasticsearch-snapshots}"
new_snapshot_name="${new_snapshot_name:-pelias-2017.11.18-001123}"
read_only="${read_only:-true}"

# create bucket, only needs to be run once
curl -XPOST "$cluster_url/_snapshot/$es_repo_name" \
  -H 'Content-Type: application/json' \
  -d "{
 \"type\": \"s3\",
   \"settings\": {
   \"bucket\": \"$s3_bucket\",
   \"read_only\": $read_only,
   \"base_path\" : \"$base_path\",
   \"max_snapshot_bytes_per_sec\" : \"1000mb\",
   \"max_restore_bytes_per_sec\" : \"1000mb\"
 }
}"

## import new snapshot with name including timestamp
curl -XPOST "$cluster_url/_snapshot/$es_repo_name/${new_snapshot_name}/_restore" \
  -H 'Content-Type: application/json' \
  -d "{
  \"indices\": \"pelias\",
  \"rename_pattern\": \"pelias\",
  \"rename_replacement\": \"$new_snapshot_name\"
}"
