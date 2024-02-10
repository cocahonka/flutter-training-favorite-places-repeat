import 'dart:io';

import 'package:favorite_places_repeat/scopes/place_bloc.dart';
import 'package:favorite_places_repeat/scopes/place_scope.dart';
import 'package:favorite_places_repeat/widgets/image_input.dart';
import 'package:favorite_places_repeat/widgets/location_input.dart';
import 'package:favorite_places_repeat/widgets/place_title_field.dart';
import 'package:flutter/material.dart';

class AddPlaceForm extends StatefulWidget {
  const AddPlaceForm({super.key});

  @override
  State<AddPlaceForm> createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends State<AddPlaceForm> {
  late final PlaceBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  String _title = '';
  File? _photo;

  void _saveForm() {
    final formState = _formKey.currentState!;
    final isFormValid = formState.validate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = PlaceScope.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PlaceTitleField(onSaved: (value) => _title = value),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ImageInput(onSaved: (value) => _photo = value),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: LocationInput(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton.icon(
                  onPressed: _saveForm,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
