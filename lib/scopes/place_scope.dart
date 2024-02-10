import 'package:favorite_places_repeat/scopes/place_bloc.dart';
import 'package:flutter/material.dart';

@immutable
class _PlaceInherited extends InheritedWidget {
  const _PlaceInherited({
    required this.bloc,
    required super.child,
  });

  final PlaceBloc bloc;

  @override
  bool updateShouldNotify(_PlaceInherited oldWidget) {
    return bloc != oldWidget.bloc;
  }
}

class PlaceScope extends StatefulWidget {
  const PlaceScope({required this.child, super.key});

  final Widget child;

  static PlaceBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_PlaceInherited>()!.bloc;
  }

  @override
  State<PlaceScope> createState() => _PlaceScopeState();
}

class _PlaceScopeState extends State<PlaceScope> {
  late final PlaceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PlaceBloc()..read();
  }

  @override
  Widget build(BuildContext context) {
    return _PlaceInherited(
      bloc: _bloc,
      child: widget.child,
    );
  }
}
