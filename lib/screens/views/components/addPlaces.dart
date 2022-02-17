// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names, duplicate_ignore, avoid_print

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Addplaces extends StatefulWidget {
  const Addplaces({Key? key}) : super(key: key);

  @override
  _AddplacesState createState() => _AddplacesState();
}

class _AddplacesState extends State<Addplaces> {
  File? _image;
  final _picker = ImagePicker();
  late Place addingPlaces;
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
                          hintText: 'Nombre del lugar')),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.037),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: screenHeight * 0.034,
                        width: screenWidht * 0.27,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F9FA),
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
                      Container(
                        height: screenHeight * 0.034,
                        width: screenWidht * 0.27,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F9FA),
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
                      Container(
                        height: screenHeight * 0.034,
                        width: screenWidht * 0.25,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F9FA),
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.037),
                  height: screenHeight * 0.25,
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
                  child: const SizedBox(
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: 'Descripción',
                          border: OutlineInputBorder()),
                    ),
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
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Calificación'),
                        SizedBox(
                          child: Row(
                            children: const [
                              Icon(Icons.star_border_outlined),
                              Icon(Icons.star_border_outlined),
                              Icon(Icons.star_border_outlined),
                              Icon(Icons.star_border_outlined),
                              Icon(Icons.star_border_outlined),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //botons de añadir "check"
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: IconButton(
                      onPressed: () {
                        uploadImage();
                      },
                      icon: const Icon(Icons.check)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {}
    setState(() {});
  }

  Future uploadImage() async {
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
        .then((value) => print('Url de descarga $link'));
  }
}
