class Cocktail {
  String _titolo = "";
  List<dynamic> _autore = [];
  String _dataUscita = "";
  String _immagine = "";
  String _descrizione = "";
  String _link = "";
  double _rating = -1;

  Cocktail(this._titolo, this._autore, this._dataUscita, this._descrizione, this._link, this._rating);

  Cocktail.fromJson(Map<String, dynamic> json):
        _titolo = json['volumeInfo']?['title'] ?? "",
        _autore = json['volumeInfo']?['authors'] ?? [],
        _dataUscita = json['volumeInfo']?['publishedDate'] ?? "",
        _immagine = json['volumeInfo']?['imageLinks']?['smallThumbnail'] ?? "https://i.ibb.co/GnPgM2d/white.png",
        _descrizione = json['volumeInfo']?['description'] ?? "",
        _link = json['volumeInfo']?['infoLink'] ?? "",
        _rating = json['volumeInfo']?["averageRating"] ?? -1
  ;


  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  String get descrizione => _descrizione;

  set descrizione(String value) {
    _descrizione = value;
  }

  String get titolo => _titolo;

  set titolo(String value) {
    _titolo = value;
  }

  List<dynamic> get autore => _autore;

  String get immagine => _immagine;

  set immagine(String value) {
    _immagine = value;
  }

  String get dataUscita => _dataUscita;

  set dataUscita(String value) {
    _dataUscita = value;
  }

  set autore(List<dynamic> value) {
    _autore = value;
  }

  String get link => _link;

  set link(String value) {
    _link = value;
  }
}