import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print('Downloads Started');
          await downloadMultipleItems().timeout(Duration(seconds: 2),
              onTimeout: () {
            print('Download timed out');
            return 'The download timed out';
          });
        },
        label: Text('Push Me'),
      ),
    );
  }
}

//Simulate downloading a file
Future<bool> downloadItem(int id, int duration) async {
  await Future.delayed(Duration(seconds: duration));
  print('Downloaded item $id');
  return true;
}

//Simulate a download manager running multiple files
Future downloadMultipleItems() async {
//  List to hold multiple futures(downloads)
  List<Future> futures = [];
  for (int i = 0; i < 10; i++) {
    futures.add(downloadItem(i, Random(i).nextInt(10)));
  }

//  Wait for all futures to complete
  await Future.wait(futures);

  // We're done with all futures execution
  print('All the downloads have completed');
}
