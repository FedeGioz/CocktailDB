import 'package:cocktail/ingredient_detail.dart';
import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'package:translator/translator.dart';


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
      home: TheCocktail(cocktail: Cocktail("12", "name", null, "category", true, "glass", "instruction", ["Gin", "Limone"], [], "https://upload.wikimedia.org/wikipedia/commons/f/fd/Classic_Daiquiri_in_Cocktail_Glass.jpg"), language: 'en',),
    );
  }
}

class TheCocktail extends StatefulWidget{
  const TheCocktail({super.key, required this.cocktail, required this.language});

  final Cocktail cocktail;
  final String language;

  @override
  State<TheCocktail> createState() => _TheCocktail();

}

class _TheCocktail extends State<TheCocktail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Cocktail Detail"),
        ),
        body: SingleChildScrollView(child: Center(child: Column(
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
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: generateTags(widget.cocktail),),
            const SizedBox(height: 10,),
            const Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text("${widget.cocktail.name} (${widget.cocktail.category})"),
            const SizedBox(height: 20,),
            const Text(
              "Ingredients", style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Container(constraints: BoxConstraints(
              maxWidth: getWidthFromScreenSize(context)
            ),child: ListView.builder(
              itemCount: widget.cocktail.ingredients.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildIngredientsMeasuresList(context, index),
              shrinkWrap: true,
            ),
            ),
            const SizedBox(height: 10,),
            const Text(
              "Instructions", style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Container(constraints: const BoxConstraints(maxWidth: 650),
              child: Text(
                widget.cocktail.instructions!, textAlign: TextAlign.center,),),
            const SizedBox(height: 10,),
            checkTranslation(widget.cocktail.instructions!, widget.language),
            const Text(
              "How to serve", style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text("Serve in ${widget.cocktail.glassType}")
            ),
          ],
        ),
        )));
  }

  Widget buildIngredientsMeasuresList(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30,),
                Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("${widget.cocktail.ingredients[index]} (${widget.cocktail.measures[index]})",),),
                const SizedBox(width: 20,),
              ],
            ),
          ],
        ), // x rimuovere border
      ),
      onTap: () =>
      {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
          return TheIngredientModalBottom(ingredientName: widget.cocktail.ingredients[index], language: widget.language,);
          },
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          isScrollControlled: true,
      ),
      },
    );
  }

  checkTranslation(String s, String language) {
    if(widget.cocktail.isTranslated == false){
      GoogleTranslator translator = GoogleTranslator();
      translator.translate(s, to: language.toLowerCase()).then((value) {
        setState(() {
          widget.cocktail.instructions = value.text;
          widget.cocktail.isTranslated = true;
        });
      });
    }
    return Container();
  }
}

List<Widget> generateTags(Cocktail cocktail) {
  List<dynamic> colors = [Colors.red, Colors.lightGreen, Colors.amberAccent, Colors.lightBlueAccent, Colors.orangeAccent];
  List<Widget> tags = [];
  if(cocktail.tags != null ){
    for(String tag in cocktail.tags!){
      if(tag == "IBA"){
        tags.add(
          Padding(
              padding: const EdgeInsets.only(right: 5) ,
              child: Image.network("https://i.ibb.co/5BbKs1K/logo-iba.png", width: 45, height: 45,),
          )
        );
      }
      else if(tags.length < 5){
        tags.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: colors[tag.length%colors.length],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ));
        tags.add(const SizedBox(width: 5,));
      }
    }
  }
  return tags;
}

