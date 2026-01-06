import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String title;
  const ProductsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          return ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: const CircleAvatar(child: Icon(Icons.shopping_bag_outlined)),
            title: Text('Product ${i + 1}'),
            subtitle: const Text('1.99 €'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                          name: 'Product ${i + 1}',
                          price: 1.99 + i,
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
