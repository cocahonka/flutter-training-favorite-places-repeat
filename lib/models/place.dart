import 'dart:io';

import 'package:flutter/foundation.dart';

typedef LatLng = ({double latitude, double longitude});

@immutable
class Place {
  Place({
    required this.title,
    required this.address,
    required this.location,
    required this.image,
    String? id,
  }) : id = id ?? DateTime.now().toIso8601String();

  final String id;
  final String title;
  final String address;
  final LatLng location;
  final File image;

  @override
  int get hashCode => Object.hash(id, title, address, location, image);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Place &&
            id == other.id &&
            title == other.title &&
            address == other.address &&
            location == other.location &&
            image == other.image);
  }
}
