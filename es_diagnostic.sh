#!/bin/bash -ue
set -eu

## HOW TO USE THIS SCRIPT
## download onto any Prod VPN connected machine
## set the $cluster_url variable to a url like "http://your-elasticsearch-host:9200" (specifiy port and put http at the front)
## run with `bash es_diagnostic.sh`
## optionally: update the old_snapshot_name and new_snapshot_name variables from the output
## run again, or ideally (on a large monitor) use `watch -n1 bash es_diagnostic.sh`

## CONFIGURE SCRIPT HERE
old_snapshot_name="pelias-2016.11.04-000804"
new_snapshot_name="pelias-2016.10.21-185509"

## show basic index information
echo -e "INDICES"
curl -s "$cluster_url/_cat/indices/?pretty=1&v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2)

# Shows counts of queries for each index
#echo -e "\n$old_snapshot_name queries"
#curl -s "$cluster_url/$old_snapshot_name/_stats?pretty=1&v" | grep query_total | head -1
#echo -e "\n$new_snapshot_name queries"
#curl -s "$cluster_url/$new_snapshot_name/_stats?pretty=1&v" | grep query_total | head -1

## Show information about each node, including master and router nodes
echo -e "\nNODES"
curl -s "$cluster_url/_cat/nodes/?pretty=1&v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -k8)

## Show information about each data storage node
echo -e "\nALLOCATIONS"
curl -s "$cluster_url/_cat/allocation?v" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -k9)

## list existing aliases
echo -e "\nALIASES"
curl -s "$cluster_url/_cat/aliases/?pretty=1&v"

## list any ongoing recovery operations, which includes snapshot restores
echo -e "\nRECOVERY"
recovery_headers="h=index,shard,time,type,stage,source_host,target_host,repository,snapshot,bytes_percent,total_bytes,total_files,translog_percent,total_translog"
curl -s "$cluster_url/_cat/recovery?v&pretty=1&${recovery_headers}" | grep -v "done"

echo -e "\nSHARDS"
## sorts lines after the header numerically by the 2nd column (shard id) due to https://github.com/elastic/elasticsearch/issues/17178
## only show shards that are not currently running (relocating, etc)
curl -s "$cluster_url/_cat/shards?v&pretty=1" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2) | grep -v STARTED
## show all (this is usually too cluttered to use)
#curl -s "$cluster_url/_cat/shards?v&pretty=1" | (for i in $(seq 1); do read -r; printf "%s\n" "$REPLY"; done; sort -nk2)
