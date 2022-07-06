import 'package:flutter/material.dart';
import 'package:meals_app/dummy_categories.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import 'models/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState((){
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (!meal.isGlutenFree && _filters['gluten']! ) {
          return false;
        }
        if (!meal.isLactoseFree && _filters['lactose']! ) {
          return false;
        }
        if (!meal.isVegan && _filters['vegan']! ) {
          return false;
        }
        if (!meal.isVegetarian && _filters['vegetarian']! ) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealID){
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealID);

    if(existingIndex >= 0) {
      setState((){
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState((){
        _favouriteMeals.add(dummyMeals.firstWhere((meal) => meal.id  == mealID));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              subtitle1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      // home: CategoriesScreen(),
      initialRoute: '/',
      //default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilters, _filters),
      },

      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
}
