import 'dart:convert';
import 'dart:io';

import 'package:favorite_places_repeat/models/place.dart';
import 'package:path_provider/path_provider.dart';

class PlaceRepository {
  PlaceRepository({required this.filename});

  final String filename;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    return path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final file = File('$path/$filename.json');

    return file;
  }

  Future<void> write(List<Place> places) async {
    final file = await _localFile;

    final content = json.encode({
      'data': places.map((place) => place.toJson()).toList(),
    });

    await file.writeAsString(content);
  }

  Future<List<Place>> read() async {
    final file = await _localFile;

    final contents = await file.readAsString();

    final placesJson = (json.decode(contents) as Map<String, dynamic>)['data'] as List<dynamic>;
    final places = placesJson.map((el) => Place.fromJson(el as Map<String, dynamic>)).toList();

    return places;
  }
}
