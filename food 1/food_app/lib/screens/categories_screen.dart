import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/screens/food_screen.dart';
import 'package:food_app/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/food.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableFood});

  final void Function(Food food) onToggleFavorite;
  final List<Food> availableFood;

  void _selectCategory(BuildContext context, Category category) {
    final filterFoods = availableFood
        .where((food) => food.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodScreen(
          foods: filterFoods,
          title: category.title,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Column count
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20, // Spacing between columns
            mainAxisSpacing: 20 // Spacing between rows

            ),
        children: [
          /// ...availableCategories.map((category) => CategoryGridItem(category)).toList(),
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      );
  }
}
