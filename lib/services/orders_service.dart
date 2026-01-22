import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class OrderModel {
  final String id;
  final DateTime createdAt;
  final Map<String, int> items; //svaka porudzbina ima svoj id i kolicinu, items = {'m1': 2, 'd3': 1}
  final String customerName;
  final String customerEmail;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.customerName,
    required this.customerEmail,
  });

  //items values su koolicine i fold krece od 0 i sabira ih (int sum, int q){return sum+q}
  int get totalItems => items.values.fold<int>(0, (sum, q) => sum + q);
}

class OrderService {
  OrderService._();
  static final instance = OrderService._();

  final ValueNotifier<List<OrderModel>> ordersNotifier = ValueNotifier([]);
  final auth = AuthService.instance;
  
  //stavke iz korpe
  void addOrder(Map<String, int> items) {
    if (items.isEmpty) return;

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      items: Map<String, int>.from(items),
      customerName: auth.displayName,
      customerEmail: auth.email,
    );

    //ordersNotifier.value trntn lista svih porudzbina
    //ovako kreiramo novu listu porudzbina koja sadrzi stare poruzbine i NOVU porudzbinu i ona ide na pocetak liste
    ordersNotifier.value = [order, ...ordersNotifier.value];
  }

  void clear() => ordersNotifier.value = [];
}
