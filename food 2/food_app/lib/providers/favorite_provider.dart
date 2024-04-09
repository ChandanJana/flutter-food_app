import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/food.dart';

/// StateNotifierProvider is a class provided by the Riverpod library in Flutter
/// that allows you to create and manage a state notifier and expose it to
/// your application. State notifiers are a way to manage mutable state in a
/// more organized and predictable manner.
///

/// We should not use add or removed instead we create new list always
///
class FavoriteFoodNotifier extends StateNotifier<List<Food>> {
  FavoriteFoodNotifier() : super([]);

  bool toggleFoodFavoriteStatus(Food food) {
    final favoriteFood = state.contains(food);

    if (favoriteFood) {
      state = state.where((f) => f.id != food.id).toList();
      return false;
    } else {
      /// I simply wanna keep all the existing items
      /// but then also add a new one.
      /// And to do this we can use the spread operator,
      /// so in this case on state, which is a list of meals,
      /// to pull out all the elements that are stored in that list
      /// and add them as individual elements to this new list
      /// and then separated by a comma
      /// we can add yet another new food
      state = [...state, food];
      return true;
    }
  }
}

final favoriteFood =
    StateNotifierProvider<FavoriteFoodNotifier, List<Food>>((ref) {
  return FavoriteFoodNotifier();
});
