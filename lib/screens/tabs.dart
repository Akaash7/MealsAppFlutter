import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';
import '../providers/filters_provider.dart';

const Map<Filter, bool> kIntialFilters = {
  Filter.vegan: false,
  Filter.vegetarian: false,
  Filter.lactoseFree: false,
  Filter.glutenFree: false
};

class TabsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favouriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.white, content: Text(message)));
  }

  void _toggleFavMeal(Meal meal) {
    var containsMeal = favouriteMeals.contains(meal);
    if (containsMeal) {
      setState(() {
        favouriteMeals.remove(meal);
      });
      _showInfoMessage("Meal has been removed from favourites");
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
      _showInfoMessage("Meal has been added to favourites");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dumMeals = ref.watch(mealsProvider);
    final _selectedFilters = ref.watch(filtersProvider);
    final availableMeals = dumMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      toggleFavMeal: _toggleFavMeal,
    );
    var activePageTitle = "Categories Screen";
    if (_selectedPageIndex == 1) {
      final newFavouriteMeals = ref.watch(favouritesMealsProviders);
      activePage = MealsScreen(
        meals: newFavouriteMeals,
        toggleFavMeal: _toggleFavMeal,
      );
      activePageTitle = 'Favourite Meals';
    }
    return Scaffold(
        appBar: AppBar(title: Text(activePageTitle)),
        drawer: MainDrawer(
          onSelectScreen: _setScreen,
        ),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.set_meal), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: 'Favourites')
            ]));
  }
}
