import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = "product-sample-app-default-rtdb.firebaseio.com";

  final List<Product> products = [];

  bool isLoading = true;

  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    //1. Armas la url
    final url = Uri.https(_baseUrl, "products.json");

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
}
