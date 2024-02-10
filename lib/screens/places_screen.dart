import 'package:favorite_places_repeat/models/place.dart';
import 'package:favorite_places_repeat/scopes/place_bloc.dart';
import 'package:favorite_places_repeat/scopes/place_scope.dart';
import 'package:favorite_places_repeat/screens/add_place_form.dart';
import 'package:favorite_places_repeat/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late final PlaceBloc _bloc;

  void _openAddPlaceFormScreen() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => const AddPlaceForm(),
      ),
    );
  }

  void _openPlaceDetailsScreen(Place place) {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => PlaceDetails(place: place),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = PlaceScope.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: _openAddPlaceFormScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          return switch (snapshot.connectionState) {
            ConnectionState.none || ConnectionState.waiting => const Center(
                child: CircularProgressIndicator(),
              ),
            ConnectionState.active || ConnectionState.done => ListView.separated(
                itemBuilder: (context, index) {
                  final place = snapshot.data![index];
                  return ListTile(
                    title: Text(place.title),
                    subtitle: Text(place.address),
                    leading: const CircleAvatar(),
                    onTap: () => _openPlaceDetailsScreen(place),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: snapshot.data!.length,
              ),
          };
        },
      ),
    );
  }
}
