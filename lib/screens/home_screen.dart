import 'package:flutter/material.dart';
import 'package:products_sample_app/models/models.dart';
import 'package:products_sample_app/screens/screens.dart';
import 'package:products_sample_app/services/auth_service.dart';
import 'package:products_sample_app/services/product_service.dart';
import 'package:products_sample_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context);
    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        leading: IconButton(
            onPressed: () async {
              await authService.logOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: const Icon(
              Icons.logout_outlined,
            )),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ProductCard(product: productsService.products[index]),
              onTap: () {
                productsService.selectedProduct =
                    productsService.products[index].copyWith();
                Navigator.pushNamed(context, "product");
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.selectedProduct = Product(
            available: productsService.selectedProduct.available,
            name: productsService.selectedProduct.name,
            picture: productsService.selectedProduct.picture,
            price: productsService.selectedProduct.price,
            id: productsService.selectedProduct.id,
          );

          Navigator.pushNamed(context, "product");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
