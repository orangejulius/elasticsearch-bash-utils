#!/bin/bash
set -euo pipefail

echo "enabling slowlog for searching and indexing on $cluster_url"

curl -XPUT "$cluster_url/_cluster/settings" -d '{
  "persistent": {
    "index.search.slowlog.threshold.query.warn": "10s",
    "index.search.slowlog.threshold.query.info": "5s",
    "index.search.slowlog.threshold.query.info": "2s",
    "index.search.slowlog.threshold.query.info": "500ms",
    "index.search.slowlog.source": true,

    "index.search.slowlog.threshold.fetch.warn": "10s",
    "index.search.slowlog.threshold.fetch.info": "5s",
    "index.search.slowlog.threshold.fetch.info": "2s",
    "index.search.slowlog.threshold.fetch.info": "500ms",

    "index.index.slowlog.threshold.index.warn": "10s",
    "index.index.slowlog.threshold.index.info": "5s",
    "index.index.slowlog.threshold.index.info": "2s",
    "index.index.slowlog.threshold.index.info": "500ms"
  }
}'
