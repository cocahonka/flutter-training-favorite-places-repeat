import 'dart:async';

import 'package:favorite_places_repeat/models/place.dart';
import 'package:location/location.dart';

class LocationBloc {
  final StreamController<LocationState> _controller = StreamController.broadcast();
  Stream<LocationState> get stream => _controller.stream;

  final Location _locationPlatform = Location();

  Future<void> loadLocation() async {
    if (!await _enableLocation()) {
      _controller.add(const DisabledLocationState());
      return;
    }

    final locationData = await _locationPlatform.getLocation();
    final state = EnabledLocationState(
      (
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      ),
    );
    _controller.add(state);
  }

  Future<bool> _enableLocation() async {
    var serviceEnabled = await _locationPlatform.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationPlatform.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    var permissionGranted = await _locationPlatform.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationPlatform.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }
}

sealed class LocationState {
  const LocationState();
}

class DisabledLocationState extends LocationState {
  const DisabledLocationState();
}

class EnabledLocationState extends LocationState {
  const EnabledLocationState(this.location);
  final LatLng location;
}
