// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, duplicate_ignore, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Addplaces extends StatefulWidget {
  const Addplaces({Key? key}) : super(key: key);

  @override
  _AddplacesState createState() => _AddplacesState();
}

class _AddplacesState extends State<Addplaces> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  File? _image;
  final _picker = ImagePicker();
  late Map<String, dynamic> addingPlace;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ubicationController = TextEditingController();
  double ratingRes = 0.0;
  String categoryoOnSave = 'Hoteles';
  Map<String, dynamic> placeLocation = {};
  String _urlPhoto = '';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ubicationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidht * 0.07),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // _image != Image.file(_image!);
                      await addImage();
                    },
                    child: Container(
                      height: screenHeight * 0.25,
                      width: screenWidht * 0.9,

                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F9FA),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      // ignore: unnecessary_null_comparison
                      child: Card(
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              )
                            : const Center(child: Text('Agregar una imagen')),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.037),
                    width: screenWidht * 0.9,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF4F9FA),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03),
                          border: InputBorder.none,
                          hintText: 'Nombre del lugar'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.037),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            categoryoOnSave = 'Hoteles';
                            hotelesSave();
                            print('Selecciono hoteles');
                          },
                          child: Container(
                            height: screenHeight * 0.034,
                            width: screenWidht * 0.27,
                            decoration: BoxDecoration(
                              color: categoryoOnSave == 'Hoteles'
                                  ? Colors.amber
                                  : const Color(0xFFF4F9FA),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    // ignore: use_full_hex_values_for_flutter_colors
                                    color: Color(0xFF8585851C),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Row(
                              children: [
                                const Text('    Hoteles   '),
                                Image.asset('assets/images/Imagen 5.png')
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoryoOnSave = 'Turistico';
                            turisticoSave();
                            print('Seleccciono turistico');
                          },
                          child: Container(
                            height: screenHeight * 0.034,
                            width: screenWidht * 0.27,
                            decoration: BoxDecoration(
                              color: categoryoOnSave == 'Turistico'
                                  ? Colors.amber
                                  : const Color(0xFFF4F9FA),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    // ignore: use_full_hex_values_for_flutter_colors
                                    color: Color(0xFF8585851C),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Row(
                              children: [
                                const Text('    Turistico   '),
                                Image.asset('assets/images/Imagen 22.png')
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoryoOnSave = 'Restaurante';
                            restauranteSave();
                            print('selecciono Restaurante');
                          },
                          child: Container(
                            height: screenHeight * 0.034,
                            width: screenWidht * 0.25,
                            decoration: BoxDecoration(
                              color: categoryoOnSave == 'Restaurante'
                                  ? Colors.amber
                                  : const Color(0xFFF4F9FA),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFF8585851C),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('    Restaurante  '),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Descripción
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.037),
                    height: screenHeight * 0.20,
                    width: screenWidht * 0.9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F9FA),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: SizedBox(
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 10,
                        decoration: const InputDecoration(
                            hintText: 'Descripción',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.037),
                    width: screenWidht * 0.9,
                    height: screenHeight * 0.053,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF4F9FA),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: TextField(
                      controller: _ubicationController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.03),
                          border: InputBorder.none,
                          hintText: 'Dirección'),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.037),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF4F9FA),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Container(
                      height: screenHeight * 0.04,
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidht * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Calificación'),
                          SizedBox(
                            child: RatingBar.builder(
                                itemSize: 20.0,
                                initialRating: 1,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidht * 0.01),
                                itemBuilder: (_, __) => const Icon(
                                      Icons.star_border_purple500_sharp,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  ratingRes = rating;
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //botons de añadir "check"
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: IconButton(
                        onPressed: () async {
                          await uploadImage();
                          await obtainDirection();
                          await uploadPlace();

                          setState(() {});
                        },
                        icon: const Icon(Icons.check)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future obtainDirection() async {
    List<Location> results = await GeocodingPlatform.instance
        .locationFromAddress(_ubicationController.text)
        .catchError((error) {
      Location defaultLocation = Location(
          latitude: 7.1192899,
          longitude: -73.1679977,
          timestamp: DateTime.now());
      List<Location> resultsError = [defaultLocation];
      return resultsError;
    });

    placeLocation['_latitude'] = results[0].latitude;
    placeLocation['_longitude'] = results[0].longitude;
  }

  Future addImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {}
    setState(() {});
  }

  Future uploadImage() async {
    if (_image == null) return null;

    String fileName = (_image!.path);
    String? link;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('/$fileName');

    final metada = firebase_storage.SettableMetadata(
        contentType: 'image/jpg',
        customMetadata: {
          'picked-file-pacth': fileName,
        });
    firebase_storage.UploadTask uploadTask;
    uploadTask = ref.putFile(File(_image!.path), metada);
//subida de la imagen
    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(task)
        .then((value) => {
              print(
                'Subiendo el archivo ${value.ref.fullPath}',
              )
            })
        .onError((error, stackTrace) => {
              print('Fallo al subir el archivo ${error.toString()}'),
            })
        .then((value) async => {link = await ref.getDownloadURL()})
        .then((value) => print('Url de descarga $link'))
        .then((value) => _urlPhoto = link!);
  }

  void hotelesSave() {
    setState(() {});
  }

  void turisticoSave() {
    setState(() {});
  }

  void restauranteSave() {
    setState(() {});
  }

  uploadPlace() async {
    DocumentReference ref = db.collection('place').doc();

    addingPlace = {
      'photo': _urlPhoto,
      'location': placeLocation,
      'name': _nameController.text,
      'category': categoryoOnSave,
      'description': _descriptionController.text,
      'address': _ubicationController.text,
      'rate': ratingRes,
      'id': ref.id
    };

    await ref.set(addingPlace);
  }
}
