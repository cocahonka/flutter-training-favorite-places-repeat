import 'package:favorite_places_repeat/models/place.dart';
import 'package:favorite_places_repeat/screens/map_screen.dart';
import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({required this.onSaved, super.key});

  final ValueSetter<LatLng> onSaved;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  void _openMap() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) {
          return MapScreen(onSaved: widget.onSaved);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Text(
            'No location chosen',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.place),
                label: const Text('Get Current Location'),
              ),
              TextButton.icon(
                onPressed: _openMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on Map'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
