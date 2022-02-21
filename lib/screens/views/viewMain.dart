// ignore_for_file: file_names, use_full_hex_values_for_flutter_colors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lugarenos/screens/login/components/loginScreen.dart';
import 'package:lugarenos/screens/login/components/services/auth_service.dart';
import 'package:lugarenos/screens/screenInfo/InfoPlaces.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:lugarenos/screens/views/components/addPlaces.dart';
import 'package:lugarenos/search/search_delegate.dart';

class ViewMain extends StatefulWidget {
  const ViewMain({Key? key}) : super(key: key);

  @override
  _ViewMainState createState() => _ViewMainState();
}

class _ViewMainState extends State<ViewMain> {
  List<Place> placesList = [];

  late double screenHeigth;
  late double screenWidth;
  bool firstEnter = false;

  String categorySelected = 'Calificación';
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: screenWidth,
          height: screenHeigth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //Contenedor con el boton de inicio, y listView
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    color: Color(0xFFF4F9FA),
                  ),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: screenHeigth * 0.05,
                              top: screenHeigth * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.05),
                                child: const Icon(
                                  Icons.menu_rounded,
                                ),
                              ),
                              FirebaseAuth.instance.currentUser == null
                                  //Iniciar sesion
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.05),
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          const Color(
                                                              0xffFCA772)),
                                              textStyle: const TextStyle(
                                                  color: Colors.white),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const LoginScreen()));
                                          },
                                          child: const Text('Iniciar Sesión')),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          right: screenWidth * 0.05),
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          const Color(
                                                              0xffFCA772)),
                                              textStyle: const TextStyle(
                                                  color: Colors.white),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                          onPressed: () {
                                            _authService.signout();
                                            setState(() {});
                                          },
                                          child: const Text('Cerrar Sesion')),
                                    )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth * 0.06,
                                  ),
                                  child: Text(
                                    'Encuentra\nlos mejores\nlugares de\nLa ciudad',
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.08),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenHeigth * 0.019),
                                  child:
                                      Image.asset('assets/images/Imagen 7.png'),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.50,
                                  bottom: screenHeigth * 0.04,
                                  top: screenHeigth * 0.02),
                              child: Text(
                                'Que estas bucando hoy?',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.056),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.0020),
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                // enabled: false,
                                // textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    icon: Container(
                                  height: screenHeigth * 0.055,
                                  width: screenWidth * 0.14,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF3F2F2),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFF70707029),
                                            spreadRadius: 4,
                                            blurRadius: 10,
                                            offset: Offset(0, 2))
                                      ]),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.zoom_in,
                                      size: 30,
                                    ),
                                    onPressed: () => showSearch(
                                        context: context,
                                        delegate: PlaceSearchDelegate(
                                          originalList: placesList,
                                        )),
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: screenHeigth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          categorySelected = 'Hoteles';
                          getCategoriesHotels();
                        },
                        child: Container(
                          height: screenHeigth * 0.04,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                              color: categorySelected == 'Hoteles'
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Hoteles ',
                                style: TextStyle(color: Color(0xFFC1CDCE)),
                              ),
                              Image.asset('assets/images/Imagen 5.png'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          categorySelected = 'Calificación';
                          getCategoriesClasificacion();
                        },
                        child: Container(
                          height: screenHeigth * 0.04,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                              color: categorySelected == 'Calificación'
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Calificación ',
                                style: TextStyle(
                                    color: categorySelected == 'Calificación'
                                        ? Colors.white
                                        : const Color(0xFFC1CDCE)),
                              ),
                              Image.asset('assets/images/Imagen 6.png'),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          categorySelected = 'Ubicacion';
                          await getCategoriesUbication();
                        },
                        child: Container(
                          height: screenHeigth * 0.04,
                          width: screenWidth * 0.25,
                          decoration: BoxDecoration(
                              color: categorySelected == 'Ubicacion'
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const Text(
                                'Ubicacion ',
                                style: TextStyle(color: Color(0xFFC1CDCE)),
                              ),
                              Image.asset('assets/images/Imagen 19.png')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Ubicados por mayor Calificacion
                //Filtrar lista descendente por calif
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeigth * 0.05),
                  child: Text(
                    'Lugares\ndestacados',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: screenHeigth * 0.04,
                        color: const Color(0xFF033236)),
                  ),
                ),

                //-------------------------------------------------//
                //Container de imagenes destacadas**
                //------------------------------------------------//
                buildPopularPlaces(),

                //Boton agregar mas lugares
                if (FirebaseAuth.instance.currentUser != null)
                  Center(
                      child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Addplaces()));
                    },
                    child: const Icon(Icons.add_circle_outlined, size: 30),
                  ))
                else
                  const SizedBox(),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeigth * 0.05),
                  child: Text(
                    'Mas lugares',
                    style: TextStyle(
                        fontSize: screenHeigth * 0.03,
                        color: const Color(0xFF033236)),
                  ),
                ),

                SizedBox(
                  height: screenHeigth * 0.40,
                  width: screenWidth,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: placesList.length,
                      itemBuilder: (BuildContext contex, int index) {
                        return (index > 2)
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => InfoPlaces(
                                        placeInfo: placesList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: (index == 0)
                                          ? screenWidth * 0.04
                                          : screenWidth * 0.07,
                                      bottom: screenHeigth * 0.03),
                                  child: Stack(
                                    children: [
                                      Hero(
                                        tag: placesList[index].id,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(
                                                placesList[index].photo)),
                                      ),
                                      Positioned(
                                        bottom: screenHeigth * 0.02,
                                        right: screenWidth * 0.04,
                                        left: screenWidth * 0.01,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.1,
                                              right: screenWidth * 0.1,
                                              top: screenHeigth * 0.01),
                                          margin: EdgeInsets.only(
                                              left: screenWidth * 0.01,
                                              right: screenWidth * 0.01),
                                          width: screenWidth,
                                          height: screenHeigth * 0.06,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                placesList[index].name + ' ',
                                                style: TextStyle(
                                                    fontSize:
                                                        (screenWidth * 0.032),
                                                    color: const Color(
                                                        0xFF033236)),
                                              ),
                                              Text(
                                                placesList[index].address,
                                                style: const TextStyle(
                                                  fontSize: (8.0),
                                                  color: Colors.amber,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPopularPlaces() {
    return (placesList.isNotEmpty)
        ? SizedBox(
            height: screenHeigth * 0.45,
            width: screenWidth,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => InfoPlaces(
                          placeInfo: placesList[0],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    height: screenHeigth * 0.45,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lime),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            placesList[0].photo,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.02,
                          right: screenWidth * 0.02,
                          bottom: screenHeigth * 0.01,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.04,
                                right: screenWidth * 0.02,
                                top: screenHeigth * 0.01,
                                bottom: screenHeigth * 0.01),
                            width: screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  placesList[0].name + ' ',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: (screenWidth * 0.029),
                                      color: const Color(0xFF033236)),
                                ),
                                Text(
                                  placesList[0].address,
                                  style: TextStyle(
                                      fontSize: (screenWidth * 0.020),
                                      color: const Color(0xFFFCA772)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => InfoPlaces(
                              placeInfo: placesList[1],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: screenWidth * 0.05),
                        width: screenWidth * 0.45,
                        height: screenHeigth * 0.22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  placesList[1].photo,
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                              left: screenWidth * 0.02,
                              right: screenWidth * 0.02,
                              bottom: screenHeigth * 0.01,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.04,
                                    right: screenWidth * 0.02,
                                    top: screenHeigth * 0.01,
                                    bottom: screenHeigth * 0.01),
                                width: screenWidth,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      placesList[1].name + ' ',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: (screenWidth * 0.029),
                                          color: const Color(0xFF033236)),
                                    ),
                                    Text(
                                      placesList[1].address,
                                      style: TextStyle(
                                          fontSize: (screenWidth * 0.020),
                                          color: const Color(0xFFFCA772)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    panelDeInformacion(),
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget panelDeInformacion() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => InfoPlaces(
              placeInfo: placesList[2],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(right: screenWidth * 0.05),
        width: screenWidth * 0.45,
        height: screenHeigth * 0.22,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  placesList[2].photo,
                  fit: BoxFit.fill,
                )),
            Positioned(
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
              bottom: screenHeigth * 0.01,
              child: Container(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.02,
                    top: screenHeigth * 0.01,
                    bottom: screenHeigth * 0.01),
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placesList[2].name + ' ',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: (screenWidth * 0.029),
                          color: const Color(0xFF033236)),
                    ),
                    Text(
                      placesList[2].address,
                      style: TextStyle(
                          fontSize: (screenWidth * 0.020),
                          color: const Color(0xFFFCA772)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaces() async {
    Uri url = Uri.parse(
        'https://us-central1-domi-test-d4e69.cloudfunctions.net/getPlacesTest');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = jsonDecode(response.body);

      for (Map<String, dynamic> item in decoded['places']) {
        Place dt = Place.fromMap(item, 0);
        placesList.add(dt);
      }

      placesList.sort((a, b) => b.rate.compareTo(a.rate));
      setState(() {});
    } else {
      // ignore: avoid_print
      print('upps');
    }
  }

  Future<void> getCategoriesHotels() async {
    placesList.sort((a, b) => a.category.compareTo(b.category));
    setState(() {});
  }

  Future<void> getCategoriesClasificacion() async {
    placesList.sort((a, b) => b.rate.compareTo(a.rate));
    setState(() {});
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

  Future<void> getCategoriesUbication() async {
    Position position = await _determinePosition();
    for (Place item in placesList) {
      item.distance = Geolocator.distanceBetween(position.latitude,
          position.longitude, item.location.latitude, item.location.longitude);
    }
    placesList.sort((a, b) => a.distance.compareTo(b.distance));
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    if (!firstEnter) {
      firstEnter = true;
      screenWidth = MediaQuery.of(context).size.width;
      screenHeigth = MediaQuery.of(context).size.height;

      await getPlaces();
    }
    super.didChangeDependencies();
  }

  Future loader() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
