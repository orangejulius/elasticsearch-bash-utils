#!/bin/bash -ue
set -eu

cluster_url="${cluster_url:-http://localhost:9200}"

## CONFIGURE SCRIPT HERE
index_name="pelias"

## show basic index information
echo -e "INDICES"
curl -s "$cluster_url/_cat/indices/?pretty=true&v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2)

# Shows counts of queries for each index
echo -e "\n$index_name queries"
curl -s "$cluster_url/$index_name/_stats?pretty=true" | grep query_total | head -1

## Show information about each node, including master and router nodes
echo -e "\nNODES"
curl -s "$cluster_url/_cat/nodes/?pretty=true&v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -k8)

## Show information about each data storage node
echo -e "\nALLOCATIONS"
curl -s "$cluster_url/_cat/allocation?v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -k9)

## list existing aliases
echo -e "\nALIASES"
curl -s "$cluster_url/_cat/aliases/?pretty=true&v"

## list any ongoing recovery operations, which includes snapshot restores
echo -e "\nRECOVERY"
recovery_headers="h=index,shard,time,type,stage,source_host,target_host,repository,snapshot,bytes_percent,total_bytes,total_files,translog_percent,total_translog"
curl -s "$cluster_url/_cat/recovery?v&pretty=true&${recovery_headers}" | grep -v "done"

echo -e "\nSHARDS"
## sorts lines after the header numerically by the 2nd column (shard id) due to https://github.com/elastic/elasticsearch/issues/17178
## only show shards that are not currently running (relocating, etc)
curl -s "$cluster_url/_cat/shards?v&pretty=true" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2) | grep -v STARTED
## show all (this is usually too cluttered to use)
#curl -s "$cluster_url/_cat/shards?v&pretty=true" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2)
