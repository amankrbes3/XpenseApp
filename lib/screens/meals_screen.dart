import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

import '../model/meal.dart';
import '../widgets/meal_item.dart';


class MealsScreen extends StatelessWidget{
   MealsScreen({super.key,this.title,required this.meals,/*required this.onToggleFavorite*/});

  String? title;
  final List<Meal> meals;
  // final void Function(Meal meal) onToggleFavorite;
  void _showMealDetails(BuildContext context,Meal meal){

    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onClick: (){
            _showMealDetails(context,meals[index]);
          },
        ),
      );
    }

    if(title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }


}