import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'ingredient.dart';
import 'ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TheIngredientModalBottom extends StatefulWidget{
  const TheIngredientModalBottom({super.key, required this.ingredientName});

  final String ingredientName;

  @override
  State<TheIngredientModalBottom> createState() => _TheIngredientModalBottom();
}

class _TheIngredientModalBottom extends State<TheIngredientModalBottom> {

  Ingredient? ingredient;

  @override
  void initState() {
    searchIngredient(widget.ingredientName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Ingredient Detail"),
        ),
        body: Center(child: Column(
          children: [
            const SizedBox(height: 10,),
            const SizedBox(height: 5,),
            const Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${this.ingredient?.name} (${this.ingredient?.type})"),
            const SizedBox(height: 10,),
            const Text("ABV", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${this.ingredient?.abv}%"),
            const SizedBox(height: 10,),
            const Text("Description", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${this.ingredient?.description}")
          ],
        ),
        ));
  }

  Future searchIngredient(String ingredientName) async {
    const domain = 'www.thecocktaildb.com';
    const path = '/api/json/v1/1/search.php';
    Map<String, dynamic> parameters = {'i': ingredientName};
    Uri uri = Uri.https(domain, path, parameters);
    http.get(uri).then((result) {
      print(result.body);
      final ingredientsData = json.decode(result.body);
      final ingredientDataItem = ingredientsData['ingredients'];
      List<Ingredient> ingredient = ingredientDataItem.map<Ingredient>((json) =>
          Ingredient.fromJson(json)).toList();
      setState(() {
        this.ingredient = ingredient[0];
      });

    });

  }
}

