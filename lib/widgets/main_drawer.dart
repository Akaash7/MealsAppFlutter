import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer
              ])),
              child: Row(
                children: [
                  Icon(Icons.fastfood,
                      size: 48, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 18),
                  Text("Cooking Up!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary))
                ],
              )),
          ListTile(
            leading: Icon(Icons.restaurant,
                size: 26, color: Theme.of(context).colorScheme.onBackground),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap:() => {
              onSelectScreen('meals')
            } ,
          ),
          ListTile(
            leading: Icon(Icons.settings,
                size: 26, color: Theme.of(context).colorScheme.onBackground),
            title: Text(
              'Filter',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap:() =>{
              onSelectScreen('filters')
            } ,
          )
        ],
      ),
    );
  }
}