import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: (){ //=> cart.clear(),
                if(cart.itemsNotifier.value.isEmpty)
                  return;

                  showDialog(
                    context: context,
                    builder: (ctx)=>AlertDialog(
                      title: const Text('Clear cart?'),
                      content: const Text('This will remove all items from your cart'),
                      actions: [
                           TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                       FilledButton(
                           onPressed: () {
                              cart.clear();
                              Navigator.pop(ctx);
                            },
                         child: const Text('Clear'),
                        ),    
                      ],
                    ),
                  );
            } 
          )
        ],
      ),
      body: ValueListenableBuilder<Map<String, int>>(
        valueListenable: cart.itemsNotifier,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }

          return ListView(
             padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            children: [
              ...items.entries.map((e) {
                final name = e.key;
                final qty = e.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.shopping_bag_outlined)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
                      IconButton(
                        onPressed: () => cart.removeOne(name),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$qty'),
                      IconButton(
                        onPressed: () => cart.add(name),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<Map<String,int>>(
          valueListenable: cart.itemsNotifier,
          builder: (context,items, _){
            if(items.isEmpty) return const SizedBox.shrink();
            
            //za sad kolicina, a kasnije ce se cene racunati
            final totalItems=items.values.fold<int>(0,(sum,q)=>sum+q);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration (
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(fontSize:12),
                              ),
                              Text(
                                '$totalItems items',
                                style: const TextStyle(
                                  fontSize:18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: (){
                            //ici ce ono guest->login
                            Navigator.push(context,
                            MaterialPageRoute(builder: (_)=>const CheckoutScreen())
                            );
                          },
                          child: const Text('Checkout'),
                        ),
                  ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
