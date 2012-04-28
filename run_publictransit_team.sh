#!/bin/bash
java -Xms1000m -Xmx1000m -classpath ".;build/libs/hackreduce-publictransit-0.2.jar;lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount datasets/gtfs /tmp/gtfs_stoptimecounts
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash /tmp/gtfs_stoptimecounts datasets/gtfs/torontogo/stops.txt /tmp/gtfs_geohash

