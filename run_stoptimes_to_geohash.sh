#!/bin/bash
java -Xms1000m -Xmx1000m -classpath ".:build/libs/HackReduce-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash /tmp/gtfs_stoptimecounts datasets/gtfs/torontogo/stops.txt /tmp/gtfs_geohash
