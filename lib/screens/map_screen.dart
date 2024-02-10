import 'package:favorite_places_repeat/models/place.dart';
import 'package:favorite_places_repeat/scopes/location_bloc.dart';
import 'package:favorite_places_repeat/scopes/location_scope.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.placeLocation, this.onSaved});

  final LatLng? placeLocation;
  final ValueSetter<LatLng>? onSaved;

  bool get isSelecting => placeLocation == null;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _controller;
  late final LocationBloc _bloc;
  late PlacemarkMapObject _placemark;

  var _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LocationScope.of(context)..loadLocation();

    _placemark = PlacemarkMapObject(
      mapId: const MapObjectId('placemark'),
      point: const Point(latitude: 0, longitude: 0),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/place.png')),
      ),
    );
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

    setState(() {
      _placemark = _placemark.copyWith(
        point: Point(
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      );
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
      ),
      floatingActionButton: widget.isSelecting
          ? FloatingActionButton(
              onPressed: _loading
                  ? null
                  : () {
                      final point = _placemark.point;
                      final location = (latitude: point.latitude, longitude: point.longitude);
                      final method = widget.onSaved;
                      if (method != null) {
                        method(location);
                      }
                      Navigator.of(context).pop();
                    },
              child: const Icon(Icons.save),
            )
          : null,
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
                  await _initMap(widget.placeLocation ?? location);
                },
                onMapTap: widget.isSelecting
                    ? (location) {
                        setState(() {
                          _placemark = _placemark.copyWith(point: location);
                        });
                      }
                    : null,
                mapObjects: [_placemark],
              ),
          };
        },
      ),
    );
  }
}
