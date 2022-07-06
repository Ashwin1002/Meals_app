import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meals.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  /*final String categoryId;
  final String categoryTitle;

  CategoryMealScreen({required this.categoryId, required this.categoryTitle});*/
  String? categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      //loading arguments from category_item.dart
      final routeArgs =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryID = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categoryID.contains(categoryID);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState((){
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!),
      ),
      body: ListView.builder(
          itemCount: displayedMeals.length,
          itemBuilder: (context, index) {
            return MealItem(
                id: displayedMeals[index].id,
                title: displayedMeals[index].title,
                imageUrl: displayedMeals[index].imageUrl,
                duration: displayedMeals[index].duration,
                complexity: displayedMeals[index].complexity,
                affordability: displayedMeals[index].affordability,
            );
          },
      ),
    );
  }
}
