import 'package:flutter/material.dart';
import '../../services/orders_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  String _formatDate(DateTime dt) {
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final yyyy = dt.year.toString();
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$dd.$mm.$yyyy $hh:$min';
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              if (orders.ordersNotifier.value.isEmpty) return;

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Clear orders?'),
                  content: const Text('This will remove all demo orders.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        orders.clear();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: ValueListenableBuilder<List<OrderModel>>(
        valueListenable: orders.ordersNotifier,
        builder: (context, list, _) {
          if (list.isEmpty) {
            return const Center(child: Text('No orders yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final order = list[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.receipt_long),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Order #${order.id}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: const Text('Processing'),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_formatDate(order.createdAt)),
                    const SizedBox(height: 8),
                    Text('Items: ${order.totalItems}'),
                    const SizedBox(height: 10),

                  
                    ...order.items.entries.take(3).map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('• ${e.key}  x${e.value}'),
                        )),
                    if (order.items.length > 3)
                      Text('… +${order.items.length - 3} more'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
