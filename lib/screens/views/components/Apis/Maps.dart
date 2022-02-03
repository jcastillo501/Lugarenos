import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SizedBox(
        child: GoogleMap(
            onMapCreated: initController,
            initialCameraPosition:
                const CameraPosition(target: LatLng(-13.6574511, -69.7145414))),
        height: 400,
        width: 300,
      ),
    );
  }

  void initController(GoogleMapController controller) {
    _controller = controller;
  }
}
