import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  /*
  push() creates the MaterialPageRoute object "on the fly" (i.e. in the
   place where you call push()) whereas pushNamed() only works with
   pre-registered routes (in the routes table of your MaterialApp widget).
   */

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(    //pushNamed doesn't take MaterialPageRoute but takes the path
      CategoryMealScreen.routeName,
      //arguments can pass data from one page to another. Here, passing value as map
      arguments: {
        'id': id,
        'title': title,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.withOpacity(0.7),
            color,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
