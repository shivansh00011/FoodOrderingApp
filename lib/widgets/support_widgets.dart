import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget{
  static TextStyle textstyletype(){
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    );
  }
  static TextStyle textstyetype(){
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 24,
    );
  }
  static TextStyle lighttextstyetype(){
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Colors.black38,
      fontSize: 15,
    );
  }
  static TextStyle lightsemitextstyetype(){
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 18,
    );
  }
}