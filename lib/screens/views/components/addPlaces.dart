import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addplaces extends StatefulWidget {
  const Addplaces({Key? key}) : super(key: key);

  @override
  _AddplacesState createState() => _AddplacesState();
}

class _AddplacesState extends State<Addplaces> {
  @override
  var _image;

  final _picker = ImagePicker();

  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidht * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  addImage();
                  _image != Image.file(_image);
                },
                child: Container(
                  height: screenHeight * 0.3,
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
                  child: const Card(
                    child: Center(
                      child: Text('Agregar una imagen'),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidht * 0.9,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFF4F9FA),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFF8585851C),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ],
                ),
                child: const TextField(
                    decoration: InputDecoration(labelText: 'Nombre del lugar')),
              ),
              Row(
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
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      children: [
                        Text('    Hoteles   '),
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
                            color: Color(0xFF8585851C),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      children: [
                        Text('    Turistico   '),
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
              Container(
                height: screenHeight * 0.3,
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
                child: const Text('Descripción'),
              ),
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      } else {
        print('imagen no seleccionada');
      }
    });
  }
}
