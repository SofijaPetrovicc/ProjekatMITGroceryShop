import 'package:flutter/foundation.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final Map<String, int> items;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.items,
  });

  int get totalItems => items.values.fold<int>(0, (sum, q) => sum + q);
}

class OrderService {
  OrderService._();
  static final instance = OrderService._();

  final ValueNotifier<List<OrderModel>> ordersNotifier = ValueNotifier([]);

  void addOrder(Map<String, int> items) {
    if (items.isEmpty) return;

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      items: Map<String, int>.from(items),
    );

    ordersNotifier.value = [order, ...ordersNotifier.value];
  }

  void clear() => ordersNotifier.value = [];
}
