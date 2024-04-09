import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/food_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> filter) {
    state = filter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

// Provider uses another provider
final filteredFoodProvider = Provider((ref) {
  final foods = ref.watch(foodsProviders);
  final activeFilters = ref.watch(filterProvider);

  /// where used for filtering food
  return foods.where((food) {
    if (activeFilters[Filter.glutenFree]! && !food.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !food.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !food.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !food.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
