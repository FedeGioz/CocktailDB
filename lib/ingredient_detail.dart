import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'cocktail.dart';
import 'ingredient.dart';

class TheIngredientModalBottom extends StatefulWidget{
  const TheIngredientModalBottom({super.key, required this.ingredient});

  final Ingredient ingredient;

  @override
  State<TheIngredientModalBottom> createState() => _TheIngredientModalBottom();
}

class _TheIngredientModalBottom extends State<TheIngredientModalBottom> {
  Options options = Options(format: Format.rgb, colorType: ColorType.green);

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
            Text("${widget.ingredient.name} (${widget.ingredient.type})"),
            const SizedBox(height: 10,),
            const Text("ABV", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${widget.ingredient.abv}%"),
            const SizedBox(height: 10,),
            const Text("Description", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${widget.ingredient.description}")
          ],
        ),
        ));
  }

  List<Widget> generateTags(Cocktail cocktail) {
    List<dynamic> colors = [Colors.red, Colors.lightGreen, Colors.amberAccent, Colors.lightBlueAccent, Colors.orangeAccent];
    final _random = new Random();
    List<Widget> tags = [];
    if(cocktail.tags != null ){
      for(String tag in cocktail.tags!){
        if(tags.length < 5){
          tags.add(Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Adjust padding as needed
            decoration: BoxDecoration(
              color: colors[_random.nextInt(colors.length)], // Background color of the tag
              borderRadius: BorderRadius.circular(25), // Adjust for more or less rounded corners
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 10, // Adjust text size as needed
              ),
            ),
          ));
          tags.add(SizedBox(width: 5,));
        }
      }
    }
    return tags;
  }
}

