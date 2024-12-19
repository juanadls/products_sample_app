import 'package:flutter/material.dart';
import 'package:products_sample_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  ProductFormProvider(this.product);

  Product product;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
