import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/dummy_data.dart';

/// Provider use for static data
final foodsProviders = Provider((ref) {
  return dummyFoods;
});
