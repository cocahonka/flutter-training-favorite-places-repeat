import 'package:favorite_places_repeat/scopes/location_scope.dart';
import 'package:favorite_places_repeat/scopes/place_scope.dart';
import 'package:favorite_places_repeat/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FavoritePlacesApp());
}

class FavoritePlacesApp extends StatelessWidget {
  const FavoritePlacesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LocationScope(
      child: PlaceScope(
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 20, 120),
              brightness: Brightness.dark,
            ),
            textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
              titleLarge: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleMedium: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleSmall: GoogleFonts.ubuntuCondensed(),
            ),
          ),
          home: const PlacesScreen(),
        ),
      ),
    );
  }
}
