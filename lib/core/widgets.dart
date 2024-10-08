
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBarSessionDecorate(String title,
    [ bool backbutton = false]) {
  return AppBar(centerTitle: true, backgroundColor: Colors.orangeAccent,
    title: Text(
      title,
      style: 
           GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 33,),),
    ),
    automaticallyImplyLeading: backbutton,
  );
}