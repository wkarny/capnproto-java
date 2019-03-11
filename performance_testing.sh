#!/bin/bash

sbt compile

avg_time=0

echo "Enter number of iterations : "
read n
for i in `seq 1 $n`;
do
	java -cp runtime/target/classes:examples/target/classes org.capnproto.examples.AddressbookMain write > out
	B="$(cat out)"
	echo "$B milliseconds"
	A="$(cut -d':' -f2 <<< $B )"
	#echo "$A"
	avg_time="$(($avg_time + $A))"
done

avg_time="$(($avg_time/$n))";

echo "Avg time : $avg_time milliseconds"

stat --printf="Encoding size : %s bytes\n" Example_capnp.enc