import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';

import '../models/meal.dart';

class Recipe extends ConsumerWidget {
  const Recipe({super.key, required this.meal, required this.toggleFavMeal});

  final Meal meal;
  final void Function(Meal meal) toggleFavMeal;

  @override
  Widget build(context, WidgetRef ref) {
    Widget mealImage = Image.network(meal.imageUrl,
        height: 300, width: double.infinity, fit: BoxFit.cover);
    Widget card1 = Column(children: [
      Text("Ingredients",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      Card(
          margin: const EdgeInsets.all(16),
          color: const Color.fromARGB(255, 245, 231, 231),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ...meal.ingredients.map((ingredient) => Text(ingredient))
              ],
            ),
          ))
    ]);

    Widget card2 = Column(children: [
      Text("Ingredients",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      Card(
          margin: EdgeInsets.all(16),
          color: Color.fromARGB(255, 245, 231, 231),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...meal.steps.map((step) => Text(step))],
            ),
          ))
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  final wasAdded = ref
                      .read(favouritesMealsProviders.notifier)
                      .toggleMealFavouriteStatus(meal);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          wasAdded
                          ? 'Meal has been added to Favourites'
                          : 'Meal has been removed from the favourites')));
                },
                icon: const Icon(Icons.star))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [mealImage, card1, card2],
          ),
        ));
  }
}
