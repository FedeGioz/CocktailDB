import 'dart:math';

import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'ingredient.dart';

class TheIngredientModalBottom extends StatefulWidget{
  const TheIngredientModalBottom({super.key, required this.ingredient});

  final Ingredient ingredient;

  @override
  State<TheIngredientModalBottom> createState() => _TheIngredientModalBottom();
}

class _TheIngredientModalBottom extends State<TheIngredientModalBottom> {
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
}

