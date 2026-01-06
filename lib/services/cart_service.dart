import 'package:flutter/material.dart';


class CartService {
  static final CartService instance= CartService._(); //omogucavam da postoji jedna jeidna korpa
  CartService._();
  //_items _znaci da je priv promenlj
  final Map <String, int> _items={};  //ime proizovda->kolicina

  final ValueNotifier<Map<String,int>> itemsNotifier= 
    ValueNotifier<Map<String,int>>({});
  
  Map<String,int>get items => _items;  //geter-drugi delovi apl mogu da procitaju items

  void _notify(){
    itemsNotifier.value=Map<String,int>.from(_items);
  }
  //metoda za dodavanje u korpu
  void add(String name){
    _items[name]=(_items[name]??0)+1; //ako nema proizovda-kolicina je 0, ako ima onda postojecu kolicinu i onda plus 1
    _notify();
  }

  void removeOne(String name){
    final current=_items[name]??0;
    if(current <= 1){
      _items.remove(name);  //ako je jedini proizvod u korpi, onda ga ceo obrisemo
    } else{ //ako ima vise proizovda
      _items[name]=current-1;
    }
    _notify();
  }
  void clear(){
    _items.clear();
    _notify();
  }
}