import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotato/service/database.dart';
import 'package:zotato/service/shared_pref.dart';
import 'package:zotato/widgets/support_widgets.dart';

class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {required this.detail,
      required this.image,
      required this.name,
      required this.price});
  

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }
  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  void initState() {
    super.initState();
    ontheload();
    
    total = int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
              Image.network(widget.image, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/2.5, fit: BoxFit.fill,),
              const SizedBox(height: 15,),
              Row(
               
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,style: AppWidget.lightsemitextstyetype(),),
                      
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      if(a>1){
                        --a;
                        total = total - int.parse(widget.price);
                      }
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                      child: Icon(Icons.remove, color: Colors.white,),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Text(a.toString(), style: AppWidget.lightsemitextstyetype(),),
                  const SizedBox(width: 20,),
                   GestureDetector(
                    onTap: (){
                      ++a;
                       total = total + int.parse(widget.price);
                      setState(() {
                        
                      });
                    },
                     child: Container(
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                      child: Icon(Icons.add, color: Colors.white,),
                                       ),
                   )
                  
                ],
              ),
              const SizedBox(height: 20,),
              Text(widget.detail, style: AppWidget.lighttextstyetype(),maxLines: 4,),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Text('Delivery Time', style: AppWidget.lightsemitextstyetype(),),
                  const SizedBox(width: 25,),
                  Icon(Icons.alarm, color: Colors.black54,),
                  const SizedBox(width: 5,),
                  Text('30 min', style: AppWidget.lightsemitextstyetype(),)
                ],
              ),
              Spacer(),
              Padding(padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Price', style: AppWidget.lightsemitextstyetype(),),
                      Text('\$'+total.toString(), style: AppWidget.textstyetype(),)
                    ],
                  ),
                  GestureDetector(
                    onTap: ()async{
                      Map<String, dynamic> addFoodtoCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };
                      await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Food Added to Cart",
                style: TextStyle(fontSize: 18.0),
              )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Add to cart', style: TextStyle(color: Colors.white, fontSize: 16,),),
                          const SizedBox(width: 40,),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.shopping_cart_outlined, color: Colors.white ,),
                    
                          ),
                          const SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              )
              
          ],
        )
      ),
    );
  }
}