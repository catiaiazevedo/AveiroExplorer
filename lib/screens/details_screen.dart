import 'package:aveiroexplorer/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailPage extends StatelessWidget 
{
  final String name;
  final String description;
  final String tagLine;
  final double latitude;
  final double longitude;

  final FlutterTts flutterTts = FlutterTts();

  DetailPage(this.name, this.description, this.tagLine, this.latitude, this.longitude);

  speak(String text) async {
    await flutterTts.setLanguage("pt-PT");
    await flutterTts.setPitch(1.0); //0.5 to 1.5
    await flutterTts.speak(text);
  }

  stopSpeaking() async
  {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          
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
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pop(); 40.639453663981236, -8.650906087045751
                      Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapPage(destinationLatitude: latitude, destinationLongitude: longitude)),
                          );
                    },
                    child: Container(
                      height: 57.6,
                      width: 57.6,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        color: const Color(0x10000000),
                      ),
                      child: SvgPicture.asset('assets/svg/icon_location.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),

              Padding(
                    padding: const EdgeInsets.only(top: 19.2, left: 50, right: 50),
                    child: Text(
                      tagLine,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.only(top: 19.2, left: 50, right: 50, bottom: 19.2),
                child: Text(
                  description,
                  maxLines: 12,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),

              InkWell(
                child: Container(
                  height: 20,
                  width: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.6),
                    color: Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 28.8, right: 28.8),
                    child: FittedBox(
                      child: Text(
                        'Transcrever',
                        style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ),
                onTap: () => speak(description)
              ),
              
              InkWell(
                child: Container(
                  height: 20,
                  width: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.6),
                    color: Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 28.8, right: 28.8),
                    child: FittedBox(
                      child: Text(
                        'Parar',
                        style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ),
                onTap: () => stopSpeaking()
              ),

              Padding(
                padding: const EdgeInsets.only(top: 100, left: 50, right: 30, bottom: 19.2),
                child: Text(
                  "Gostaria de Visitar? \nEncontre o caminho mais perto através do ícone acima. \nObtenha também o código QR que lhe dará descontos exclusivos:",
                  style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),

              InkWell(
                
                child: Container(
                  height: 20,
                  width: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.6),
                    color: Colors.transparent),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 28.8, right: 28.8),
                    child: FittedBox(
                      child: Text(
                        'Código QR',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepOrange),
                      ),
                    ),
                  ),
                ),
                ),
                onTap: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => _buildPopupDialog(context)
                  );
                },
              ),

          ],
        ),
      ),
        ]
      ),
    );
  }
  Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      'QRCode para usar em $name!',
      textAlign: TextAlign.center,
    ),
    content: Expanded(
      child: SizedBox(
        height: 250,
        width: 500,
        child: Center(
          child: QrImage(
            data: name,
            padding: const EdgeInsets.all(0.0) 
          ),
        ),
      ),
    ),  
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
   );
  }
}