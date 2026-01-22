import 'package:flutter/foundation.dart';

enum UserRole {guest, user, admin}

//AuthService pamti ko je trenutno korisnik i obavestava apl kad se to promeni
class AuthService{
  AuthService._();
  static final instance= AuthService._();
  String? _name;
  String? _email;
  //String? moze da prihvata null

  final ValueNotifier<UserRole> roleNotifier= ValueNotifier(UserRole.guest); //obj koji ima vrednost i kad se ta vrednost promeni, UI se osvezi
  //ValueNotifier slusa servis, npr ako se admin uloguje, onda na ekranu postoje druge opciije samo za admina
  UserRole get role => roleNotifier.value;
  bool get isLoggedIn => role != UserRole.guest; //ako nije guest znc da je ulogovan
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
    roleNotifier.value=UserRole.guest; //vracam ulogu na guest
    }

  String get displayName => _name ?? (isAdmin ? 'Admin' : 'Demo User');
  String get email => _email ?? (isAdmin ? 'admin@groceryshop.com' : 'user@groceryshop.com');
}