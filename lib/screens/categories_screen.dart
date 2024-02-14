import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_item.dart';

import '../model/meal.dart';
class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key, required this.onToggleFavorite,required this.availableMeal});
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeal ;

  void _selectCategory(BuildContext context,Category category){

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
              title: category.title,
              meals: dummyMeals,
            onToggleFavorite: onToggleFavorite,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    // availableCategories.shuffle();
    return Scaffold(
        body:  Container(
          child: GridView(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              ),
            children: [
              for(final category in availableCategories)
                CategoryItem(
                  category: category,
                  onSelectCategory: (){
                    _selectCategory(context,category);
                  },
                )
            ],
          ),
        ),
    );
  }
}