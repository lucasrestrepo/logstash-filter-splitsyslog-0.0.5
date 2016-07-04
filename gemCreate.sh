#!/bin/sh
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASE_DIR=`dirname $DIR`
cd $BASE_DIR/logstash-plugin
gem build  logstash-filter-splitsyslog.gemspec 
mv logstash-filter-splitsyslog-*.gem $BASE_DIR/logstash/
