import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../model/product.dart';
import 'catalog/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  State<SearchScreen> createState()=>_SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  String query='';

  @override
  Widget build(BuildContext context) {
    final List<Product>results=mockProducts.where((p){
      final q=query.trim().toLowerCase();
      if(q.isEmpty)
        return true;

        return p.name.toLowerCase().contains(q);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(12) ,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Search products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v)=> setState(()=>query=v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text ("No results"))
                  : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context,i){
                      final p=results[i];
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text("${p.price}"),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_)=>ProductDetailsScreen(product: p),
                            ),
                            );
                        },
                      );
                    },
                     ),
              )
          ],
        ),
        ),
    );
  }
}