import 'package:flutter/material.dart';
import 'package:meals_app/model/category.dart';

class CategoryItem extends StatelessWidget{
  const CategoryItem({super.key,required this.category,required this.onSelectCategory});
  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onSelectCategory,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.7),
              category.color.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: Text(
          category.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}