import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget 
{
  final String name;
  final String description;
  final String tagLine;

  final FlutterTts flutterTts = FlutterTts();

  DetailPage(this.name, this.description, this.tagLine);

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
                      //Navigator.of(context).pop();
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
                    padding: const EdgeInsets.only(top: 19.2),
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
                    padding: const EdgeInsets.only(top: 19.2),
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
                  maxLines: 17,
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
                padding: const EdgeInsets.only(top: 100, left: 50, right: 320, bottom: 19.2),
                child: Text(
                  "Gostaria de Visitar? Encontre o caminho mais perto através do ícone acima. \nObtenha também o código QR que lhe dará descontos exclusivos.",
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
                  
                },
              ),

          ],
        ),
      ),
        ]
      ),
    );
  }
}