import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Completer<GoogleMapController> _controller = Completer();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.3039, 70.8022),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[];

  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      Get.snackbar("Error", "Error : $error");
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await getCurrentLocation();
          _markers.add(
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: "Your Current Location"),
            ),
          );

          CameraPosition currentCameraPosition = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 14,
          );

          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
              CameraUpdate.newCameraPosition(currentCameraPosition));
          setState(() {});
        },
        child: const Icon(Icons.location_searching_sharp),
      ),
    );
  }
}
