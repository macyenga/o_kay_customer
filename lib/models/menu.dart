import 'package:o_kay_customer/models/category.dart';
import 'package:o_kay_customer/models/food.dart';

class Menu {
  final Category category;
  final List<Food> foods;
  Menu({
    required this.category,
    required this.foods,
  });
}
