import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 8, target: LatLng(30.790380837996715, 30.991261896595972));
    initMarkers();
    super.initState();
  }

  Set<Marker> markers = {};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          /*cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              southwest: const LatLng(23.958499556545753, 26.458827024193344),
              northeast: const LatLng(30.26442963963889, 33.2260286684982))),*/
          initialCameraPosition: initialCameraPosition),
      Positioned(
          bottom: 15,
          left: 100,
          right: 100,
          child:
              ElevatedButton(onPressed: () {}, child: const Text("Book Now")))
    ]);
  }

  void initMapStyle() async {
    var lightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/light_map_style.json");
    googleMapController.setMapStyle(lightMapStyle);
  }

  void initMarkers() {
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(.empty), assetName),
            infoWindow: InfoWindow(title: placeModel.name),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.add((myMarker));
  }
}
