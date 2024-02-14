import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Filter {
  isVeg,
  isNonVeg,
  isVegan,
  isGlutenFree
}

class FilterScreen extends StatefulWidget{
  const FilterScreen({super.key,required this.currentFilters});
  final Map<Filter,bool> currentFilters;


  @override
  State<FilterScreen> createState(){
    return _FilterScreenState();

  }
}

class _FilterScreenState extends State<FilterScreen>{
  var _isVegSelected = false;
  var _isNonVegSelected = false;
  var _isVeganSelected = false;
  var _isGlutenFreeSelected = false;

  @override
  void initState(){
    super.initState();
    _isVegSelected = widget.currentFilters[Filter.isVeg]!;
    _isNonVegSelected = widget.currentFilters[Filter.isNonVeg]!;
    _isVeganSelected = widget.currentFilters[Filter.isVegan]!;
    _isGlutenFreeSelected = widget.currentFilters[Filter.isGlutenFree]!;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: WillPopScope(
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Vegetarian'),
                value: _isVegSelected,
                onChanged: (isChecked){
                  setState(() {
                    _isVegSelected = isChecked;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Non-Vegetarian'),
                value: _isNonVegSelected,
                onChanged: (isChecked){
                  setState(() {
                    _isNonVegSelected = isChecked;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Vegan'),
                value: _isVeganSelected,
                onChanged: (isChecked){
                  setState(() {
                    _isVeganSelected = isChecked;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Gluten Free'),
                value: _isGlutenFreeSelected,
                onChanged: (isChecked){
                  setState(() {
                    _isGlutenFreeSelected = isChecked;
                  });
                },
              ),
            ],
          ),
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.isVeg:_isVegSelected,
              Filter.isNonVeg:_isNonVegSelected,
              Filter.isVegan:_isVeganSelected,
              Filter.isGlutenFree:_isGlutenFreeSelected
            });
            return false;
          },
      ),
    );
  }
}