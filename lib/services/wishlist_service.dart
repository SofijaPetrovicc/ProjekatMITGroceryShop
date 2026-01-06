import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class WishListService{
  static final WishListService instance= WishListService._();
  WishListService._();

  final Set<String>_items={};

  final ValueNotifier<Set<String>> itemsNotifier= 
    ValueNotifier<Set<String>>({});

  bool contains(String name)=> _items.contains(name);
  

  void notify(){
    itemsNotifier.value=Set<String>.from(_items);
  }

  void toggle(String name){
    if(_items.contains(name)){
      _items.remove(name);
    }else {
      _items.add(name);
    }
    notify();
  }

  void clear(){
    _items.clear();
    notify();
  }
}