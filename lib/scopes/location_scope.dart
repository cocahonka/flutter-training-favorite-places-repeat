import 'package:favorite_places_repeat/scopes/location_bloc.dart';
import 'package:flutter/material.dart';

@immutable
class _LocationInherited extends InheritedWidget {
  const _LocationInherited({
    required this.bloc,
    required super.child,
  });

  final LocationBloc bloc;

  @override
  bool updateShouldNotify(_LocationInherited oldWidget) {
    return bloc != oldWidget.bloc;
  }
}

class LocationScope extends StatefulWidget {
  const LocationScope({required this.child, super.key});

  final Widget child;

  static LocationBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_LocationInherited>()!.bloc;
  }

  @override
  State<LocationScope> createState() => _LocationScopeState();
}

class _LocationScopeState extends State<LocationScope> {
  late final LocationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LocationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return _LocationInherited(
      bloc: _bloc,
      child: widget.child,
    );
  }
}
