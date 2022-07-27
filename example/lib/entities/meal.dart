import 'package:flutter/material.dart';

class Meal {
  final String title;
  final String date;
  final int index;
  final Color color;
  final int cereal;
  final int leguminosa;
  final int leche;
  final int fruta;
  final int verdura;
  final int carne;
  final int grasas;
  final int semillas;

  Meal(this.index, {this.title, this.date, this.color, this.cereal: 0, this.leguminosa: 0, this.leche: 0, this.fruta: 0, this.verdura: 0, this.carne: 0, this.grasas: 0, this.semillas: 0});

  bool isSelected(int selected){
    return this.index == selected;
  }

  String getTitle(int selected){
    return isSelected(selected) ? "$title - $date" : "$title - $date";
  }

  Color getColor(int selected){
    return isSelected(selected) ? Colors.deepPurple : color;
  }

  List<String> getPortions(){
    var newList = <String>[];
    if (cereal > 0) {
      newList.add("cereal ${cereal}");
    }
    if (leguminosa > 0) {
      newList.add("leguminosa ${leguminosa}");
    }
    if (leche > 0) {
      newList.add("leche ${leche}");
    }
    if (fruta > 0) {
      newList.add("fruta ${fruta}");
    }
    if (verdura > 0) {
      newList.add("verdura ${verdura}");
    }
    if (carne > 0) {
      newList.add("carne ${carne}");
    }
    if (grasas > 0) {
      newList.add("grasas ${grasas}");
    }
    if (semillas > 0) {
      newList.add("semillas ${semillas}");
    }
    return newList;
  }

  List<String> getAliments(){
    var newList = <String>[];
    if (cereal > 0) {
      newList.add("cereal");
    }
    if (leguminosa > 0) {
      newList.add("leguminosa");
    }
    if (leche > 0) {
      newList.add("leche");
    }
    if (fruta > 0) {
      newList.add("fruta");
    }
    if (verdura > 0) {
      newList.add("verdura");
    }
    if (carne > 0) {
      newList.add("carne");
    }
    if (grasas > 0) {
      newList.add("grasas");
    }
    if (semillas > 0) {
      newList.add("semillas");
    }
    return newList;
  }

}

extension MealWidget on Meal {
  Widget listWidget(){
    var portions = getPortions().fold(List<Widget>.empty(), (pv, item) {
      var newList = List<Widget>.from(pv);
      newList.add(
          Row(children: [
            Expanded(child:
            Text(item.split(' ')[0],
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white, fontSize: 20)
            )
            ),
            Expanded(child:
            Text(item.split(' ')[1],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20)
            )
            )
          ]
          )
      );
      return newList;
    });

    return Container(
      decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(30)),
      child:
      Align(alignment: Alignment.bottomCenter, child:
      Column(mainAxisAlignment: MainAxisAlignment.end,children: portions)
      ),
    );
  }

  Widget listMeals(){
    var portions = getPortions().fold(List<Widget>.empty(), (pv, item) {
      var newList = List<Widget>.from(pv);
      newList.add(
          Row(children:
          [
            Expanded(child:
            Text(item.split(' ')[0], textAlign: TextAlign.right, style:
            TextStyle(color: Colors.white, fontSize: 20))),
            Expanded(child:
            Text(item.split(' ')[1], textAlign: TextAlign.center, style:
            TextStyle(color: Colors.white, fontSize: 20),))
          ]
          )
      );
      return newList;
    });

    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(0)),
      child:
      Align(alignment: Alignment.center, child:
      Column(mainAxisAlignment: MainAxisAlignment.center,children: portions)
      ),
    );
  }
}
