#!/bin/bash
se -eu

echo "setting threadpool.bulk.queue_size to 500 on $cluster_url"
curl -XPUT ${cluster_url}/_cluster/settings -d '{ "transient" : { "threadpool.bulk.queue_size" : 500 } }'
