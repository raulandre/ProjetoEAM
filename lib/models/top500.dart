// To parse this JSON data, do
//
//     final top500 = top500FromJson(jsonString);

import 'dart:convert';

List<int> top500FromJson(String str) =>
    List<int>.from(json.decode(str).map((x) => x));

String top500ToJson(List<int> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
