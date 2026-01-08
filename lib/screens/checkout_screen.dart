import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/orders_service.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  Widget build (BuildContext context){
    final cart= CartService.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<Map<String,int>>(
          valueListenable: cart.itemsNotifier,
          builder: (context,items,_){
            //final totalItems=items.values.fold<int>(0,(sum,q)=>sum+q);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                'Order summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: ListView(
                    children: items.entries
                    .map((e)=>ListTile(
                      title:Text(e.key),
                       trailing: Text('x${e.value}'),
                    ))
                    .toList(),
                  ),
                  ),

                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: items.isEmpty
                    ? null
                    : (){
                        OrderService.instance.addOrder(items);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order placed')),
                      );
                      cart.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Place order'),
                  ),
              ],
            );
          },
        ),
        ),
    );
  }
}