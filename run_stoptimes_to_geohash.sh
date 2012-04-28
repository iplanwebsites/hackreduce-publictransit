#!/bin/bash
gradle
java -Xms1000m -Xmx1000m -classpath ".:build/libs/HackReduce-0.2.jar:lib/*" com.iplanwebsites.hackreduce.publictransit.StopTimesCountToGeoHash datasets/nasdaq/daily_prices /tmp/nasdaq_recordcounts
