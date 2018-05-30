#!/bin/bash -ex

set -eu

index_name="${index_name:-pelias}"
replica_count="${replica_count:-1}"

echo "setting replica count to $replica_count on $index_name index in $cluster_url"

curl -XPUT "$cluster_url/$index_name/_settings" -d "{
        \"index\" : {
                \"number_of_replicas\" : $replica_count
        }
}"
