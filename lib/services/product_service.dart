import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = "product-sample-app-default-rtdb.firebaseio.com";

  final List<Product> products = [];
}
