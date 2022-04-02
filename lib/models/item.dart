class Item {
  late int _id;
  late String _name;
  late int _price;

  int get id => _id;

  get name => _name;
  set name(value) => _name = value;

  get price => _price;
  set price(value) => _price = value;

  Item(this._name, this._price);

  //constructor mengambil data dari sql yg tersimpan dalam bntk map
  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = map['price'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = name;
    map['price'] = price;
    return map;
  }
}
