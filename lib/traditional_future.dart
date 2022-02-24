import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TraditionalFuture extends StatefulWidget {
  const TraditionalFuture({Key? key}) : super(key: key);

  @override
  _TraditionalFutureState createState() => _TraditionalFutureState();
}

class _TraditionalFutureState extends State<TraditionalFuture> {
  // Variables to update user regarding the request status
  bool isLoading = false;
  bool errorOccured = false;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: getData,
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Traditional Async"),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : errorOccured
                  ? const Text("Error Occured")
                  : Image.network(imageUrl)),
    );
  }

  Future<void> getData() async {
    // Set Fields
    errorOccured = false;
    isLoading = true;
    setState(() {});

    http.Response res;
    try {
      res = await http.get(Uri.parse("https://api.catboys.com/img"));
    } catch (e) {
      // Error Occured while making request
      errorOccured = true;
      isLoading = false;
      setState(() {});
      debugPrint(e.toString());
      return;
    }
    // Request Sucessfull
    Map<String, dynamic> data = json.decode(res.body);
    imageUrl = data['url'];
    isLoading = false;
    setState(() {});
  }
}
