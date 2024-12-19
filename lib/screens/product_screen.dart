import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_sample_app/providers/providers.dart';
import 'package:products_sample_app/ui/input_decorations.dart';
import 'package:products_sample_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/product_service.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
        create: (_) {
          return ProductFormProvider(productsService.selectedProduct);
        },
        child: _ProductScreenBody(productsService: productsService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productsService,
  });

  final ProductService productsService;

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productsService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!productFormProvider.isValidForm()) return;
          await productsService
              .saveOrCreateProduct(productFormProvider.product);
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm();

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        child: Form(
            key: productFormProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: productFormProvider.product.name,
                  onChanged: (value) {
                    productFormProvider.product.name == value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre es obligtorio";
                    }
                    return value;
                  },
                  decoration: InputDecorations.authInpuDecoration(
                      hintText: "Nombre del producto", labelText: "Nombre: "),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  inputFormatters: [
                    ///Alllows only numbers
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  initialValue: productFormProvider.product.price.toString(),
                  onChanged: (value) {
                    productFormProvider.product.price.toString() == value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El precio es obligtorio";
                    }
                    return value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInpuDecoration(
                      hintText: "150", labelText: "Precio: "),
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                  value: productFormProvider.product.available,
                  title: const Text("Disponible"),
                  activeColor: Colors.indigo,
                  onChanged: (value) {
                    productFormProvider.updateAvailability(value);
                  },
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 5))],
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ));
}
