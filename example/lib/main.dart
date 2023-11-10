import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_france_identite/flutter_france_identite.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

void main() {
  runApp(const FranceIdentiteTestApp());
}

class FranceIdentiteTestApp extends StatelessWidget {
  const FranceIdentiteTestApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter France Identite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription intentDataStreamSubscription;
  List<SharedFile>? list;

  @override
  void initState() {
    super.initState();
    intentDataStreamSubscription = FlutterSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedFile> value) {
      setState(() {
        list = value;
      });
    }, onError: (err) {});

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance
        .getInitialSharing()
        .then((List<SharedFile> value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void dispose() {
    intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FranceIdentiteButton(
              logoTrailing: true,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                List res = await checkDocumentValidity(list![0]);
                if (res[0] == true) {
                  checkCorrespondingInfos(
                    res[1]['attributes'],
                    "name",
                    'surname',
                    'x',
                    'fra',
                    'dd/mm/yyyy',
                    'city',
                  );
                }
              },
              child: const Text('Check document validity'),
            ),
          ],
        ),
      ),
    );
  }
}
