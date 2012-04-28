#!/bin/bash
#gradle
java -Xms1000m -Xmx1000m -classpath ".;build/libs/publictransit-0.2.jar;lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount "C:/Users/Jef/workspace/Hadoop Hack/publictransit/datasets/gtfs/stm/stop_times.txt" "C:/Users/Jef/workspace/Hadoop Hack/publictransit/tmp/busout"
#java -Xms1000m -Xmx1000m -classpath ".;build/libs/publictransit-0.2.jar;lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount "/datasets/gtfs/stm/stop_times.txt" "/tmp/busout"
