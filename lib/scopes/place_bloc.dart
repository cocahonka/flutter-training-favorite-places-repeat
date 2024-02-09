import 'dart:async';
import 'dart:collection';

import 'package:favorite_places_repeat/models/place.dart';
import 'package:favorite_places_repeat/scopes/place_repository.dart';

typedef PlaceState = UnmodifiableListView<Place>;

class PlaceBloc {
  final StreamController<PlaceState> _controller = StreamController.broadcast();
  Stream<PlaceState> get stream => _controller.stream;

  List<Place> _state = [];

  final PlaceRepository repository = PlaceRepository(filename: 'places');

  Future<void> add(Place place) async {
    _state = [..._state, place];
    await repository.write(_state);

    _controller.add(PlaceState(_state));
  }

  Future<void> delete(Place place) async {
    _state = [..._state]..remove(place);
    await repository.write(_state);
    _controller.add(PlaceState(_state));
  }

  Future<void> read() async {
    _state = await repository.read();
    _controller.add(PlaceState(_state));
  }
}
