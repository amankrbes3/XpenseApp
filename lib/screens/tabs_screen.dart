
import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';

const kInitialFilters = {
  Filter.isGlutenFree: false,
  Filter.isVeg: false,
  Filter.isLactoseFree: false,
  Filter.isVegan: false
};

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState(){
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  final List<Meal> favoriteMeals = [];
  int _selectedPageIndex = 0;
  var activePageTitle = '';
  Map<Filter,bool> _selectedFilters = kInitialFilters;


  void _selectPage(int index){
    setState(() {
        _selectedPageIndex = index;
    });
  }
  // void _showMessageInfo(String msg){
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }
  // this method is added in favoritesProvider
  // void _toggleFavoriteMeal(Meal meal){
  //     if(favoriteMeals.contains(meal)){
  //       setState(() {
  //         favoriteMeals.remove(meal);
  //         _showMessageInfo('Removed successfully from Favorites');
  //       });
  //     }else{
  //       setState(() {
  //         favoriteMeals.add(meal);
  //         _showMessageInfo('Added successfully to Favorites');
  //       });
  //
  //     }
  // }

  @override
  Widget build(BuildContext context){
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where(
        (meal) {
          if(!meal.isVegetarian && _selectedFilters[Filter.isVeg]!){
            return false;
          }
          if(!meal.isLactoseFree && _selectedFilters[Filter.isLactoseFree]!){
            return false;
          }
          if(!meal.isGlutenFree && _selectedFilters[Filter.isGlutenFree]!){
            return false;
          }
          if(!meal.isVegan && _selectedFilters[Filter.isVegan]!){
            return false;
          }
          return true;
        }
    ).toList();

    final favoriteMeals = ref.watch(favoritesMealProvider);
    Widget selectedTab = CategoriesScreen(availableMeal: availableMeals);
    var activePageTitle = 'Your Favorites';
    if(_selectedPageIndex == 1){
      selectedTab = MealsScreen(meals: favoriteMeals);
    } else{
      activePageTitle = 'Pick Your Categories';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: selectedTab,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedPageIndex = 0;
                });

              },
            ),
            ListTile(
              leading: Icon(
                Icons.filter_alt_sharp,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Apply Filters',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final result = await Navigator.of(context).push<Map<Filter,bool>>(
                    MaterialPageRoute(
                        builder: (ctx) => FilterScreen(currentFilters: _selectedFilters,),),
                );
                setState(() {
                  _selectedFilters = result ?? kInitialFilters;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Favorites',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedPageIndex = 1;
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal_outlined),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites'),
        ],
      )
    );
  }
}