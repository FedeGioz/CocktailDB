import 'dart:math';

import 'package:flutter/cupertino.dart';
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
          SizedBox(height: 50,),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.cocktail.thumbnail!),
            radius: 100,
          ),
          SizedBox(height: 20,),
          Row(children: generateTags(widget.cocktail), mainAxisAlignment: MainAxisAlignment.center,),
          SizedBox(height: 10,),
          Text("Nome", style: TextStyle(fontWeight: FontWeight.bold),),
          Text(widget.cocktail.name),
          SizedBox(height: 10,),
          Text("Ingredients", style: TextStyle(fontWeight: FontWeight.bold),),
          Text("• ${widget.cocktail.ingredients.join("\n• ")}", textAlign: TextAlign.center,),
          SizedBox(height: 10,),
          Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold),),
          Text(widget.cocktail.instructions!),
        ],
      ),
    ));
  }

  List<Widget> generateTags(Cocktail cocktail) {
    List<dynamic> colors = [Colors.red, Colors.lightGreen, Colors.amberAccent, Colors.lightBlueAccent, Colors.orangeAccent];
    final _random = new Random();
    List<Widget> tags = [];
    if(cocktail.tags != null){
      for(String tag in cocktail.tags!){
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
    return tags;
  }
}

