import 'package:flutter/material.dart';
import 'package:products_sample_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  ProductFormProvider(this.product);

  Product product;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
