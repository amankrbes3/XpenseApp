

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>>{
  FavoritesMealNotifier() : super([]);

  bool toggleFavorite(Meal meal){
    if(state.contains(meal)){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else{
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealProvider = StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref){
  return FavoritesMealNotifier();
});