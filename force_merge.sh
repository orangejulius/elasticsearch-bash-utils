#!/bin/bash -ex

set -eu

cluster_url="${cluster_url:-http://localhost:9200}"
index_name=${index_name:-pelias}
num_segments=${num_segments:-1}
echo "force merging index $index_name to have $num_segments segments on cluster $cluster_url"

curl -XPOST "$cluster_url/$index_name/_forcemerge?max_num_segments=$num_segments"
