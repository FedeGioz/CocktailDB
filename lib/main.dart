import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:http/http.dart' as http;
import 'cocktail.dart';

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
      ),
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

  TextEditingController _ctrSearch = TextEditingController();
  List<Cocktail> cocktails = [];

  LanguagePickerDropdownController _ctrLanguage = LanguagePickerDropdownController(Languages.english);

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
            LanguagePickerDropdown(languages: [Languages.english, Languages.italian, Languages.spanish, Languages.german, Languages.french], controller: _ctrLanguage,)
          ],
        ),
      ),
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

      List<Cocktail> cocktails = cocktailsDataItem.map<Cocktail>((json) => Cocktail.fromJson(json, _ctrLanguage.value.isoCode)).toList();
      setState(() {
        this.cocktails = cocktails;
      });
    });
  }
}
