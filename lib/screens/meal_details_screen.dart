import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

import '../model/meal.dart';

class MealDetailsScreen extends ConsumerWidget{
  const MealDetailsScreen({super.key, required this.meal,/*required this.onToggleFavorite*/ });
  final Meal meal;
  // final void Function(Meal meal) onToggleFavorite;

  void _showMessageInfo(String msg,BuildContext context){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    Widget content = Padding(
        padding: const EdgeInsets.all(6),
      child: SingleChildScrollView(
        child: Column(
          children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  meal.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
            ),
            const SizedBox(height: 20,),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            for(final ingredients in meal.ingredients)
              Text(
                ingredients,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            const SizedBox(height: 10,),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            for(final steps in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: (){
                final status = ref.watch(favoritesMealProvider.notifier).toggleFavorite(meal);
                if(status){
                  _showMessageInfo("Marked as Favorites!", context);
                }else{
                  _showMessageInfo("Removed from Favorites.", context);
                }
              },
              icon: const Icon(Icons.star)),
        ],
      ),
      body: content,
    );
  }
}