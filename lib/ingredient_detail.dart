import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TheIngredientModalBottom extends StatefulWidget{
  const TheIngredientModalBottom({super.key, required this.ingredientName, required this.language});

  final String ingredientName;
  final String language;

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
        body: SingleChildScrollView(
            child: createIngredient()
        ));
  }

  Widget createIngredient(){
    if(ingredient == null){
      return const Center( child: Text("No information"),);
    }
    else{
      return Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const SizedBox(height: 5,),
              const Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("${ingredient?.name} (${ingredient?.type})"),
              const SizedBox(height: 10,),
              const Text("ABV", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("${ingredient?.abv}%"),
              const SizedBox(height: 10,),
              const Text("Description", style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                  constraints: BoxConstraints(
                      maxWidth: getWidthFromScreenSize(context)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text("${ingredient?.description}")
                  )
              ),
              checkTranslation(ingredient!.description ?? "", widget.language),
            ],
          ),
      );
    }
  }

  Future searchIngredient(String ingredientName) async {
    const domain = 'www.thecocktaildb.com';
    const path = '/api/json/v1/1/search.php';
    Map<String, dynamic> parameters = {'i': ingredientName};
    Uri uri = Uri.https(domain, path, parameters);
    http.get(uri).then((result) {
      final ingredientsData = json.decode(result.body);
      final ingredientDataItem = ingredientsData['ingredients'];
      List<Ingredient> ingredient = ingredientDataItem.map<Ingredient>((json) =>
          Ingredient.fromJson(json)).toList();
      setState(() {
        this.ingredient = ingredient[0];
      });
    });
  }

  checkTranslation(String s, String language) {
    if(language != "EN"){
      GoogleTranslator translator = GoogleTranslator();
      translator.translate(s, to: language.toLowerCase()).then((value) {
        setState(() {
          ingredient?.description = value.text;
        });
      });
    }
    return Container();
  }
}

double getWidthFromScreenSize(BuildContext context) {

  double screenWidth = MediaQuery.of(context).size.width;
  double textWidth = 0;

  if(screenWidth < 450){
    textWidth = screenWidth - 50;
  }
  else{
    textWidth = 540;
  }

  return textWidth;
}

