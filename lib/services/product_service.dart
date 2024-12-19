import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/product.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = "product-sample-app-default-rtdb.firebaseio.com";

  final List<Product> products = [];
  late Product selectedProduct;

  final storage = const FlutterSecureStorage();

  bool isLoading = true;
  bool isSaving = false;

  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    //1. Armas la url
    final url = Uri.https(_baseUrl, "products.json",
        {"auth": await storage.read(key: "token" ?? "")});

    //2. Esperas la respuesta de la url que armaste
    final resp = await http.get(url);

    //3. decodificar la respuesta: de string a map
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    //El key value representa un map de un producto
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromRawJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future<String> updateProduct(Product product) async {
    //1. Armas la url
    final url = Uri.https(_baseUrl, "products/${product.id}.json");

    //2. Esperas la respuesta de la url que armaste
    await http.put(url, body: product.toJson());

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct(Product product) async {
    //1. Armas la url
    final url = Uri.https(_baseUrl, "products/.json");

    //2. Esperas la respuesta de la url que armaste
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData["name"];

    products.add(product);

    return product.id!;
  }
}
