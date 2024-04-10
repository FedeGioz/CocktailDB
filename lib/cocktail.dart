class Cocktail {

  String _id = "";
  String _name = "";
  String? _category;
  bool _isAlcoholic = false;
  String? _glassType;
  String? _instruction;
  String? _description;
  String? _thumbnail;

  Cocktail(this._id, this._name, this._category, this._isAlcoholic,
      this._glassType, this._instruction, this._description, this._thumbnail);

  String? get thumbnail => _thumbnail;

  set thumbnail(String? value) {
    _thumbnail = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  String? get instruction => _instruction;

  set instruction(String? value) {
    _instruction = value;
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

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}