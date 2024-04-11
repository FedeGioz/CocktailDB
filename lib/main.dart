import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:http/http.dart' as http;
import 'cocktail.dart';
import 'cocktail_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool _nightMode = false;

  TextEditingController _ctrSearch = TextEditingController();
  List<Cocktail> cocktails = [];

  String selectedLanguage = "EN";
  List<String> languages = ["EN", "IT", "ES", "DE", "FR"];

  final MaterialStateProperty<Icon?> lightIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.nightlight);
      }
      return const Icon(Icons.sunny);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Cocktail Name"), controller: _ctrSearch,),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () { searchCocktails(); }, child: Text("Search"),),
            SizedBox(height: 100,),
            Container(child:
              ListView.builder(
                itemCount: cocktails.length,
                itemBuilder: (BuildContext context, int index) => buildCard(context, index),
                shrinkWrap: true,
              ),
              constraints: BoxConstraints(maxWidth: 1000),
            ),
            SizedBox(height: 100,),
            Container(child:
            DropdownButton(
              value: selectedLanguage,
              items: languages.map((String language) {
                return DropdownMenuItem(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
            ),
              constraints: BoxConstraints(maxWidth: 300),
            ),
            Switch(
                thumbIcon: lightIcon,
                value: _nightMode,
                onChanged: (bool value) {

                  setState(() {
                    _nightMode = value;
                  });
                })

              ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int index){
    return Container(
      child: GestureDetector(child:
        Card(
          child: Column(
            children: [
              Text(cocktails[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(cocktails[index].category!),
            ],
          ),
        ),
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TheCocktail(cocktail: cocktails[index])))
        },
      )
    );
  }

  Future searchCocktails() async {
    const dominio = 'www.thecocktaildb.com';
    const path = '/api/json/v1/1/search.php';
    Map<String, dynamic> parametri = {'s': _ctrSearch.text};
    Uri uri = Uri.https(dominio, path, parametri);
    http.get(uri).then((result) {

      final cocktailsData = json.decode(result.body);
      final cocktailsDataItem = cocktailsData['drinks'];

      List<Cocktail> cocktails = cocktailsDataItem.map<Cocktail>((json) =>
          Cocktail.fromJson(json, selectedLanguage)).toList();
      setState(() {
        this.cocktails = cocktails;
      });
    });
  }
}

/*
TAGS:
Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // Adjust padding as needed
          decoration: BoxDecoration(
            color: Colors.orange, // Background color of the tag
            borderRadius: BorderRadius.circular(25), // Adjust for more or less rounded corners
          ),
          child: Text(
            '${this.cocktails[index].tags![0]}',
            style: TextStyle(
              color: Colors.white, // Text color
              fontSize: 10, // Adjust text size as needed
            ),
          ),
        )
 */
