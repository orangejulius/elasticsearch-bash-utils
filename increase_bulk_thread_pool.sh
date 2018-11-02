#!/bin/bash
set -eu

cluster_url="${cluster_url:-http://localhost:9200}"
echo "setting threadpool.bulk.queue_size to 500 on $cluster_url"
curl -XPUT ${cluster_url}/_cluster/settings -d '{ "transient" : { "threadpool.bulk.queue_size" : 500 } }'
