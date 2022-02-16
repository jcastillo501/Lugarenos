import 'package:flutter/material.dart';
import 'package:lugarenos/screens/screenInfo/infoPlaces.dart';
import 'package:lugarenos/screens/views/components/Apis/place.dart';

class PlaceSearchDelegate extends SearchDelegate {
  List<Place> originalList = [];

  PlaceSearchDelegate({
    required this.originalList,
  });

  @override
  String? get searchFieldLabel => 'Busca un lugar';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  late String seleccted;
  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Place> suggestionsList = [];
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.place_outlined,
          color: Colors.red,
          size: 100,
        ),
      );
    } else {
      suggestionsList.addAll(
          originalList.where((element) => element.name.contains(query)));
    }
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(suggestionsList[index].name),
        leading: Image.network(suggestionsList[index].photo,
            width: MediaQuery.of(context).size.width * 0.14),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => InfoPlaces(placeInfo: suggestionsList[index])));
        },
      ),
    );
  }
}
