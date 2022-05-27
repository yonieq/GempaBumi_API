import 'dart:convert';

import 'package:bmkg_rest/api/model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Item>> fetchItems(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/yonieq/gempaBumi_restApi/main/autogempa.json'));

  // List jsonResponse = json.decode(response.body)['Infogempa'];
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseItems, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Item> parseItems(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  // List jsonResponse = json.decode(parsed.body)['Infogempa'];
  // print(parsed);
  // var data = parsed["Infogempa"];
  // var parser = data["gempa"];

  return parsed.map<Item>((json) => Item.fromJson(json)).toList();
}
