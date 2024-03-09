import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zotato/pages/home.dart';
import 'package:zotato/pages/order.dart';
import 'package:zotato/pages/profile.dart';
import 'package:zotato/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  late List<Widget> pages;
  late Widget currentPage ; 
  late Home homepage;
  late Order order ;
  late Wallet wallet ; 
  late Profile profile;
  @override
  void initState() {
    homepage = Home();
    order = Order();
    wallet = Wallet();
    profile = Profile();
    
    pages = [homepage , order , wallet, profile];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
        Icon(Icons.home_outlined , color: Colors.white,),
         Icon(Icons.shopping_bag_outlined , color: Colors.white,),
          Icon(Icons.wallet_outlined , color: Colors.white,),
           Icon(Icons.person_outlined , color: Colors.white,),
      ]),body: pages[currentIndex],

    );
  }
}