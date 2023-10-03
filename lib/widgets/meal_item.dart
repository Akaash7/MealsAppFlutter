import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';
import '../screens/recipe.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.navigateToRecipe});

  final Meal meal;
  final Function(Meal meal) navigateToRecipe;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get addordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => {navigateToRecipe(meal)},
          child: Stack(
            children: [
              FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                  image: NetworkImage(meal.imageUrl)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration.toString()} + min'),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              icon: Icons.work, label: complexityText),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: addordabilityText)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
