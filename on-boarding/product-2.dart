import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  // Getters
  String get name => _name;
  String get description => _description;
  double get price => _price;

  // Setters
  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;

  @override
  String toString() {
    return 'Name: $_name | Description: $_description | Price: $_price';
  }
}

class ProductManager {
  List<Product> items = [];

  void create() {
    stdout.write('Enter the name: ');
    var name = stdin.readLineSync() ?? '';

    stdout.write('Enter the description: ');
    var desc = stdin.readLineSync() ?? '';

    stdout.write('Enter a price: ');
    var priceInput = stdin.readLineSync() ?? '';
    var price = double.tryParse(priceInput) ?? 0.0;

    var product = Product(name, desc, price);
    items.add(product);

    print('Product added successfully.');
  }

  void viewAll() {
    if (items.isEmpty) {
      print('No products available.');
    } else {
      for (var item in items) {
        print(item);
      }
    }
  }

  void view() {
    stdout.write('Enter the name of product to be viewed: ');
    var name = stdin.readLineSync();

    try {
      var selectedItem =
          items.firstWhere((item) => item.name == name);

      print(selectedItem);
    } catch (e) {
      print('Product not found.');
    }
  }

  void update() {
    stdout.write('Enter name of product to update: ');
    var name = stdin.readLineSync();

    try {
      var selectedItem =
          items.firstWhere((item) => item.name == name);

      stdout.write('Enter new description: ');
      var description = stdin.readLineSync() ?? '';
      selectedItem.description = description;

      stdout.write('Enter new price: ');
      var priceInput = stdin.readLineSync();
      var parsedPrice = double.tryParse(priceInput ?? '') ?? selectedItem.price;
      selectedItem.price = parsedPrice;

      print('${selectedItem.name} is updated successfully.');
    } catch (e) {
      print('Item with name $name does not exist.');
    }
  }

  void delete() {
    stdout.write('Enter name of product to delete: ');
    var name = stdin.readLineSync();

    try {
      var selectedItem =
          items.firstWhere((item) => item.name == name);

      items.remove(selectedItem);
      print('Successfully deleted $name.');
    } catch (e) {
      print('Product not found.');
    }
  }
}

void main() {
  var manager = ProductManager();
  bool exit = false;

  while (!exit) {
    print('''
1. Add Product
2. View All Products
3. View One Product
4. Update Product
5. Delete Product
6. Exit
''');

    stdout.write('Choose an option: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        manager.create();
        break;
      case '2':
        manager.viewAll();
        break;
      case '3':
        manager.view();
        break;
      case '4':
        manager.update();
        break;
      case '5':
        manager.delete();
        break;
      case '6':
        exit = true;
        break;
      default:
        print('Invalid option.');
    }
  }
}
