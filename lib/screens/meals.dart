import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/recipe.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,this.title, required this.meals,required this.toggleFavMeal});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleFavMeal;

  void _navigateToRecipe(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => Recipe(meal: meal,toggleFavMeal: toggleFavMeal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing here",
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme
                  .of(context)
                  .colorScheme
                  .onBackground),
            )
          ],
        ));

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(meal: meals[index], navigateToRecipe: (meal) { _navigateToRecipe(context, meal); },));
    }
    if(title == null){
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: content,
      );
    }

  }
}
