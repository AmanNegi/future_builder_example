import 'package:flutter/material.dart';
import 'package:future_builder_example/future_builder_example.dart';
import 'package:future_builder_example/traditional_future.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Futures in Flutter"),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getButton("Traditional Way", const TraditionalFuture(), context),
          _getButton("Future Builder ", const FutureBuilderExample(), context),
        ],
      )),
    );
  }

  ElevatedButton _getButton(
      String text, Widget destination, BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Text(text),
    );
  }
}
