import 'package:projetoeam/models/top500.dart';

import 'package:http/http.dart' as http;

import '../models/item.dart';

class HnService {
  Future<List<int>?> getTop500() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return top500FromJson(response.body);
    } else {
      return null;
    }
  }

  Future<Item?> getItem(int itemId) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://hacker-news.firebaseio.com/v0/item/$itemId.json?print=pretty");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return itemFromJson(response.body);
    } else {
      return null;
    }
  }
}
