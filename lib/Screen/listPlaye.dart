import 'package:flutter/material.dart';
import 'package:onetv/Screen/url.dart';
import 'package:onetv/b.dart';
import 'package:onetv/s.dart';

import 'package:video_player/video_player.dart';

class list extends StatefulWidget {

 late List title=
   [
     "فديو تجريبي",
     title1,
   ];
 late List url=
 [
   'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
   url1
 ];
 late String title1='';
 late String url1='';



  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ONE TV"),
        actions: [
          IconButton(onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder:(context) =>url()));
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildurl(widget.title ,widget.url,index),
          separatorBuilder:(context, index) => Divider(color: Colors.grey,),
          itemCount: widget.title.length,)
    );
  }
  //'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'
  Widget buildurl(List title,List url,index)=>InkWell(
    onTap: ()
    {
     Navigator.push(context, MaterialPageRoute(builder: (context) =>VideoPlayersScreen()
      ));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text(url[index],
          style:TextStyle(fontSize: 13,color: Colors.grey) ,)
      ],
    ),
  );

}
