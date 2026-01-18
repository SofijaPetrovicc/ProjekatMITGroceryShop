import 'package:flutter/material.dart';
import 'catalog/products_screen.dart';
import 'search_screen.dart';
import '../data/mock_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = const [
      ("Meat", Icons.set_meal_outlined),
      ("Fruits", Icons.apple_outlined),
      ("Produce", Icons.eco_outlined),
      ("Dairy", Icons.icecream_outlined),
      ("Drinks", Icons.local_drink_outlined),
    ];

    //ovo mi treba za baner
    //uzimam sve proizovde i prolazim kroz njih jedan po jedan i uzimam samo one cija je kategorija produce
    //pravim novu listu tih proizvoda
    final producePicks= mockProducts
          .where((p)=>p.category.toLowerCase()== 'produce')
          .toList();
          //ako ima bar jedan produce uzmi ga, ako ne onda prvi proizvod
    final pick=producePicks.isNotEmpty ? producePicks.first:mockProducts.first;
   // final featured= mockProducts.take(4).toList();

    final featuredCategories=['meat','fruits','produce','diary'];
    final featured=featuredCategories.map((cat){
          return mockProducts.firstWhere(
            (p)=>p.category.toLowerCase()==cat,
            orElse: ()=> mockProducts.first,
          );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroceryShop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                   builder: (_) => const SearchScreen(),
             ),
               );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shop by Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                     builder: (_) => const ProductsScreen(
                      title: 'All products',
                     ),
                  ),
                );
              }, child: const Text('View All')),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final name = categories[i].$1;
                final icon = categories[i].$2;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsScreen(title: name),
                      ),
                    );
                  },
                  child: Container(
                    width: 92,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 28),
                        const SizedBox(height: 8),
                        Text(name, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Banner placeholder
          /*
          Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Cool Treats\n(placeholder banner)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.icecream, size: 44),
              ],
            ),
          ),
        */

        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute( 
                builder: (_)=> const ProductsScreen(title: 'Produce'),
              ),
              );
          },
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text(
                          'Fresh from Produce',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          pick.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height:2),
                        Text(
                          pick.description,
                          maxLines:1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                    ),
                  ),
                  const Icon(Icons.eco,size:44),
              ],
              ),
          ),
        ),
          const SizedBox(height: 16),

          const Text(
            'Featured',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
           // itemCount: 4,
           itemCount: featured.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.82,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, i) {
              final p=featured[i];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                       // child: ColoredBox(color: Colors.black12),
                          child: Image.asset(
                            p.imageAsset,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                      ),
                    ),
                    SizedBox(height: 8),
                   /* Text('Product name', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('1.99 €'),
                    */
                    Text(
                      p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text('${p.price.toStringAsFixed(2)}€'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
