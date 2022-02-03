import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  late String photo;
  late LatLng location;
  late double rate;
  late String name;
  late String address;
  late String description;
  late String category;
  late String id;

  Place.fromMap(Map<String, dynamic> map) {
    photo = map['photo'];
    location =
        LatLng(map['location']['_latitude'], map['location']['_longitude']);
    rate = double.parse(map['rate'].toString());
    name = map['name'];
    address = map['address'];
    description = map['description'];
    category = map['category'];
    id = map['id'];
  }
}
