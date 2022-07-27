import 'package:flutter/material.dart';
import 'package:vertical_card_pager_example/meal_details.dart';
import 'package:vertical_card_pager_example/entities/meal.dart';

class Diet{
  List<Meal> myDiet = [
    Meal(0, title: "Desayuno", date: "8am", color: Colors.red, cereal: 2, verdura: 1, carne: 2, grasas: 1),
    Meal(1, title: "Comida", date: "1pm", color: Colors.green, cereal: 3, leguminosa: 1, verdura: 1, carne: 4, grasas: 2),
    Meal(2, title: "Colación", date: "4pm", color: Colors.cyan, fruta: 1, semillas: 1),
    Meal(3, title: "Cena", date: "8pm", color: Colors.blue, cereal: 3, verdura: 1, carne: 4, grasas: 2),
    Meal(4, title: "Colación", date: "10pm", color: Colors.grey, fruta: 1, semillas: 1)
  ];

  List<String> getTitles(int selected){
    return myDiet.map((e) => {
      e.getTitle(selected)
    }).fold(<String>[], (previousValue, element) {
      var newList = List<String>.from(previousValue);
      newList.add(element.first);
      return newList;
    });
  }

  List<Widget> getContainer(int selected){
    return myDiet.fold(<Widget>[], (previousValue, element) {
      var portions = element.isSelected(selected) ? element.listWidget() : Center();
      var newList = List<Widget>.from(previousValue);
      newList.add(
          Container(
            decoration: BoxDecoration(color: element.color,borderRadius: BorderRadius.circular(30)),
            child: Align(alignment: Alignment.bottomCenter, child: portions),
          )
      );
      return newList;
    });
  }
}
