import 'package:flutter/material.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/screens/food_detail_screen.dart';

import '../widgets/food_item.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key, required this.foods, this.title, required this.onToggleFavorite});

  final String? title;
  final List<Food> foods;
  final void Function(Food food) onToggleFavorite;

  void _selectFood(BuildContext context, Food food) {
    // Navigator.push(context, route)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodDetailScreen(
          food: food,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh... Nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Try Somthing Defferent Category',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (foods.isNotEmpty) {
      content = ListView.builder(
        itemCount: foods.length,
        itemBuilder: (ctx, index) => FoodItem(
          food: foods[index],
          onSelectFood: (food) {
            _selectFood(context, food);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        body: content,
      );
    }
  }
}
