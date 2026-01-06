import 'package:flutter/material.dart';
import '../../services/cart_service.dart';
import '../../services/wishlist_service.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final double price;

  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
         ValueListenableBuilder<Set<String>>(
        valueListenable: WishListService.instance.itemsNotifier,
        builder: (context, items, child) {
        final isFav = items.contains(name);
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          onPressed: () => WishListService.instance.toggle(name),
        );
      },
    ),
  ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Icon(Icons.image, size: 60)),
            ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('${price.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Description (placeholder).'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  CartService.instance.add(name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to cart')),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to cart'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
