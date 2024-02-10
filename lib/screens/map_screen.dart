import 'package:favorite_places_repeat/models/place.dart';
import 'package:favorite_places_repeat/scopes/location_bloc.dart';
import 'package:favorite_places_repeat/scopes/location_scope.dart';
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
  late final LocationBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LocationScope.of(context)..loadLocation();
  }

  Future<void> _initMap(LatLng location) async {
    await _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: Point(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
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
      body: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          return switch (snapshot.data) {
            null => const Center(child: CircularProgressIndicator()),
            DisabledLocationState() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You off location service, try again',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: () => _bloc.loadLocation(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            EnabledLocationState(location: final location) => YandexMap(
                onMapCreated: (controller) async {
                  _controller = controller;
                  await _initMap(location);
                },
              ),
          };
        },
      ),
    );
  }
}
