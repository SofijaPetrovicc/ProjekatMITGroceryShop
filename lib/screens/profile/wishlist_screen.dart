import 'package:flutter/material.dart';
import '../../services/wishlist_service.dart';

class WishListScreen extends StatelessWidget{
  const WishListScreen({super.key});

  Widget build(BuildContext context){
    final wish= WishListService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text ('WishList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: ()=> wish.clear(),
          )
        ],
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: wish.itemsNotifier,
        builder: (context, items, child){
          if(items.isEmpty){
            return const Center (child: Text('Wishlist is empty'));
          }
          final list=items.toList();

          return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i){
                final name= list[i];
                return ListTile(
                    tileColor: Theme.of(context).colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    leading: const CircleAvatar(child: Icon(Icons.favorite)),
                    title: Text(name),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                    onPressed: ()=>wish.toggle(name),
                    ),
                );
              },
          );
        },
      ),
    );
  }
}