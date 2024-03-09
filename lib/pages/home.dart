import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotato/pages/details.dart';
import 'package:zotato/service/database.dart';
import 'package:zotato/widgets/support_widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false , salad = false , burger = false;
  Stream? fooditemStream;
  ontheload() async{
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {
      
    });

  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }
   Widget allItemsVertically(){
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot ){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"])));
                      },
                      child:  Container(
                margin: EdgeInsets.only(right: 10, bottom: 20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(ds["Image"], height: 120, width: 120, fit: BoxFit.cover,)),
                        const SizedBox(width: 20,),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text(ds["Name"], style: AppWidget.lightsemitextstyetype(),)),
                              const SizedBox(height: 5,),
                               Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text('Honey goot cheese', style: AppWidget.lighttextstyetype(),)),
                              const SizedBox(height: 5,),
                               Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text('\$'+ds["Price"], style: AppWidget.lightsemitextstyetype(),))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
                    );

      }): CircularProgressIndicator();
    } );
  }
  Widget allItems(){
    return StreamBuilder(stream: fooditemStream, builder: (context, AsyncSnapshot snapshot ){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(ds["Image"], height: 150, width: 150 ,fit: BoxFit.cover,)),
                                Text(ds["Name"] , style: AppWidget.lightsemitextstyetype(),),
                                const SizedBox(height: 5,),
                                Text('Fresh And Healthy', style: AppWidget.lighttextstyetype(),),
                                const SizedBox(height: 5,),
                                Text('\$'+ds["Price"], style: AppWidget.textstyletype(),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

      }): CircularProgressIndicator();
    } );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hey There,', style: AppWidget.textstyletype(),),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text('Delicious Food', style: AppWidget.textstyetype(),),
              const SizedBox(height: 8,),
              Text('Discover And Get Great Food', style: AppWidget.lighttextstyetype(),),
              const SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: showItem()),
             
              
              const SizedBox(height: 30,),
              
                Container(
                  height: 270,
                  child: allItems()),
               const SizedBox(height: 30,),
             
             allItemsVertically(),

             SizedBox(height: 40,)
             
              
            ],
          
          ),
        ),
      ),
    );
  }
  Widget showItem(){
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async{
                    icecream = true;
                    pizza = false;
                    salad = false;
                    burger = false;
                    fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
                    setState(() {
                      
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: icecream?Colors.black:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('images/ice-cream.png', height: 40, width: 40, fit: BoxFit.cover,color: icecream?Colors.white:Colors.black,),
                    ),
                  ),
                ),
               GestureDetector(
                  onTap: ()async{
                    icecream = false;
                    pizza = true;
                    salad = false;
                    burger = false;
                    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
                    setState(() {
                      
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: pizza?Colors.black:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('images/pizza.png', height: 40, width: 40, fit: BoxFit.cover,color: pizza?Colors.white:Colors.black,),
                    ),
                  ),
                ),
               GestureDetector(
                  onTap: ()async{
                    icecream = false;
                    pizza = false;
                    salad = true;
                    burger = false;
                    fooditemStream = await DatabaseMethods().getFoodItem("Salad");
                    setState(() {
                      
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: salad?Colors.black:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('images/salad.png', height: 40, width: 40, fit: BoxFit.cover,color: salad?Colors.white:Colors.black,),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: ()async
                  {
                    icecream = false;
                    pizza = false;
                    salad = false;
                    burger = true;
                    fooditemStream = await DatabaseMethods().getFoodItem("Burger");
                    setState(() {
                      
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: burger?Colors.black:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('images/burger.png', height: 40, width: 40, fit: BoxFit.cover,color: burger?Colors.white:Colors.black,),
                    ),
                  ),
                ),
              ],
            );

  }
}