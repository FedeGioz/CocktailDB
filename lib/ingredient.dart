class Ingredient {

  String _id = "";
  String _name = "";
  String? _description;
  String? _type;
  bool _isAlcoholic = false;
  double? _abv;

  Ingredient.fromJson(Map<String, dynamic> map){

    _id = map['idIngredient'];
    _name = map['strIngredient'];
    _description = map['strDescription'];
    _type = map['strType'];
    if(map['strAlcohol'] == "Yes") _isAlcoholic = true;
    _abv = double.parse(map['strABV']);
  }

  Ingredient(this._id, this._name, this._description, this._type,
      this._isAlcoholic, this._abv);


  double? get abv => _abv;

  set abv(double? value) {
    _abv = value;
  }

  bool get isAlcoholic => _isAlcoholic;

  set isAlcoholic(bool value) {
    _isAlcoholic = value;
  }

  String? get type => _type;

  set type(String? value) {
    _type = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}