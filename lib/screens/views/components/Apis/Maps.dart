import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugarenos/screens/login/components/loginScreen.dart';
import 'package:lugarenos/screens/screenInfo/InfoPlaces.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:lugarenos/screens/views/viewMain.dart';

class Maps extends StatefulWidget {
  final Place placeInfo;

  const Maps({Key? key, required this.placeInfo}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  final CameraPosition _initialPosition =
      const CameraPosition(target: (LatLng(4.5981, -74.0799)), zoom: 10);
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: screenWidht,
              height: screenHeight,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                // minMaxZoomPreference: MinMaxZoomPreference(9, 10),
                onMapCreated: (GoogleMapController controller) =>
                    mapController = controller,
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.0099,
              child: Container(
                height: screenHeight * 0.27,
                width: screenWidht,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: screenWidht * 0.06,
                          left: screenWidht * 0.06,
                          bottom: screenHeight * 0.03,
                          top: screenHeight * 0.009),
                      child: Text(
                        widget.placeInfo.name,
                        style: TextStyle(
                            fontSize: screenWidht * 0.09,
                            color: const Color(0xFF033236)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: screenWidht * 0.06,
                          left: screenWidht * 0.06,
                          bottom: screenHeight * 0.03),
                      child: Text(
                        widget.placeInfo.address,
                        style: TextStyle(
                            fontSize: screenWidht * 0.04,
                            color: const Color(0xFFFCA772)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: const [
                            // Icon(Icons.car_repair),
                            Text('')
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.directions_walk_outlined),
                            Text(
                              '30min',
                              style: TextStyle(
                                  fontSize: screenWidht * 0.050,
                                  color: Color(0xFF033236)),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidht * 0.05, left: screenWidht * 0.01),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xffFCA772)),
                          textStyle: const TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(MaterialPageRoute(builder: (_) => ViewMain()));
                      },
                      child: const Text(' Regresar')),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidht * 0.05),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xffFCA772)),
                          textStyle: const TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text('Iniciar Sesión')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void initController(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }
}
