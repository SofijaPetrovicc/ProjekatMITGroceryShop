import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import '../../data/mock_products.dart';
import '../../model/product.dart';

class ProductsScreen extends StatelessWidget {
  final String title;
  const ProductsScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context){
  final List<Product>products = title == 'All Products'
      ? mockProducts
      : mockProducts.where((p)=>p.category==title).toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __)=> const SizedBox(height:12),
        itemBuilder: (context, i){
          final p=products[i];

          return ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: CircleAvatar(
              backgroundImage: AssetImage(p.imageAsset),
              ),
              title: Text(p.name),
              subtitle: Text('${p.price.toStringAsFixed(2)}€'),
              trailing: const Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> ProductDetailsScreen(product:p),
                    ),
                  );
              },
          );
        },
      ),
      );
  }
}