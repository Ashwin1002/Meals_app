import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.saveFilters, this.currentFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.topLeft,
            child: Text('Your Filters'),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                  },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile('Gluten-free',
                      'Only include gluten-free meals.', _glutenFree, (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  }),
                  _buildSwitchTile('Lactose-free',
                      'Only include lactose-free meals.', _lactoseFree, (value) {
                        setState(() {
                          _lactoseFree = value;
                        });
                      }),
                  _buildSwitchTile('Vegan',
                      'Only include vegan meals.', _vegan, (value) {
                        setState(() {
                          _vegan = value;
                        });
                      }),
                  _buildSwitchTile('Vegetarian',
                      'Only include Vegetarian meals.', _vegetarian, (value) {
                        setState(() {
                          _vegetarian = value;
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }
}
