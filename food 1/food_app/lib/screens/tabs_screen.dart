import 'package:flutter/material.dart';
import 'package:food_app/data/dummy_data.dart';
import 'package:food_app/screens/categories_screen.dart';
import 'package:food_app/screens/food_screen.dart';

import '../models/food.dart';
import '../widgets/main_drawer.dart';
import 'filters_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsState();
  }
}

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final List<Food> _favoriteFood = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      // Close the drawer
      Navigator.pop(context);

      /// pushReplacement will replace the previous/active screen in stack and
      /// push will add the screen on top of previous/active screen
      /// in stack and back button will come automatically
      /// when user back it will return Map<Filter, bool> value and store to result
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            filters: _selectedFilter,
          ),
        ),
      );
      setState(() {
        /// The ?? operator is used to return the value on its left-hand side
        /// if it's not null; otherwise, it returns the value on its right-hand side.
        /// it is called null-aware or null-coalescing operator.
        _selectedFilter = result ?? kInitialFilters;
      });
    } else {
      // By default Category page showing that why If we are choose the food then close the drawer
      Navigator.pop(context);
    }
  }

  void _toggleFoodFavorite(Food food) {
    final isExisting = _favoriteFood.contains(food);

    if (isExisting) {
      setState(() {
        _favoriteFood.remove(food);
      });
      _showInfoMessage('Food is no longer favorite');
    } else {
      setState(() {
        _favoriteFood.add(food);
      });
      _showInfoMessage('Marked as favorite');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableFood = dummyFoods.where((food) {
      if (_selectedFilter[Filter.glutenFree]! && !food.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !food.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !food.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !food.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFoodFavorite,
      availableFood: availableFood,
    );
    String activeText = 'Categories';

    if (_selectedIndex == 1) {
      activePage = FoodScreen(
        foods: _favoriteFood,
        onToggleFavorite: _toggleFoodFavorite,
      );
      activeText = 'Your Favorite';
    }
    /*else{
      activePage = const CategoriesScreen();
      activeText = 'Categories';
    }*/
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
