#!/bin/bash -ex

set -eu

echo "setting replica count to 1 on pelas index in $cluster_url"

curl -XPUT "$cluster_url/pelias/_settings" -d '{
	"index" : {
		"number_of_replicas" : 1
	}
}'
