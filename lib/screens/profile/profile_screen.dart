import 'package:flutter/material.dart';
import 'wishlist_screen.dart';
import 'orders_screen.dart';
import '../../services/auth_service.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth= AuthService.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ValueListenableBuilder<UserRole>(
        valueListenable: auth.roleNotifier,
        builder: (context, role, _){
          //gost
          if(role==UserRole.guest){
            return Center(
              child: Padding(
              padding: const EdgeInsets.all(16) ,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_outline, size:72),
                  const SizedBox(height: 12),
                  const Text(
                    'You are not logged in',
                    style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text('Login to access wishlist,cart and orders'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: ()=> Navigator.pushNamed(context,'/login'),
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: ()=> Navigator.pushNamed(context,'/register'),
                   child: const Text('Create account'),
                   ),
                ],
              ),
              ),
            );
          }
      
      //user i admin
     return  ListView(
        padding: const EdgeInsets.all(16),
        children: [
              //user info
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(auth.displayName),
                subtitle: Text(auth.email),
              ), 
              const SizedBox(height: 12),

              //wishlist
              ListTile(
                leading : const Icon(Icons.favorite_border),
                title : const Text('WishList'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_)=> const WishListScreen()),
                  );
                },
              ),

              //Orders
              ListTile(
                leading: const Icon(Icons.receipt_long),
                title: const Text('Orders'),
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_)=>const OrdersScreen()),
                  );
                },
              ),

              //admin
              if(role == UserRole.admin)...[
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: const Text('Manage catalog'),
                  subtitle: const Text('Add/Edit/Delete products'),
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Admin catalog screen (tek cu praviti kad bude bekend)')),
                    );
                  },
                ),
              ],

              const Divider(height: 32),

              //logout
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: (){
                  auth.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out')),
                  );
                },
              ),
        ],
      );
      },
      ),
    );
  }
}