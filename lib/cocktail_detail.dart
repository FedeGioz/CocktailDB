import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'cocktail.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cocktailDetail',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TheCocktail(cocktail: Cocktail("12", "name", null, "category", true, "glass", "instruction", ["Gin", "Limone"], [], "https://upload.wikimedia.org/wikipedia/commons/f/fd/Classic_Daiquiri_in_Cocktail_Glass.jpg"),),
    );
  }
}

class TheCocktail extends StatefulWidget{
  const TheCocktail({super.key, required this.cocktail});

  final Cocktail cocktail;

  @override
  State<TheCocktail> createState() => _TheCocktail();

}

class _TheCocktail extends State<TheCocktail> {
  Options options = Options(format: Format.rgb, colorType: ColorType.green);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cocktail Detail"),
      ),
      body: Center(child: Column(
        children: [
          const SizedBox(height: 50,),
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.cocktail.thumbnail!),
                radius: 100,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.network(
                  widget.cocktail.isAlcoholic
                      ? "https://i.ibb.co/9whJMfN/alcholic.png"
                      : "https://i.ibb.co/48JQrNt/non-alcolholic.png",
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: generateTags(widget.cocktail),),
          const SizedBox(height: 10,),
          const Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Text("${widget.cocktail.name} (${widget.cocktail.category})"),
          const SizedBox(height: 10,),
          const Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          buildIngredientsMeasuresList(),
          const SizedBox(height: 10,),
          const Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Container(constraints: const BoxConstraints(maxWidth: 650),child: Text(widget.cocktail.instructions!, textAlign: TextAlign.center,),),
          const SizedBox(height: 10,),
          const Text("How to serve", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Text("Serve in ${widget.cocktail.glassType}"),
        ],
      ),
    ));
  }

  List<Widget> generateTags(Cocktail cocktail) {
    List<dynamic> colors = [Colors.red, Colors.lightGreen, Colors.amberAccent, Colors.lightBlueAccent, Colors.orangeAccent];
    final _random = Random();
    List<Widget> tags = [];
    if(cocktail.tags != null ){
      for(String tag in cocktail.tags!){
        if(tags.length < 5){
          tags.add(Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Adjust padding as needed
            decoration: BoxDecoration(
              color: colors[_random.nextInt(colors.length)], // Background color of the tag
              borderRadius: BorderRadius.circular(25), // Adjust for more or less rounded corners
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 10, // Adjust text size as needed
              ),
            ),
          ));
          tags.add(const SizedBox(width: 5,));
        }
      }
    }
    return tags;
  }

  Widget buildIngredientsMeasuresList() {
    String merged = "";
    for(int i=0; i<widget.cocktail.ingredients.length; i++) {
      merged += "• ${widget.cocktail.ingredients[i]} (${widget.cocktail.measures[i]})\n";
    }

    return Text(merged, textAlign: TextAlign.center,);
  }
}

