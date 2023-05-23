import 'package:flutter/material.dart';
import 'package:projetoeam/services/hnservice.dart';

import '../models/item.dart';
import 'itemview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item>? items = List<Item>.empty(growable: true);
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getNews();
  }

  getNews() async {
    const top = 50;
    var top500 = await HnService().getTop500();
    return top500?.take(top).forEach((element) {
      var item = HnService().getItem(element);
      item.then((value) {
        setState(() {
          items?.add(value!);
        });
        isLoaded = items?.length == top;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        items?.clear();
        isLoaded = false;
        return getNews();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Hacker News"),
          ),
          floatingActionButton: Visibility(
            visible: isLoaded,
            child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    items?.clear();
                    isLoaded = false;
                  });
                  getNews();
                },
                child: const Icon(Icons.refresh)),
          ),
          body: Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
                itemCount: items?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      items![index].title ?? "No title",
                    ),
                    leading: Text(
                      items![index].score?.toString() ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemView(
                              title: items![index].title ?? "No Title",
                              author: items![index].by ?? "No Author",
                              url: items![index].url ?? "")));
                    },
                  );
                }),
          )),
    );
  }
}
