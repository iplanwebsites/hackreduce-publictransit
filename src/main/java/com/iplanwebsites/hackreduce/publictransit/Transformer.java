package com.iplanwebsites.hackreduce.publictransit;

import java.io.*;
import java.util.*;

import ch.hsr.geohash.GeoHash;

public class Transformer {

	public static final void main(String[] args) {
		if(args.length<4){
			System.out.println("Requires parameters (stops, stop_counts, json_output, precision): C:\\Users\\104780\\go-transit_20120418_0304\\stops.txt C:\\Users\\104780\\go-transit_20120418_0304\\stop_time_counts.txt C:\\Users\\104780\\go-transit_20120418_0304\\json.txt 6");
		}
		//for (int i = 0; i < args.length; i++)			System.out.println("" + i + " " + args[i]);
		try {
			HashMap<String, Location> hashTable = parseStops(new File(args[0]));
			int precision = Integer.parseInt(args[3]);
			
			transform(new File(args[1]), hashTable, new File(args[2]),precision);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void transform(File stopTimeCounts, HashMap<String, Location> hashTable,
			File jsonGeoHashOutput, int precision) throws IOException {

		HashMap<String, int[]> geoTable = new HashMap<String, int[]>(512);
		
		FileInputStream fis = new FileInputStream(stopTimeCounts);

		InputStreamReader inStream = new InputStreamReader(fis);
		BufferedReader stdin = new BufferedReader(inStream);

		//stdin.readLine(); // ignore header
		String data = "";
		while ((data = stdin.readLine()) != null) {
			// Read and validate the line you are reading }
			//System.out.println(data);
			String hourKey, stopKey, stopCount;
			StringTokenizer tokenizer = new StringTokenizer(data, ";,");
			// while (tokenizer.hasMoreTokens()) {
			hourKey = tokenizer.nextToken().trim();
			stopKey = tokenizer.nextToken().trim();
			stopCount = tokenizer.nextToken().trim();
			Location loc = hashTable.get(stopKey);

			GeoHash hash = GeoHash.withCharacterPrecision(Double.parseDouble(loc.latitude), Double.parseDouble(loc.longitude), precision);
			String hashKey = hash.toBase32();
			int hour = Integer.parseInt(hourKey);
			int count = Integer.parseInt(stopCount);
			if( geoTable.containsKey(hashKey) ){
				int[] table = geoTable.get(hashKey);
				table[hour] += count;
			} else {
				int[] table = new int[24];
				table[hour] += count;
				geoTable.put(hashKey, table);
			}
			
			//System.out.println(hourKey + " " + stopKey + " " + loc.latitude + " " + loc.longitude + " " +stopCount);
			//System.out.println("\"{\"geohash\":\""+hashKey+"\",\"precision\":"+precision+",\"freq\":{\"weekdays\":{\"total\":312,\"by_hour\":[0,0,0,0,0,3,5,2,4,6,6,4,5,6,4,56,4,56,42]}}}\"");
		}
		
		Set set = geoTable.keySet();
		Iterator iter = set.iterator();
		String myKey;
		
		while(iter.hasNext()){
				String byHour = "";
				myKey = (String) iter.next();
				int[] rs = geoTable.get(myKey);
				int total = 0;
				for(int i=0;i<24;i++){
					total += rs[i];
					byHour = byHour+rs[i]+",";
				}
				System.out.println("{\"geohash\":\""+myKey+"\",\"precision\":"+precision+",\"freq\":{\"weekdays\":{\"total\":"+total+",\"by_hour\":["+byHour+"]}}}");
		
		}
		
		//"{"loc":[44.1,22.2],"geohash":"s92nco","precision":10,"freq":{"weekdays":{"total":312,"by_hour":[0,0,0,0,0,3,5,2,4,6,6,4,5,6,4,56,4,56,42]}}}"
	}

	/*
	 "{"loc":[44.1,22.2],"geohash":"s92nco","precision":10,"freq":{"weekdays":{"total":312,"by_hour":[0,0,0,0,0,3,5,2,4,6,6,4,5,6,4,56,4,56,42]}}}"


	 */
	
	
	public static HashMap<String, Location> parseStops(File stops) throws IOException {

		HashMap<String, Location> hashTable = new HashMap<String, Location>(1800); 

		FileInputStream fis = new FileInputStream(stops);

		InputStreamReader inStream = new InputStreamReader(fis);
		BufferedReader stdin = new BufferedReader(inStream);

		stdin.readLine(); // ignore header
		String data = "";
		while ((data = stdin.readLine()) != null) {
			// Read and validate the line you are reading }
			//System.out.println(data);
			String key;
			StringTokenizer tokenizer = new StringTokenizer(data, ",");
			// while (tokenizer.hasMoreTokens()) {
			key = tokenizer.nextToken().trim();
			tokenizer.nextToken(); //skip name
			String lat = tokenizer.nextToken().trim();
			String lon = tokenizer.nextToken().trim();
			//System.out.println(key + " " + lat + " " + lon);

			hashTable.put(key, new Location(lat,lon));
		}
		return hashTable;
	}
}
