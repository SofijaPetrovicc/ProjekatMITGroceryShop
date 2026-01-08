import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile/profile_screen.dart';
import 'search_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late final List<Widget> screens;
  int currentScreen = 0; // 0 = Home
  late final PageController controller;

  @override
  void initState() {
    super.initState();

    screens = const [
      HomeScreen(),
     SearchScreen(),
     CartScreen(),
     ProfileScreen(),
    ];

    controller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          final auth=AuthService.instance;
          final needsLogin= (index==2 || index==3);
          if(needsLogin && !auth.isLoggedIn){
            Navigator.pushNamed(context,'/login');
            return;
          }
          setState(() => currentScreen = index);
          controller.jumpToPage(currentScreen);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_bag),
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Cart",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

