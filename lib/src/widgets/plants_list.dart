import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:monopoly/src/utils/currency_formater_helper.dart';
import 'package:monopoly/src/models/plant.dart';
import 'package:monopoly/src/pages/home_page.dart';
import 'package:monopoly/src/widgets/custom_icons_icons.dart';

class PlantsList extends StatefulWidget {
  PlantsList(
    this.plants,
    this.scrollController,
    this.showIndex,
  );

  final List<Plant> plants;
  final ScrollController scrollController;
  final int showIndex;

  @override
  _PlantsListState createState() => _PlantsListState();
}

class _PlantsListState extends State<PlantsList> {
  Widget _buildPlantCard(Plant plant, int index) {
    return Container(
      padding: EdgeInsets.only(right: 15.0, bottom: 15),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ]),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                    color : AppColors.mainColor,
//                  color: (widget.showIndex == index)
//                      ? AppColors.mainColor
//                      : AppColors.secondColor,
                ),
                height: 120.0,
                width: 400.0,
              ),
              //_buildImage(plant.image),
              //_buildPrice(plant.price),
              _buildInfo(plant),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (c, a1, a2) => PlantDetail(plant),
          //     transitionsBuilder: (c, anim, a2, child) =>
          //         FadeTransition(opacity: anim, child: child),
          //     transitionDuration: Duration(milliseconds: 0),
          //   ),
          // );
        },
      ),
    );
  }

  Widget _buildPrice(double price) {
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'FROM',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            Text(
              CurrencyFormater.usdFormat(price),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String img) {
    return Positioned(
      left: 10.0,
      top: 0.0,
      child: Container(
        width: 400.0,
        height: 120.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(Plant plant) {
    return Positioned(
      top: 10.0,
      left: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 2.0),
          Text(
            plant.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 40.0),
          Row(
            children: <Widget>[
              Container(
                height: 35.0,
                width: 35.0,
//                decoration: new BoxDecoration(
//                  border: new Border.all(
//                    color: Colors.white.withOpacity(0.5),
//                  ),
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.lightGreenAccent,
                  size: 23.0,
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                height: 35.0,
                width: 35.0,
//                decoration: new BoxDecoration(
//                  border: new Border.all(
//                    color: Colors.white.withOpacity(0.5),
//                  ),
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
                child: Icon(
                  CustomIcons.droplet,
                  color: Colors.lightGreenAccent,
                  size: 23.0,
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                height: 35.0,
                width: 35.0,
//                decoration: new BoxDecoration(
//                  border: new Border.all(
//                    color: Colors.white.withOpacity(0.5),
//                  ),
//                  borderRadius: BorderRadius.circular(5.0),
//                ),
                child: Icon(
                  FontAwesomeIcons.thermometerHalf,
                  color: Colors.lightGreenAccent,
                  size: 23.0,
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  child: Icon(
                    CustomIcons.soil_moisture,
                    color: Colors.lightGreenAccent,
                    size: 23.0,
                  ),
                ),
//                onTap: () {
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) => DetailPage(plant),
//                    ),
//                  );
//                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddToCart() {
    return Positioned(
      top: 180.0,
      left: 85,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.black,
        ),
        child: Center(
          child: Icon(
            FontAwesomeIcons.tint,
            color: Colors.white.withOpacity(0.5),
            //Icons.shopping_cart,
            //color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: widget.scrollController,
        padding: EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (_, int index) {
          return _buildPlantCard(widget.plants[index], index);
        },
        itemCount: widget.plants.length,
      ),
    );
  }
}
