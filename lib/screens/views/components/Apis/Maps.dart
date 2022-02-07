import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugarenos/screens/screenInfo/InfoPlaces.dart';
import 'package:lugarenos/screens/screenInfo/infoPlaces.dart' as infoplaces;

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
        child: Column(
          children: [
            GoogleMap(
                onMapCreated: initController,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(-13.6574511, -69.7145414))),
            // Container(

            //   child: Column(
            //     children: [],
            //   ),
            // )
          ],
        ),
        height: 400,
        width: 300,
      ),
    );
  }

  void initController(GoogleMapController controller) {
    _controller = controller;
  }
}
