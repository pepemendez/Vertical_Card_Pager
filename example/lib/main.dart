import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'entities/diet.dart';
import 'meal_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Diet diet = Diet();

  List<String> titles = Diet().getTitles(0);
  List<Widget> images = Diet().getContainer(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: VerticalCardPager(
                  textStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  titles: titles,
                  images: images,
                  onPageChanged: (page) {
                      setState(() {
                        double selected = page.ceilToDouble();
                        if(page - selected == 0.0){
                          titles = diet.getTitles(selected.ceil());
                          images = diet.getContainer(selected.ceil());
                        }
                        else{
                          titles = diet.getTitles(-1);
                          images = diet.getContainer(-1);
                        }
                      });
                  },
                  align: ALIGN.CENTER,
                  onSelectedItem: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          MyStatefulWidget(meal: diet.myDiet[index],)
                          //MealDetails(
                          //  meal: diet.myDiet[index],
                          //),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
