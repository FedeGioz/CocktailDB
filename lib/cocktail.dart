class Cocktail {

  String _id = "";
  String _name = "";
  List<String>? _tags;
  String? _category;
  bool _isAlcoholic = false;
  String? _glassType;
  String? _instructions;
  List<String> _ingredients = [];
  List<String> _measures = [];
  String? _thumbnail;

  Cocktail(this._id, this._name, this._tags, this._category, this._isAlcoholic,
      this._glassType, this._instructions, this._ingredients, this._measures, this._thumbnail);

  Cocktail.fromJson(Map<String, dynamic> json, String language) {
    _id = json['idDrink'] ?? '';
    _name = json['strDrink'] ?? '';

    if (json['strTags'] != null) {
      // as String per castarla a stringa --> rimozione null value
      _tags = (json['strTags'] as String).split(",");
    }

    _category = json['strCategory'];
    if(json['strAlcoholic'] == "Alcoholic") _isAlcoholic = true;
    _glassType = json['strGlass'];
    _instructions = json['strInstructions$language'] ?? json['strInstructions'];

    for (int i = 0; i <= 15; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null) {
        _ingredients.add(ingredient);
        _measures.add(json['strMeasure$i'] ?? "q.b.");
      }
    }

    _thumbnail = json['strDrinkThumb'];
  }

  String? get thumbnail => _thumbnail;

  set thumbnail(String? value) {
    _thumbnail = value;
  }

  String? get instructions => _instructions;

  set instructions(String? value) {
    _instructions = value;
  }

  String? get glassType => _glassType;

  set glassType(String? value) {
    _glassType = value;
  }

  bool get isAlcoholic => _isAlcoholic;

  set isAlcoholic(bool value) {
    _isAlcoholic = value;
  }

  String? get category => _category;

  set category(String? value) {
    _category = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<String>? get tags => _tags;

  set tags(List<String>? value) {
    _tags = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  List<String> get ingredients => _ingredients;

  set ingredients(List<String> value) {
    _ingredients = value;
  }

  List<String> get measures => _measures;

  set measures(List<String> value) {
    _measures = value;
  }
}