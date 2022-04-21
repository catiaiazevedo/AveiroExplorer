import 'package:aveiroexplorer/screens/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelectedPlaceScreen2 extends StatelessWidget {
  final _pageController = PageController();
  
  final String image;
  final String name;
  final String description;
  final String tagLine;
  final int price;
  final double latitude;
  final double longitude;

  SelectedPlaceScreen2(this.image, this.name, this.description, this.tagLine, this.price, this.latitude, this.longitude);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          
          /// PageView for Image
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              1,
              (int index) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        image),
                  ),
                ),
              ),
            ),
          ),

          /// Custom Button
          SafeArea(
            child: Container(
              height: 57.6,
              margin: const EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 57.6,
                      width: 57.6,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        color: const Color(0x10000000),
                      ),
                      child:
                          SvgPicture.asset('assets/svg/icon_left_arrow.svg'),
                    ),
                  ),
                  const FavoriteButton()
                ],
              ),
            ),
          ),

          /// Content
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              padding: const EdgeInsets.only(left: 28.8, bottom: 48, right: 28.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 1,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Color(0xFFFFFFFF),
                        dotColor: Color(0xFFababab),
                        dotHeight: 4.8,
                        dotWidth: 6,
                        spacing: 4.8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.2),
                    child: Text(
                      tagLine,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.2),
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                              'Desde',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              '\€ ${price.toString()} / pessoa',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        child: Container(
                          height: 62.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            color: Colors.white),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.only(left: 28.8, right: 28.8),
                            child: FittedBox(
                              child: Text(
                                'Explore Agora >>',
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPage(name, description, tagLine, latitude, longitude))
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


/// FavoriteButton Icon
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 57.6,
        width: 57.6,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.6),
          color: const Color(0x10000000),
        ),
        child: SvgPicture.asset(isFavorite
            ? 'assets/svg/icon_heart_fill_red.svg'
            : 'assets/svg/icon_heart_fill.svg'),
      ),
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
