import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:monopoly/src/widgets/plantify_bottom_app_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monopoly/colors.dart' as AppColors;
import 'package:monopoly/main.dart';
import 'package:monopoly/src/models/plant.dart';
import 'package:monopoly/src/pages/monopoly_card_details_page.dart';
import 'package:monopoly/src/widgets/description_widget.dart';
import 'package:monopoly/src/widgets/monopoly_icon_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum Monopoly { BANKER, PLAYER_RED, PLAYER_GREEN, PLAYER_BLUE, PLAYER_YELLOW }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentPage = 0;
  final databaseReference = FirebaseDatabase.instance.reference();
  String description;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoading = false;
  bool isPressed = false;
  final List<dynamic> pages = [
    HomePage(),
  ];

  List<List<Plant>> plantGroups = [];
  List<Plant> plants = [
    Plant(
        name: 'Bank',
        color: AppColors.mainColor,
        type: ['Outdoor'],
        top: true,
        plantOfTheMonth: true,
        price: 45.50,
        size: 'Average',
        image: 'assets/images/cat_palm.png',
        description:
            'The Cat Palm is the most popular from the Chamaedora species of trees. The palm itself doesn\'t have a trunk and it’s frawns have a downward growing pattern. They are often used as garden bed “bushy” plants in tropical and subtropical regions under tall growing trees that provide large amounts of shade. The scientific name for the Cat Palm is Chamaedorea (ky-mee-DOR-ee-uh) Cataractarum (kat-uh-RAK-tar-um).',
        temperature: 20,
        light: 80,
        totalAmount: 15.000,
        soilMoisture: 60,
        waterTankLevel: 10,
        wateringTime: 30,
        alerts: 'Please fill the water tank'),
    Plant(
        name: 'Aravind',
        color: Colors.red[900],
        type: ['Outdoor', 'Indoor'],
        top: true,
        plantOfTheMonth: false,
        price: 235.00,
        size: 'Big',
        image: 'assets/images/monstera.png',
        description:
            'Monstera deliciosa, the ceriman, is a species of flowering plant native to tropical forests of southern Mexico, south to Panama. It has been introduced to many tropical areas, and has become a mildly invasive species in Hawaii, Seychelles, Ascension Island and the Society Islands.',
        temperature: 20,
        light: 80,
        totalAmount: 15.040,
        soilMoisture: 60,
        waterTankLevel: 10,
        wateringTime: 30,
        alerts: 'This plant need water'),
    Plant(
        name: 'Srinivas',
        color: Colors.green[900],
        type: ['Indoor'],
        top: true,
        plantOfTheMonth: true,
        price: 35.00,
        size: 'Small',
        image: 'assets/images/bird_of_paradise.png',
        description:
            'Strelitzia alba is a herbaceous plant of the Bird of Paradise family and is endemic to the Garden Route along the southernmost coastal regions of the Eastern and Western Cape in South Africa. The Swedish botanist Thunberg, who in 1792 described and published it in Nov. Gen. Pl.: 113 as Strelitzia augusta, first found it in the neighbourhood of the Piesang River at Plettenberg Bay – \'piesang\' being Afrikaans for \'banana\'. Francis Masson, who was then the Botanical Collector for Kew, introduced it to Europe in 1791. This is one of three arborescent Strelitzias, the other two being Strelitzia caudata and Strelitzia nicolai.',
        temperature: 20,
        light: 80,
        totalAmount: 15.000,
        soilMoisture: 80,
        waterTankLevel: 10,
        wateringTime: 30,
        alerts: 'Next watering in 1 day (every 7 days)'),
    Plant(
        name: 'Sirisha',
        color: Colors.blue[900],
        type: ['Indoor', 'Outdoor'],
        top: true,
        plantOfTheMonth: true,
        price: 45.50,
        size: 'Average',
        image: 'assets/images/cat_palm.png',
        description:
            'The Cat Palm is the most popular from the Chamaedora species of trees. The palm itself doesn\'t have a trunk and it’s frawns have a downward growing pattern. They are often used as garden bed “bushy” plants in tropical and subtropical regions under tall growing trees that provide large amounts of shade. The scientific name for the Cat Palm is Chamaedorea (ky-mee-DOR-ee-uh) Cataractarum (kat-uh-RAK-tar-um).',
        temperature: 20,
        light: 80,
        totalAmount: 15000,
        soilMoisture: 60,
        waterTankLevel: 10,
        wateringTime: 30,
        alerts: 'Please fill the water tank'),
    Plant(
        name: 'Player 4',
        color: Colors.yellow[700],
        type: ['Indoor', 'Outdoor'],
        top: true,
        plantOfTheMonth: true,
        price: 45.50,
        size: 'Average',
        image: 'assets/images/cat_palm.png',
        description:
            'The Cat Palm is the most popular from the Chamaedora species of trees. The palm itself doesn\'t have a trunk and it’s frawns have a downward growing pattern. They are often used as garden bed “bushy” plants in tropical and subtropical regions under tall growing trees that provide large amounts of shade. The scientific name for the Cat Palm is Chamaedorea (ky-mee-DOR-ee-uh) Cataractarum (kat-uh-RAK-tar-um).',
        temperature: 20,
        light: 80,
        totalAmount: 15.000,
        soilMoisture: 60,
        waterTankLevel: 10,
        wateringTime: 30,
        alerts: 'Please fill the water tank'),
  ];

  ScrollController scrollController;
  int selectedIndex = 0;
  int selectedPage = 0;
  TabController tabController;

  int _currentIndex = 0;
  bool _dark_theme = false;
  int _groupIndex = 0;
  int _index = 0;
  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  int _value = 0;

  @override
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          Container(
            padding: EdgeInsets.only(left: 15.0, bottom: 10),
            child: Row(
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        // set the default style for the children TextSpans
                        children: [
                      TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppColors.mainColor),
                          text: 'Bank'),
                    ])),
              ],
            ),
          ),
          _buildMonopolyCard(plants, Monopoly.BANKER),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 15.0, bottom: 10),
            child: Row(
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        // set the default style for the children TextSpans
                        children: [
                      TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: AppColors.mainColor),
                          text: 'Players'),
                    ])),
              ],
            ),
          ),
          // _buildRedPlayer(),
          _buildMonopolyCard(plants, Monopoly.PLAYER_RED),
          SizedBox(height: 10.0),
          //_buildGreenPlayer(),
          _buildMonopolyCard(plants, Monopoly.PLAYER_GREEN),
          SizedBox(height: 10.0),
          _buildMonopolyCard(plants, Monopoly.PLAYER_BLUE),
          SizedBox(height: 10.0),
          _buildMonopolyCard(plants, Monopoly.PLAYER_YELLOW),
          //_buildYellowPlayer(),
        ],
      ),
    );
  }

  @override
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15.0, right: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    // set the default style for the children TextSpans
                    children: [
                  TextSpan(
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800]),
                      text: 'Monopoly'),
                ])),
          ],
        ),
      ),
    );
  }

  @override
  Widget _buildMonopolyCard(List<Plant> plants, Monopoly card) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10.0, bottom: 10),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: plants[card.index].color,
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
                  //color : AppColors.mainColor,
//                  color: (widget.showIndex == index)
//                      ? AppColors.mainColor
//                      : AppColors.secondColor,
                ),
                height: 100.0,
                width: 400.0,
              ),
              //_buildImage(plant.image),
              //_buildPrice(plant.price),
              _buildInfo(plants, card),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MonopolyCardDetailPage(plants, card),
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

  @override
  initState() {
    plantGroups.add(plants.where((p) => p.top == true).toList());
    plantGroups
        .add(plants.where((p) => p.type.indexOf('Outdoor') != -1).toList());
    plantGroups
        .add(plants.where((p) => p.type.indexOf('Indoor') != -1).toList());
    plantGroups.add(plants.where((p) => p.plantOfTheMonth == true).toList());

    tabController = TabController(vsync: this, length: 4);
    scrollController = ScrollController();
    scrollController.addListener(changeDescription);
    setState(() {
      description = plantGroups[_groupIndex][_index].description;
    });
    super.initState();
    isLoading = true;
  }

  Widget _buildInfo(List<Plant> plant, Monopoly card) {
    return Positioned(
      top: 10.0,
      left: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 2.0),
          Text(
            plant[card.index].name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Container(
                child: Icon(
                  MonopolyIcon.dollar,
                  color: Colors.white,
                  size: 33.0,
                ),
              ),
              Container(
                child: RichText(
                    text: TextSpan(
                        // set the default style for the children TextSpans
                        children: [
                      TextSpan(
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                          text: '${plants[card.index].totalAmount}'),
                    ])),
              ),
              SizedBox(width: 5.0),
            ],
          )
        ],
      ),
    );
  }

  changeDescription() {
    _value = scrollController.offset.round();
    if (_value > 0) {
      _index = (_value / 220).round();
      setState(() {
        description = plantGroups[_groupIndex][_index].description;
      });
    }
  }

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.end);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _dark_theme
          ? Color.fromRGBO(8, 33, 38, 1)
          : CupertinoColors.extraLightBackgroundGray,
      drawer: Drawer(),
      //appBar: _buildAppBar(),
      body: _buildBody(),
      //bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({@required this.expandedHeight});

  final double expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
