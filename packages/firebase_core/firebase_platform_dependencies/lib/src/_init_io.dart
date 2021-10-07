// File created by
// Lung Razvan <long1eu>
// on 01/09/2020

import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'flutter_platform_dependencies.dart';

Future<InitArguments> init() async {
  final Directory parent = await getApplicationDocumentsDirectory();
  return InitArguments(parent.path);
}
