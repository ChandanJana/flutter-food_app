import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/screens/food_screen.dart';
import 'package:food_app/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/food.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableFood});

  final List<Food> availableFood;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

/// For single animation use SingleTickerProviderStateMixin otherwise
/// use TickerProviderStateMixin
/// The with keyword indicates the use of a "mixin"
/// A mixin refers to the ability to add the capabilities of another class
/// or classes to your own class, without inheriting from those classes.
/// The methods of those classes can now be called on your class, and the
/// code within those classes will execute. Dart does not have multiple
/// inheritance, but the use of mixins allows you to fold in other classes
/// to achieve code reuse while avoiding the issues that multiple inheritance
/// would cause.
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late indicate that this variable does have initial value
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    /// Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filterFoods = widget.availableFood
        .where((food) => food.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodScreen(
          foods: filterFoods,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (ctx, child) =>
          /*Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),*/

          SlideTransition(
        position: Tween(
          begin: Offset(0, .3),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
