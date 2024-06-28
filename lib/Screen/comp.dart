import 'package:flutter/material.dart';


String videoUrl="";
Widget defuletTextFormField({
  required TextEditingController controller,
  required  validator,
  IconData? sufix,
  bool ispassword=false,
  required TextInputType keyboardType,
  required String labletext,
  onChanged,
  Submitted,
  onTap,
  required IconData picon,
  VoidCallback? suffixpass,
  bool isClock=true,
})

{
  return TextFormField(
      onTap:onTap ,
      keyboardType: keyboardType,
      obscureText:ispassword ,
      controller: controller,
      decoration:InputDecoration(
        label: Text(labletext),
        prefix: Icon(picon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        suffixIcon:sufix!=null ? IconButton(
            onPressed:suffixpass,
            icon: Icon(sufix)):null,

      ),
      onChanged: onChanged,
      onFieldSubmitted:Submitted ,
      validator:validator
  );
}
Widget defauletButton({

  color=Colors.blue,
  width=100.0,
  double roudes=20.0,
  required  function,
  required String text,
})=>Container(

  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(roudes),
    color: color,
  ),
  child: MaterialButton(onPressed:function,
    child: Text("$text",style: TextStyle(
      color: Colors.white,

    ),),
  ),
);


Future navigatorfansh({required context,required Widget widget})=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => widget ), (route) => false);