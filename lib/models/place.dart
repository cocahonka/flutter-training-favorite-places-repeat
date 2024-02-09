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

  factory Place.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final String id,
        'title': final String title,
        'address': final String address,
        'location': {
          'latitude': final double latitude,
          'longitude': final double longitude,
        },
        'image': final String imagePath,
      } =>
        Place(
          id: id,
          title: title,
          address: address,
          location: (
            latitude: latitude,
            longitude: longitude,
          ),
          image: File(imagePath),
        ),
      _ => throw const FormatException('Failed to parse place')
    };
  }

  final String id;
  final String title;
  final String address;
  final LatLng location;
  final File image;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'image': image.path,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

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
