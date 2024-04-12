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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // Creazione di un metodo of()
  // Riceve uno context di una classe stato
  // Ritorna lo stato "antenato" più vicino del tipo indicato
  // Questo metodo lo usiamo per accedere al metodo changeTheme() di _MyAppState da _MyHomePageState (due stati differenti)\
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CocktailDB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: const MyHomePage(title: 'CocktailDB Home Page'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: ElevatedButton(
              child: const Icon(Icons.settings),
              onPressed: () { print("pressed!"); },

            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Switch(
                  thumbIcon: lightIcon,
                  value: _nightMode,
                  onChanged: (bool value) {

                    setState(() {
                      _nightMode = value;
                      if(_nightMode) {
                        MyApp.of(context).changeTheme(ThemeMode.dark);
                      } else {
                        MyApp.of(context).changeTheme(ThemeMode.light);
                      }
                    });
                  })
          )

        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(hintText: "Cocktail Name"), controller: _ctrSearch,),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: () { searchCocktails(); }, child: const Text("Search"),),
            const SizedBox(height: 100,),
            Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: ListView.builder(
                itemCount: cocktails.length,
                itemBuilder: (BuildContext context, int index) => buildCard(context, index),
                shrinkWrap: true,
              ),
            ),
            const SizedBox(height: 100,),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: DropdownButton(
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
                    searchCocktails();
                  });
                },
              ),
            ),
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
    const domain = 'www.thecocktaildb.com';
    const path = '/api/json/v1/1/search.php';
    Map<String, dynamic> parameters = {'s': _ctrSearch.text};
    Uri uri = Uri.https(domain, path, parameters);
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
