#!/bin/bash
rm -rf output
mkdir output
mkdir output/gtfs_stoptimecounts
mkdir output/gtfs_stoptimecounts/washington
mkdir output/gtfs_stoptimecounts/san-fran
mkdir output/gtfs_stoptimecounts/torontogo
mkdir output/gtfs_geohash
mkdir output/gtfs_geohash/washington
mkdir output/gtfs_geohash/torontogo
mkdir output/gtfs_geohash/san-fran
mkdir output/final


java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount datasets/gtfs/san-fran/stop_times.txt output/gtfs_stoptimecounts/san-fran/
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount datasets/gtfs/torontogo/stop_times.txt output/gtfs_stoptimecounts/torontogo/
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesToCount datasets/gtfs/washington/stop_times.txt output/gtfs_stoptimecounts/washington/
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash output/gtfs_stoptimecounts/san-fran datasets/gtfs/san-fran/stops.txt output/gtfs_geohash/san-fran
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash output/gtfs_stoptimecounts/torontogo datasets/gtfs/torontogo/stops.txt output/gtfs_geohash/torontogo
java -Xms1000m -Xmx1000m -classpath ".:build/libs/hackreduce-publictransit-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash output/gtfs_stoptimecounts/washington datasets/gtfs/washington/stops.txt output/gtfs_geohash/washington


cat output/gtfs_geohash/washington/* >> output/final/washington.json
cat output/gtfs_geohash/san-fran/* >> output/final/san-fran.json
cat output/gtfs_geohash/torontogo/* >> output/final/toronto.json
