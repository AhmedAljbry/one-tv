import 'package:flutter/material.dart';
import 'package:onetv/Screen/comp.dart';
import 'package:onetv/b.dart';

import 'package:video_player/video_player.dart';

import '../s.dart';


class url extends StatefulWidget {

   url({super.key});

  @override
  State<url> createState() => _urlState();
}

class _urlState extends State<url> {
  Color mainColor = Color(0xFF402565);
  Color helpColor = Color(0xFF30be96);
  Color backgroundPrimary = Color(0xFFeeeeee);
  var fromekey=GlobalKey<FormState>();
  var namecontroller=TextEditingController();
  var urlcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blendColors(mainColor, helpColor, backgroundPrimary)
      ),
      body:Form(
        key: fromekey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            defuletTextFormField(
              controller:namecontroller,
              picon: Icons.title,
              validator:(value)
              {
                if(value.isEmpty)
                  {
                    return "enter name";
                  }
                else
                  {
                    return  null;
                  }
              },
              keyboardType:TextInputType.name,
              labletext:"enter name video",

            ),
            defuletTextFormField(
              controller:urlcontroller,
              picon: Icons.http,
              validator:(value)
              {
                if(value.isEmpty)
                {
                  return "enter url";
                }
                else
                {
                  return  null;
                }
              },
              keyboardType:TextInputType.url,
              labletext:"enter name video",
            ),

            defauletButton
              (
              text: "Sava",
              function: ()
              {
                  if( fromekey.currentState!.validate())
                    {
                     Navigator.push(context, MaterialPageRoute(builder:(context) => VideoPlayersScreen(lowurl:urlcontroller.text ,sdurl:urlcontroller.text ,hdurl:urlcontroller.text ,fhdurl:urlcontroller.text,)));
                    }
              }
            )
          ],
        ),
      ) ,
    );


  }
  Color blendColors(Color color1, Color color2, Color color3) {
    return Color.fromARGB(
      255,
      (color1.red + color2.red + color3.red) ~/ 3,
      (color1.green + color2.green + color3.green) ~/ 3,
      (color1.blue + color2.blue + color3.blue) ~/ 3,
    );
  }
}

