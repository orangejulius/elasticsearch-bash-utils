# Elasticsearch bash utils

This is a collection of useful scripts for working with Elasticsearch on the command line. They
aren't the prettiest tools out there, but they provide information-dense and accurate information
crucial to montioring real live production Elasticsearch instances.

## Quickstart

All scripts default to looking at a local cluster, so to quickly get started monitoring a cluster, the following can be used:

```
git clone https://github.com/orangejulius/elasticsearch-bash-utils.git
cd elasticsearch-bash-utils
watch bash es_diagnostic.sh
```
