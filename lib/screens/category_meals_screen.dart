import 'package:flutter/material.dart';
import '../dummy_categories.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  /*final String categoryId;
  final String categoryTitle;

  CategoryMealScreen({required this.categoryId, required this.categoryTitle});*/


  @override
  Widget build(BuildContext context) {
    //loading arguments from category_item.dart
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryID = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final categoryMeals = dummyMeals.where((meal) {
      return meal.categoryID.contains(categoryID);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!),
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (context, index) {
            return MealItem(
                id: categoryMeals[index].id,
                title: categoryMeals[index].title,
                imageUrl: categoryMeals[index].imageUrl,
                duration: categoryMeals[index].duration,
                complexity: categoryMeals[index].complexity,
                affordability: categoryMeals[index].affordability,
            );
          },

      ),
    );
  }
}
