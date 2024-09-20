
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_watchlist/data/api/search_stock.dart';

AppBar appBarSessionDecorate(String title,
    [ bool backbutton = false]) {
  return AppBar(centerTitle: true, backgroundColor: Colors.orangeAccent,
    title: InkWell(
      onTap: (){
        SearchStockService().searchStock(searchText:'deva');
      },
      child: Text(
        title,
        style: 
             GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 33,),),
      ),
    ),
    automaticallyImplyLeading: backbutton,
  );
}