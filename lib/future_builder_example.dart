import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({Key? key}) : super(key: key);

  @override
  _FutureBuilderExampleState createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: const Text("Future Builder Example"),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future resolved check if it has error
            if (snapshot.hasError) {
              return _getErrorText();
            } else if (snapshot.hasData) {
              //NOTE: isEmpty can only be used on Maps and Strings
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Data Received, but is empty"),
                );
              }
              return _getImageWidget(snapshot);
            } else {
              return _getNoDataReceivedText();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Future in progress
            return _getLoadingIndicator();
          } else {
            return Text("State: ${snapshot.connectionState}");
          }
        },
      ),
    );
  }

  Center _getImageWidget(AsyncSnapshot<dynamic> snapshot) {
    return Center(
      child: Image.network(snapshot.data),
    );
  }

  _getNoDataReceivedText() => const Center(child: Text("No Data Received"));

  _getLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _getErrorText() {
    return const Center(
      child: Text("An Error Occured"),
    );
  }
}

Future<String> getData() async {
  http.Response res;
  try {
    res = await http.get(Uri.parse("https://api.catboys.com/img"));
  } catch (e) {
    return "";
  }
  Map<String, dynamic> data = json.decode(res.body);
  return data['url'];
}
