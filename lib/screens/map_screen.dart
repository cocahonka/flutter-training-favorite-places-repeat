import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({required this.isSelecting, super.key});

  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _controller;

  Future<void> _initMap() async {
    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          zoom: 16,
          target: Point(latitude: 59.929560, longitude: 30.296671),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
      ),
      body: YandexMap(
        onMapCreated: (controller) async {
          _controller = controller;
          await _initMap();
        },
      ),
    );
  }
}
