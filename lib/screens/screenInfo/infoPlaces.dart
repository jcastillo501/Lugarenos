// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugarenos/screens/views/components/Apis/Maps.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:lugarenos/screens/views/viewMain.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_utils/google_maps_utils.dart' as poly;

class InfoPlaces extends StatelessWidget {
  final Place placeInfo;
  InfoPlaces({Key? key, required this.placeInfo}) : super(key: key);
  final List<LatLng> coorPoly = [];
  @override
  Widget build(BuildContext context) {
    Future loader() async {
      showDialog(
          useRootNavigator: true,
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
    }

    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30))),
                      width: screenWidht,
                      height: screenHeight * 0.35,
                      child: Hero(
                        tag: placeInfo.id,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30)),
                            child: Image.network(placeInfo.photo,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidht * 0.05,
                              left: screenWidht * 0.01),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => const Color(0xffFCA772)),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                Navigator.of(context).pop(
                                  MaterialPageRoute(builder: (_) => ViewMain()),
                                );
                              },
                              child: const Text(' Regresar')),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenWidht * 0.05),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => const Color(0xffFCA772)),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                  'LoginScreen',
                                );
                              },
                              child: const Text('Iniciar Sesión')),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidht * 0.06, top: screenHeight * 0.04),
                  child: Text(
                    placeInfo.name,
                    style: TextStyle(
                      color: const Color(0xFF033236),
                      fontSize: screenWidht * 0.09,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '     ' + placeInfo.address + '  ',
                      style: TextStyle(
                          fontSize: screenWidht * 0.05,
                          color: const Color(0xFFFCA772)),
                    ),
                    Text(
                      '/  ' + placeInfo.category,
                      style: TextStyle(
                          fontSize: screenWidht * 0.05,
                          color: const Color(0xFFC1CDCE)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: screenWidht * 0.06,
                      left: screenWidht * 0.06,
                      top: screenHeight * 0.03,
                      bottom: screenHeight * 0.03),
                  child: Text(
                    placeInfo.description,
                    style: TextStyle(
                        fontSize: screenWidht * 0.05,
                        color: const Color(0xFF033236)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidht * 0.06,
                          vertical: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFE4E6E6),
                      ),
                      child: Row(children: [
                        const Text(
                          'Calificación  ' '  ',
                          style: TextStyle(color: Color(0xFFD4D6D6)),
                        ),
                        Image.asset('assets/images/Imagen 18.png')
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidht * 0.06,
                          vertical: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFE4E6E6),
                      ),
                      child: Container(
                        child: GestureDetector(
                          onTap: () async {
                            loader();
                            Position userPosition = await _determinePosition();
                            await getRoute(
                                LatLng(userPosition.latitude,
                                    userPosition.longitude),
                                placeInfo.location);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => Maps(
                                        userLocation: LatLng(
                                            userPosition.latitude,
                                            userPosition.longitude),
                                        placeInfo: placeInfo,
                                        pointcoor: coorPoly,
                                      )),
                            );
                          },
                          child: Row(children: [
                            const Text(
                              'Como llegar  ' '  ',
                              style: TextStyle(color: Color(0xFFCCD1D1)),
                            ),
                            Image.asset('assets/images/Imagen 19.png')
                          ]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('GPS desactivado');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permisos de ubicacion denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicacion fueron denegados permanentemente');
    } else {
      return await Geolocator.getCurrentPosition();
    }
  }

  Future<void> getRoute(LatLng origen, LatLng destino) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origen.latitude},${origen.longitude}&destination=${destino.latitude},${destino.longitude},&key=AIzaSyAf3_8-gLVLSQhx_CvOuA_h1-i69BSTQjE');
    http.Response res = await http.get(url);
    Map dats = jsonDecode(res.body);

    var overViewpoly = dats['routes'][0]["overview_polyline"]["points"];
    List<Point<num>> mypoints = poly.PolyUtils.decode(overViewpoly);
    print(mypoints);
    for (Point<num> point in mypoints) {
      coorPoly.add(LatLng(point.x.toDouble(), point.y.toDouble()));
    }
  }
}
