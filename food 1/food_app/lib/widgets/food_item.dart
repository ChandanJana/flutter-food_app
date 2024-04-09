import 'package:flutter/material.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/widgets/food_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.food, required this.onSelectFood});

  final Food food;
  final void Function(Food food) onSelectFood;

  String get complexityText {
    return food.complexity.name[0].toUpperCase() +
        food.complexity.name.substring(1);
  }

  String get affordabilityText {
    return food.affordability.name[0].toUpperCase() +
        food.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // After set shape till rounded is not showing on image.
      // To enforce this shape here, I have to add a setting that
      // ensures that any content that would go out of the shape
      // is simply cut off. And this can be done by setting the
      // clipBehavior on the Card to Clip hardEdge. And this simply
      // clips this widget, removing any content of child widgets
      // that would go outside of the shape boundaries
      // of this Card widget.

      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectFood(food);
        },
        // A "stack" refers to the Stack widget, which is used to
        // overlay widgets on top of each other. The Stack widget is
        // often used when you want to position multiple widgets at
        // specific locations on the screen
        // You can adjust the top, left, right, or bottom properties
        // of the Positioned widgets to position your child widgets
        // as needed.

        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(food.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      food.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FoodItemTrait(
                          title: '${food.duration} min',
                          icon: Icons.schedule,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        FoodItemTrait(
                          title: complexityText,
                          icon: Icons.work,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        FoodItemTrait(
                          title: affordabilityText,
                          icon: Icons.attach_money,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
