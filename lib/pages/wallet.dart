import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zotato/service/database.dart';
import 'package:zotato/service/shared_pref.dart';
import 'package:zotato/widgets/app_constant.dart';
import 'package:zotato/widgets/support_widgets.dart';
import 'package:http/http.dart' as http;
class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet,id;
  int? add;
  TextEditingController amountcontroller = new TextEditingController();
  getthesharedpref()async{
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {
      
    });
  }
  ontheload()async{
    await getthesharedpref();
    setState(() {
      
    });
  }
  @override
  void initState(){
    ontheload();
    super.initState();

  }
  Map<String , dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: wallet==null?CircularProgressIndicator(): Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Material(
            elevation: 2.0,
            child: Container(

             
              padding: EdgeInsets.only(bottom: 10),
              child: Center(child: Text("Wallet", style: AppWidget.textstyetype(),)))),
              const SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2)
                ),
                child: Row(
                  children: [
                    Image.asset('images/wallet.png', height: 60,width: 60,fit: BoxFit.cover,),
                    const SizedBox(width: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Wallet', style: AppWidget.lightsemitextstyetype(),),
                        const SizedBox(height: 5,),
                        Text("\$"+wallet!, style: AppWidget.textstyetype(),)
                      ],
                    )

                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Add Money', style: AppWidget.lightsemitextstyetype(),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      makePayment('100');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2),), borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$"+"100",style: AppWidget.lightsemitextstyetype(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment('500');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2),), borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$"+"500",style: AppWidget.lightsemitextstyetype(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment( '1000');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2),), borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$"+"1000",style: AppWidget.lightsemitextstyetype(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment( '2000');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2),), borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$"+"2000",style: AppWidget.lightsemitextstyetype(),),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  openEdit();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF008080),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text("Add Money", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),),
                ),
              )


        ],
      ),
     ),
    );
  }
 Future<void> makePayment(amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');

      // var gpay = PaymentSheetGooglePay(merchantCountryCode: "GB",
      //     currencyCode: "GBP",
      //     testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Abhi',
              ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(amount);
    } catch (err) {
      print(err);
    }
  }

 
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51Oq7VvSD1oR4oLstUrH6MOqQaVrLRN3DQ7cpezmSDXT4eYpcFaruLuUkk0MQpnbyDz5n9e45tSDPbE8tsSd7ql5n00dUO7xfpX',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        add = int.parse(wallet!)+int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().UpdateUserWallet(id!,add.toString());

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                       Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));
                await getthesharedpref();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
    calculateAmount(String amount) {
    final calculatedAmunt = int.parse(amount)*100 ;

    return calculatedAmunt.toString();
  }
   Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel)),
                        SizedBox(
                          width: 60.0,
                        ),
                        Center(
                          child: Text(
                            "Add Money",
                            style: TextStyle(
                              color: Color(0xFF008080),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Amount"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 2.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: amountcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Enter Amount'),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          makePayment(amountcontroller.text);
                        },
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFF008080),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));



}