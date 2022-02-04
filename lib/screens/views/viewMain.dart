import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lugarenos/screens/views/components/Apis/place.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                    color: Color(0x382D31E9),
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
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.05),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    const Color(0xffFCA772)),
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0))),
                                    onPressed: () {},
                                    child: const Text('Iniciar Sesión')),
                              ),
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
                                        TextStyle(fontSize: screenWidth * 0.06),
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
                                  right: screenWidth * 0.43,
                                  top: screenHeigth * 0.04),
                              child: Text(
                                'Que estas bucando hoy?',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: screenWidth * 0.025),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.10),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.zoom_in)),
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
                      const Text(
                        'Hoteles',
                        style: TextStyle(color: Color(0xFFC1CDCE)),
                      ),
                      Image.asset('assets/images/Imagen 5.png'),
                      const Text(
                        'Clasificación',
                        style: TextStyle(color: Color(0xFFC1CDCE)),
                      ),
                      Image.asset('assets/images/Imagen 6.png'),
                      const Text(
                        'Ubicacion',
                        style: TextStyle(color: Color(0xFFC1CDCE)),
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

                Container(
                  // color: Colors.blue,
                  height: screenHeigth * 0.40,
                  width: screenWidth,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: placesList.length,
                      itemBuilder: (BuildContext contex, int index) {
                        return (index > 2)
                            ? Container(
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
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                            placesList[index].photo)),
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
                                                  color:
                                                      const Color(0xFF033236)),
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
        ? Container(
            height: screenHeigth * 0.45,
            width: screenWidth,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Text(
                                placesList[0].name + ' ',
                                style: TextStyle(
                                    fontSize: (screenWidth * 0.036),
                                    color: const Color(0xFF033236)),
                              ),
                              Text(
                                placesList[0].address,
                                style: TextStyle(
                                    fontSize: (screenWidth * 0.013),
                                    color: const Color(0xFFFCA772)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                              bottom: screenHeigth * 0.02,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.04,
                                      right: screenWidth * 0.12,
                                      top: screenHeigth * 0.01),
                                  margin: EdgeInsets.only(
                                      left: screenWidth * 0.009,
                                      right: screenWidth * 0.01),
                                  // width: screenWidth,
                                  height: screenHeigth * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text(
                                        placesList[1].name + ' ',
                                        style: TextStyle(
                                            fontSize: (screenWidth * 0.025),
                                            color: const Color(0xFF033236)),
                                      ),
                                      Text(
                                        placesList[1].address,
                                        style: TextStyle(
                                            fontSize: (screenWidth * 0.013),
                                            color: const Color(0xFFFCA772)),
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
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
                            bottom: screenHeigth * 0.01,
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.04,
                                      right: screenWidth * 0.12,
                                      top: screenHeigth * 0.02),
                                  margin: EdgeInsets.only(
                                      left: screenWidth * 0.009,
                                      right: screenWidth * 0.01),
                                  // width: screenWidth,
                                  height: screenHeigth * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text(
                                        placesList[2].name + ' ',
                                        style: TextStyle(
                                            fontSize: (screenWidth * 0.022),
                                            color: const Color(0xFF033236)),
                                      ),
                                      Text(
                                        placesList[2].address,
                                        style: TextStyle(
                                            fontSize: (screenWidth * 0.013),
                                            color: const Color(0xFFFCA772)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Future<void> getPlaces() async {
    Uri url = Uri.parse(
        'https://us-central1-domi-test-d4e69.cloudfunctions.net/getPlacesTest');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = jsonDecode(response.body);

      for (Map<String, dynamic> item in decoded['places']) {
        Place dt = Place.fromMap(item);
        placesList.add(dt);
      }

      placesList.sort((a, b) => b.rate.compareTo(a.rate));
      setState(() {});
    } else {
      print('upps');
    }
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
}
