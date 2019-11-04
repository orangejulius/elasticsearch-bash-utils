#!/bin/bash
set -euo pipefail

cluster_url="${cluster_url:-http://localhost:9200}"
echo "counting all types on $cluster_url"

# query for all source values with an aggregation
# this requires fielddata to be loaded, which takes a bit of memory
curl -s -XPOST "$cluster_url/pelias/_search?size=0" \
  -H 'Content-Type: application/json' \
  -d '{
  "aggs" : {
    "source_count" : { "terms" : { "field" : "source" } }
  }
}'


# query for all layer values with an aggregation
# this requires fielddata to be loaded, which takes a bit of memory
curl -s -XPOST "$cluster_url/pelias/_search?size=0" \
  -H 'Content-Type: application/json' \
  -d '{
  "aggs" : {
    "layer_count" : { "terms" : { "field" : "layer", "size": 20 } }
  }
}'


# example of how to query for one layer with a search
#curl -XPOST "$cluster_url/pelias/_search?size=0" -d '{
  #"query" : {
    #"term": {
      #"layer": "country"
    #}
  #}
#}'
