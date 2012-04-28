#!/bin/bash
java -Xms1000m -Xmx1000m -classpath ".;build/libs/hackreduce-publictransit-0.2.jar;lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount "C:/cygwin/home/kwellman/hackreduce-publictransit/datasets/gtfs/washington/stop_times.txt" "C:/cygwin/home/kwellman/hackreduce-publictransit/datasets/gtfs/san-fran/stops1.txt"
