import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cocktail/favorites.dart';
import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'cocktail_detail.dart';


class FavoriteList extends StatefulWidget{
  const  FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteList();
}

class _FavoriteList extends State<FavoriteList> {

  List<Cocktail> favorites = [];

  @override
  void initState() {
    super.initState();
    Favorites.getFavorites().then((value) {
      for (String name in value) {
        searchCocktail(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Favorites"),
        ),
        body: SingleChildScrollView(
            child: Center(child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) => favoritesList(context, index),
                shrinkWrap: true,
              ),
            ),
        )));
  }

  Widget favoritesList(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(favorites[index].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(favorites[index].category!),
                  ],
                ),
                const SizedBox(width: 20,),
                // alla getScreenType passiamo il contesto della superclasse perché solo in quel contesto
                // viene rilevata la grandezza dello schermo che interessa
                ...generateTags(favorites[index], getScreenType(super.context)), // x smontare lista in singoli elementi,
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {
                    setState(() {
                      Favorites.removeFavorite(favorites[index].id);
                      favorites.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TheCocktail(cocktail: favorites[index], language: 'en',)))
      },
    );
  }

  Future searchCocktail(String cocktailId) async {
    const domain = 'www.thecocktaildb.com';
    const path = '/api/json/v1/1/lookup.php';
    Map<String, dynamic> parameters = {'i': cocktailId};
    Uri uri = Uri.https(domain, path, parameters);
    http.get(uri).then((result) {
      final cocktailsData = json.decode(result.body);
      final cocktailsDataItem = cocktailsData['drinks'];

      List<Cocktail> cocktails = cocktailsDataItem.map<Cocktail>((json) =>
          Cocktail.fromJson(json, 'en')).toList();
      setState(() {
        favorites.add(cocktails[0]);
      });
    });
  }

}
bool getScreenType(BuildContext context) {

  double screenWidth = MediaQuery.of(context).size.width;

  if(screenWidth < 500){
    return false;
  }
  else{
    return true;
  }
}
