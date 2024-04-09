import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // the InkWell widget is not just about making some child widget tappable
    // That could be achieved with the GestureDetector widget as well.
    // If you wrap a widget like this container with GestureDetector,
    // you can add a broad variety of listeners to it, for example, on tap
    // but also many other listeners to listen to all kinds of user
    // interactions with the child widget.
    // But if you use InkWell instead, you can also add on tap or
    // many other listeners, as you can see.But in addition, you get
    // a nice visual feedback. If a user taps the item. With GestureDetector
    // you would get no feedback.
    // With InkWell, you do, and that's why I'm using InkWell.
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(.55),
              category.color.withOpacity(.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
