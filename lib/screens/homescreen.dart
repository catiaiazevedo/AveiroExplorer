import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aveiroexplorer/models/allacategories_model.dart';
import 'package:aveiroexplorer/screens/selectedplacescreen.dart';
import 'package:aveiroexplorer/widgets/custom_tab_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Page Controller
  final _pageController = PageController(viewportFraction: 0.877);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          
          if(!snapshot.hasData)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: snapshot.data!.docs.map((document){

            return Container(
              child: Column(
                children: <Widget>[
                  
                  /// Custom Navigation Drawer and Search Button
                  Container(
                    height: 57.6,
                    margin: const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 57.6,
                          width: 57.6,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            color: const Color(0x080a0928),
                          ),
                          child: SvgPicture.asset('assets/svg/icon_drawer.svg'),
                        ),
                        Container(
                          height: 57.6,
                          width: 57.6,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            color: const Color(0x080a0928),
                          ),
                          child: SvgPicture.asset('assets/svg/icon_search.svg'),
                        )
                      ],
                    ),
                  ),

                  /// Text Widget for Title
                  /*Padding(
                    padding: const EdgeInsets.only(top: 48, left: 28.8),
                    child: Text(
                      'Explore\nAveiro',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 45.6, fontWeight: FontWeight.w700),
                    ),
                  ),*/

                  Padding(
                    padding: const EdgeInsets.only(top: 48, left: 28.8, right: 28.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.55,
                          child: FittedBox(
                            child: Text(
                              'Explore\nAveiro',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 70,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Custom Tab bar with Custom Indicator
                  Container(
                    height: 30,
                    margin: const EdgeInsets.only(left: 14.4, top: 28.8),
                    alignment: Alignment.centerLeft,
                    child: DefaultTabController(
                      length: 2,
                      child: TabBar(
                          labelPadding: const EdgeInsets.only(left: 14.4, right: 14.4),
                          indicatorPadding:
                              const EdgeInsets.only(left: 14.4, right: 14.4),
                          isScrollable: true,
                          labelColor: const Color(0xFF000000),
                          unselectedLabelColor: const Color(0xFF8a8a8a),
                          labelStyle: GoogleFonts.lato(
                              fontSize: 14, fontWeight: FontWeight.w700),
                          unselectedLabelStyle: GoogleFonts.lato(
                              fontSize: 14, fontWeight: FontWeight.w700),
                          indicator: RoundedRectangleTabIndicator(
                              color: const Color(0xFF000000), weight: 2.4, width: 14.4),
                          tabs: const [
                            Tab(
                              child: Text('Populares'),
                            ),
                            Tab(
                              child: Text('Novos Destinos'),
                            )
                          ]),
                    ),
                  ),

                  /// ListView widget with PageView
                  /// Recommendations Section
                  Container(
                    height: 218.4,
                    margin: const EdgeInsets.only(top: 16),
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        document['front_image'].length,
                        (int index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SelectedPlaceScreen2(
                                    document['second_image'][index],
                                    document['name'][index], 
                                    document['description'][index].replaceAll("\\n", "\n\n"), 
                                    document['tagLine'][index], 
                                    document['price'][index],
                                    document['latitude'][index],
                                    document['longitude'][index])));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 28.8),
                            width: 333.6,
                            height: 218.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    document['front_image'][index]),
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  bottom: 19.2,
                                  left: 19.2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.8),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 19.2, sigmaX: 19.2),
                                      child: Container(
                                        height: 36,
                                        padding: const EdgeInsets.only(
                                            left: 16.72, right: 14.4),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                                'assets/svg/icon_location.svg'),
                                            const SizedBox(
                                              width: 9.52,
                                            ),
                                            Text(
                                              document['name'][index],
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: 16.8),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Dots Indicator
                  /// Using SmoothPageIndicator Library
                  Padding(
                    padding: const EdgeInsets.only(left: 28.8, top: 28.8),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: document['front_image'].length,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: Color(0xFF8a8a8a),
                          dotColor: Color(0xFFababab),
                          dotHeight: 4.8,
                          dotWidth: 6,
                          spacing: 4.8),
                    ),
                  ),

                  /// Text Widget for All Categories
                  Padding(
                    padding: const EdgeInsets.only(top: 48, left: 28.8, right: 28.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.5,
                          child: FittedBox(
                            child: Text(
                              'Todas as Categorias',
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// ListView for All Categories Section
                  Container(
                    margin: const EdgeInsets.only(top: 33.6),
                    height: 45.6,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 28.8, right: 9.6),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 19.2),
                          height: 45.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            color: Color(int.parse(categories[index].color)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                width: 19.2,
                            ),
                              Image.asset(
                                categories[index].image,
                                height: 35,
                              ),
                              const SizedBox(
                                width: 19.2,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  /// ListView for All Categories Section
                  Container(
                    margin: const EdgeInsets.only(top: 28.8, bottom: 16.8),
                    height: 124.8,
                    child: ListView.builder(
                      itemCount: document['front_image'].length,
                      padding: const EdgeInsets.only(left: 28.8, right: 12),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SelectedPlaceScreen2(
                                    document['second_image'][index], 
                                    document['name'][index], 
                                    document['description'][index].replaceAll("\\n", "\n\n"), 
                                    document['tagLine'][index], 
                                    document['price'][index],
                                    document['latitude'][index],
                                    document['longitude'][index])));
                          },
                          child: Container(
                            height: 124.8,
                            width: 188.4,
                            margin: const EdgeInsets.only(right: 16.8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.6),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    CachedNetworkImageProvider(document['front_image'][index]),
                              ),
                            ),
                            child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    bottom: 8.2,
                                    left: 8.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.8),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaY: 8.2, sigmaX: 8.2),
                                        child: Container(
                                          height: 20,
                                          padding: const EdgeInsets.only(
                                              left: 10.72, right: 18.4),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                  'assets/svg/icon_location.svg'),
                                              const SizedBox(
                                                width: 8.52,
                                              ),
                                              Text(
                                                document['name'][index],
                                                style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14.8),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList()
        );
        }),
    );
  }
}