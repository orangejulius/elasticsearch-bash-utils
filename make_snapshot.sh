#!/bin/bash -ex

##
# saves a snapshot to an S3 bucket
##

set -euo pipefail

current_date=`date +"%Y.%m.%d-%H%M%S"`

cluster_url="${cluster_url:-http://localhost:9200}"
new_snapshot_name="${new_snapshot_name:-pelias-$current_date}"
echo "creating $new_snapshot_name"

# use a unique base path for each snapshot. otherwise, the files for multiple snapshots
# are interleaved and it is not easy to separate them later
base_path=${base_path:-elasticsearch/$current_date}

# create a unique name for the elasticsearch repository
es_repo_name="pelias_snapshots-$current_date"
s3_bucket="${s3_bucket:-pelias-elasticsearch.nextzen.org}"

# create Elasticsearch repository from settings
set -x
curl -XPOST "$cluster_url/_snapshot/$es_repo_name" -d "{
 \"type\": \"s3\",
   \"settings\": {
   \"bucket\": \"$s3_bucket\",
   \"base_path\" : \"$base_path\",
   \"max_snapshot_bytes_per_sec\" : \"1000mb\"
 }
}"

# create snapshot
curl -XPUT "$cluster_url/_snapshot/$es_repo_name/$new_snapshot_name" -d '{
  "indices": "pelias"
}'

