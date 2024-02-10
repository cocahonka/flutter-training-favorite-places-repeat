package com.example.favorite_places_repeat

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey("a5039f3d-4ead-45d7-9084-42248918d28e")
  }
}
