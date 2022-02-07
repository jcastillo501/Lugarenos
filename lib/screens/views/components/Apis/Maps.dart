import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: screenWidht,
        height: screenHeight,
        child: GoogleMap(
            onMapCreated: initController,
            initialCameraPosition:
                const CameraPosition(target: (LatLng(4.5981, -74.0799)))),
      ),
    );
  }

  void initController(GoogleMapController controller) {
    _controller = controller;
  }
}
