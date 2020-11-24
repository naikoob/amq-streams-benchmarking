#!/bin/bash

BOOTSTRAP=$1
TOPIC=$2
NUM_RECORDS=$3
PERF_NS=$4
TEST_ID=$5

echo $PERF_NS
# remove the -t
#oc run kafka-consumer-perf -n $PERF_NS -i --image=registry.redhat.io/amq7/amq-streams-kafka-25-rhel7:1.5.0 --rm=true --restart=Never -- bin/kafka-consumer-perf-test.sh bootstrap.servers=$BOOTSTRAP key.serializer=org.apache.kafka.common.serialization.StringSerializer value.serializer=org.apache.kafka.common.serialization.StringSerializer --messages $NUM_RECORDS --print-metrics --topic $TOPIC --print-metrics > ./$TEST_ID/perf-test-consumer.txt
oc run kafka-consumer-perf -n $PERF_NS -i --image=registry.redhat.io/amq7/amq-streams-kafka-25-rhel7:1.5.0 --restart=Never -- bin/kafka-consumer-perf-test.sh --bootstrap-server $BOOTSTRAP --messages $NUM_RECORDS --topic $TOPIC --group $TOPIC key.serializer=org.apache.kafka.common.serialization.StringSerializer value.serializer=org.apache.kafka.common.serialization.StringSerializer > ./$TEST_ID/perf-test-consumer.txt

exit 0
