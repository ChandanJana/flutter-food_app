import 'package:flutter/material.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/filters_screen.dart';
import 'package:food_app/screens/food_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/favorite_provider.dart';
import '../providers/filters_provider.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsState();
  }
}

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      // Close the drawer
      Navigator.pop(context);

      /// pushReplacement will replace the previous/active screen in stack and
      /// push will add the screen on top of previous/active screen
      /// in stack and back button will come automatically
      /// when user back it will return Map<Filter, bool> value and store to result
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    } else {
      // By default Category page showing that why If we are choose the food then close the drawer
      Navigator.pop(context);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// In the context of Riverpod, "watch" typically refers to observing
    /// changes in a provider's state and reacting to those changes.

    final availableFood = ref.watch(filteredFoodProvider);

    Widget activePage = CategoriesScreen(
      availableFood: availableFood,
    );
    String activeText = 'Categories';

    if (_selectedIndex == 1) {
      final favoriteFoods = ref.watch(favoriteFood);
      activePage = FoodScreen(foods: favoriteFoods);
      activeText = 'Your Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeText),
      ),
      drawer: MainDrawer(
        onSelect: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Food'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
