import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_dart/firebase_core_dart.dart';
import 'package:firebase_core_dart_example/generated/firebase_options_dart.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await FirebaseDart.register(options: firebaseOptions);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _name = 'foo';

  String _message = '';

  Future<void> _configure() async {
    final bool exists =
        Firebase.apps.any((FirebaseApp app) => app.name == _name);
    if (exists) {
      final FirebaseApp app = Firebase.app(_name);

      setState(() {
        _message = 'App $_name already exists with ${app.options}.';
      });
    } else {
      final FirebaseApp app =
          await Firebase.initializeApp(options: firebaseOptions, name: _name);

      setState(() {
        _message = 'App $_name was configured with ${app.options}';
      });
    }
  }

  Future<void> _allApps() async {
    setState(() {
      _message = 'Currently configured apps: ${Firebase.apps}';
    });
  }

  Future<void> _options() async {
    try {
      final FirebaseApp app = Firebase.app(_name);
      final FirebaseOptions options = app.options;
      setState(() {
        _message = 'Current options for app $_name: $options';
      });
    } catch (e) {
      setState(() {
        _message = 'The app has not been yet initialized.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Core example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(_message),
                ),
              ),
              ElevatedButton(
                onPressed: _configure,
                child: const Text('initialize'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _allApps,
                child: const Text('allApps'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _options,
                child: const Text('options'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
