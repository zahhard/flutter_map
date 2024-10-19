// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//
// class Mapp extends StatefulWidget {
//   const Mapp({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _Map();
// }
//
// class _Map extends State<Mapp> {
//   late MapController mapController;
//
//   final originGeo = GeoPoint(latitude: 35.671474, longitude: 51.422426);
//   final destinationGeo = GeoPoint(latitude: 35.729949, longitude: 51.410962);
//
//   @override
//   void initState() {
//     super.initState();
//     mapController = MapController(initPosition: originGeo);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await mapController.addMarker(originGeo,
//               markerIcon: const MarkerIcon(
//                 icon: Icon(
//                   Icons.location_pin,
//                   color: Colors.indigo,
//                   size: 25,
//                 ),
//               ));
//           await mapController.addMarker(destinationGeo,
//               markerIcon: const MarkerIcon(
//                 icon: Icon(
//                   Icons.location_pin,
//                   color: Colors.indigo,
//                   size: 25,
//                 ),
//               ));
//           mapController.enableTracking();
//           await mapController.goToLocation(originGeo);
//           mapController.drawRoad(originGeo, destinationGeo, roadType: RoadType.car, roadOption: RoadOption(roadColor: Colors.indigo));
//         },
//         child: Icon(Icons.add_location),
//       ),
//       body: OSMFlutter(
//           controller: mapController,
//           osmOption: const OSMOption(zoomOption: ZoomOption(initZoom: 14))),
//     );
//   }
// }
//





import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class Mapp extends StatefulWidget {
  const Mapp({super.key});

  @override
  State<StatefulWidget> createState() => _Map();
}

class _Map extends State<Mapp> {
  late MapController mapController;
  Timer? locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    mapController = MapController(initPosition: GeoPoint(latitude: 35.671474, longitude: 51.422426));
    _startLocationUpdates();
  }

  @override
  void dispose() {
    locationUpdateTimer?.cancel();
    super.dispose();
  }

  Future<void> _startLocationUpdates() async {
    await _checkLocationPermission();
    // هر 5 ثانیه یک بار موقعیت جدید کاربر گرفته شود
    locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final currentPosition = GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // نمایش نشانگر موقعیت لحظه‌ای کاربر
      await mapController.addMarker(currentPosition,
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.red,
              size: 40,
            ),
          ));

      // حرکت به موقعیت جدید
      await mapController.changeLocation(currentPosition);
      await mapController.goToLocation(currentPosition);
    });
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: mapController,
        osmOption: const OSMOption(zoomOption: ZoomOption(initZoom: 14)),
      ),
    );
  }
}
