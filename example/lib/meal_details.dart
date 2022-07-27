import 'package:flutter/material.dart';
import 'entities/meal.dart';

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(List<Menu> data, Meal meal) {
  var porciones = meal.getPortions();
  return List<Item>.generate(data.length, (int index) {
    return Item(
      headerValue: "${data[index].name}, porciones ${porciones.firstWhere((element) => data[index].name.contains(element.split(' ')[0])).split(' ')[1]}",
      expandedValue: 'This is item number $index',
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key, @required this.meal}) : super(key: key);
  final Meal meal;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState(meal: meal);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Meal meal;

  List<Item> _data;
  List<Menu> data = [];

  _MyStatefulWidgetState({@required this.meal});

  @override
  void initState() {
    dataList.forEach((element) {
      var menu = Menu.fromJson(element);
      var aliments = meal.getAliments();
      var isIncluded = aliments.firstWhere((element) => menu.name.contains(element), orElse: () => "");
      print(isIncluded);
      if (isIncluded.isNotEmpty) {
        data.add(menu);
      }
    });

    _data = generateItems(data, meal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildList(Menu list) {
    if (list.subMenu.isEmpty)
      return Builder(
          builder: (context) {
            return ListTile(
                leading: SizedBox(),
                title: Text(list.name)
            );
          }
      );
    return ExpansionTile(
      leading: Icon(list.icon),
      title: Text(
        list.name,
      ),
      children: list.subMenu.map(_buildList).toList(),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        var current = data.where((element) => item.headerValue.contains(element.name)).first;
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: current.subMenu.length,
            itemBuilder:(context, index){
              if(current.subMenu[index].subMenu.isEmpty) {
                return ListTile(
                    leading: SizedBox(),
                    title: Text(current.subMenu[index].name)
                );
              }
              else{
                return _buildList(current.subMenu[index]);
              }
            },),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


List dataList = [
  {
    "name": "cereal",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "1/4 taza amaranto"},
      {"name": "1/2 taza arroz cocido"},
      {"name": "3/4 taza hojuelas de avena"},
      {"name": "1/7 pieza baguette"},
      {"name": "1/3 bolillo"},
      {"name": "1/2 pieza bollo hamburguesa"},
      {"name": "1/3 taza camote"},
      {"name": "1/4 betabel"},
      {"name": "1 crepa"},
      {"name": "1 elote cocido"},
      {"name": "1/2 taza elote desgranado"},
      {"name": "1/2 taza pasta"},
      {"name": "6 galletas de animalitos"},
      {"name": "5 galletas marías"},
      {"name": "3 cucharadas granola"},
      {"name": "1/2 hot cake"},
      {"name": "1/2 pieza buena noche"},
      {"name": "1/2 palanqueta de amaranto"},
      {"name": "2 1/2 taza palomitas"},
      {"name": "1/2 pambazo"},
      {"name": "1 rebanada para pan bimbo"},
      {"name": "1 rebanada pan tostado"},
      {"name": "1 papa"},
      {"name": "5 papita cambray"},
      {"name": "20g quinoa"},
      {"name": "1 tortilla maíz"},
      {"name": "2 tortillas de nopal"},
      {"name": "1 tostada horneada (salma)"},
      {"name": "1 paquete galleta salma (18 gramos o 3 piezas)"},
    ]
  },
  {
    "name": "fruta",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "1 arándano fresco"},
      {"name": "1/2 taza de arándano deshidratado"},
      {"name": "20 cerzas"},
      {"name": "1 ciruela"},
      {"name": "2 duraznos pequeños"},
      {"name": "17 fresas"},
      {"name": "1 granada roja"},
      {"name": "2 guayabas pequeñas"},
      {"name": "1 kiwi"},
      {"name": "1 mandarina"},
      {"name": "1 mango manila"},
      {"name": "1 manzana"},
      {"name": "1/3 mamey"},
      {"name": "1 taza melón picado"},
      {"name": "1 naranja"},
      {"name": "1 taza de papaya picada"},
      {"name": "10 pasas"},
      {"name": "1/2 pera"},
      {"name": "1 taza piña picada"},
      {"name": "1/2 plátano"},
      {"name": "3 plátanos dominicos"},
      {"name": "1 taza de sandía picada"},
      {"name": "2 tejocotes"},
      {"name": "1 toronja"},
      {"name": "2 tunas"},
      {"name": "18 uvas"},
      {"name": "1 taza de zarzamoras"},
    ]
  },
  {
    "name": "verduras",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "acelga"},
      {"name": "alcachofa"},
      {"name": "apio"},
      {"name": "brócoli"},
      {"name": "calabacita"},
      {"name": "cebolla"},
      {"name": "champiñón"},
      {"name": "chayote"},
      {"name": "chile poblano"},
      {"name": "col"},
      {"name": "coliflor"},
      {"name": "flor de calabaza"},
      {"name": "ejote"},
      {"name": "espinaca"},
      {"name": "espágarragos"},
      {"name": "germen de alfalfa"},
      {"name": "germen de soya"},
      {"name": "germen de trigo"},
      {"name": "hongos"},
      {"name": "huazontle"},
      {"name": "huitlacoche"},
      {"name": "jitomate"},
      {"name": "tomate verde"},
      {"name": "nopal"},
      {"name": "pepinillos"},
      {"name": "pimiento morrón"},
      {"name": "poro"},
      {"name": "rábano"},
      {"name": "quelite"},
      {"name": "romeritos"},
      {"name": "setas"},
      {"name": "verdolagas"},
      {"name": "xonocostle"},
      {"name": "zanahoria"},
      {"name": "lechuga"},
    ]
  },
  {
    "name": "carnes 30g o 60g crudo",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {
        "name": "pollo",
        "subMenu": [
            {"name": "pechuga sin piel"},
            {"name": "pechuga desmenuzada"},
            {"name": "pierna"},
            {"name": "muslo"},
            {"name": "hígado de pollo"},
            {"name": "molida de pollo"},
            {"name": "5 patitas"},
            {"name": "5 mollejas"},
          ]
      },
      {
        "name": "huevo",
        "subMenu": [
          {"name": "1 pieza entera"},
          {"name": "2 claras de huevo"},
          {"name": "4 cucharadas de sustito de huevo líquido"},
        ]
      },
      {
        "name": "quesos",
        "subMenu": [
          {"name": "queso panela"},
          {"name": "queso oaxaca"},
          {"name": "queso crema"},
          {"name": "queso fresco"},
        ]
      },
      {
        "name": "res",
        "subMenu": [
          {"name": "bistec"},
          {"name": "chambarete"},
          {"name": "cuete"},
          {"name": "corazón de res"},
          {"name": "falda"},
          {"name": "machaca"},
          {"name": "maciza"},
          {"name": "puntas de filete"},
          {"name": "agujas de res"},
          {"name": "arrachera"},
          {"name": "carne molida"},
          {"name": "hígado"},
        ]
      },
      {
        "name": "pescado (2 a 3 veces por semana)",
        "subMenu": [
          {"name": "sardina"},
          {"name": "salmón"},
          {"name": "arenque"},
          {"name": "trucha"},
          {"name": "pez espada"},
          {"name": "caballa"},
          {"name": "guachinango"},
          {"name": "mojarra"},
          {"name": "pulpo cocido"},
          {"name": "2/3 barra surimi"},
          {"name": "filete de tapia"},
          {"name": "medallón de atún fresco"},
          {"name": "1/3 lata de lomo de atún en agua"},
          {"name": "5 camarones"},
        ]
      },
      {
        "name": "embutidos (solo 2 veces por semana)",
        "subMenu": [
          {"name": "2 rebanadas de jamón de pavo"},
          {"name": "1 salchica de pavo"},
        ]
      },
      {
        "name": "puerco (solo 1 vez por semana)",
        "subMenu": [
          {"name": "lomo"},
          {"name": "1/2 chuleta"},
          {"name": "falda"},
          {"name": "paletilla"},
          {"name": "espaldilla"},
          {"name": "espinazo"},
        ]
      },
    ]
  },
  {
    "name": "leguminosas 1/2 taza",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "frijol"},
      {"name": "haba"},
      {"name": "lenteja"},
      {"name": "garbanzo"},
      {"name": "soya"},
      {"name": "alverjón"},
      {"name": "chícharo"},
    ]
  },
  {
    "name": "leche 1 taza",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "leche descremada"},
      {"name": "leche semidescremada"},
      {"name": "leche deslactosada"},
      {"name": "yoguth natural"},
      {"name": "yoplait griego sin azúcar"},
      {"name": "oikos griego"},
      {"name": "onei yogurth griego natural"},
      {"name": "kikland yogurt griego "},
    ]
  },
  {
    "name": "grasas",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "1/3 pieza aguacate"},
      {"name": "1 cdta aceite de olivo"},
      {"name": "1 cdta coco extra virgen crudo"},
      {"name": "6 aceitunas"},
    ]
  },
  {
    "name": "semillas",
    "icon": Icons.fastfood_outlined,
    "subMenu": [
      {"name": "4 cucharaditas ajonjolí"},
      {"name": "10 almendras"},
      {"name": "9 avellanas"},
      {"name": "14 cacahuates"},
      {"name": "5 cucharaditas semilla chía"},
      {"name": "3 nueces"},
      {"name": "3 nuez de castilla"},
      {"name": "12g nuez de la india"},
      {"name": "4 cucharadita crema de cacahuate"},
      {"name": "60 pepitas"},
      {"name": "18 pistache"},
      {"name": "1.5 cucharadita semilla de calabaza"},
      {"name": "4 cucharaditas semilla de girasol"},
      {"name": "1 taza leche de almendras"},
    ]
  },
];

class Menu {
  String name;
  IconData icon;
  List<Menu> subMenu = [];

  Menu({this.name, this.subMenu, this.icon});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu?.add(new Menu.fromJson(v));
      });
    }
  }
}