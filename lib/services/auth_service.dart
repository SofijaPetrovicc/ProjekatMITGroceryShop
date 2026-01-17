import 'package:flutter/foundation.dart';

enum UserRole {guest, user, admin}

class AuthService{
  AuthService._();
  static final instance= AuthService._();
  String? _name;
  String? _email;

  final ValueNotifier<UserRole> roleNotifier= ValueNotifier(UserRole.guest);

  UserRole get role => roleNotifier.value;
  bool get isLoggedIn => role != UserRole.guest;
  bool get isAdmin => role == UserRole.admin;

  void loginAsUser({String? name, String? email}){
    _name=name;
    _email=email;
    roleNotifier.value=UserRole.user;
  }
  void loginAsAdmin(){
    _name = 'Admin';
    _email = 'admin@groceryshop.com';
    roleNotifier.value = UserRole.admin;
  }
  void logout(){
    _name = null;
    _email = null;
    roleNotifier.value=UserRole.guest;}

  String get displayName => isAdmin ? 'Admin' : 'Demo User';
  String get email => isAdmin ? 'admin@groceryShop.com' : 'user@groceryshop.com';
}