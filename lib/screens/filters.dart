import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  @override
  Widget build(context,WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Filters')),
        body :Column(
          children: [
            SwitchListTile(
              value:activeFilters[Filter.glutenFree]!,
              onChanged: (onChanged) {
                ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, onChanged);

              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only include gluten free meals',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value:activeFilters[Filter.lactoseFree]!,
              onChanged: (onChanged) {
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, onChanged);

              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only include Lactose free meals',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value:activeFilters[Filter.vegan]!,
              onChanged: (onChanged) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, onChanged);

              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only include Vegan meals',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value:activeFilters[Filter.vegetarian]!,
              onChanged: (onChanged) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, onChanged);

              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only include vegetarian meals',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ));
  }
}
