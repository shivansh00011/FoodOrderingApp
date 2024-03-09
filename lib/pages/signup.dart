import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:zotato/pages/bottomnavbar.dart';
import 'package:zotato/pages/login.dart';
import 'package:zotato/service/database.dart';
import 'package:zotato/service/shared_pref.dart';
import 'package:zotato/widgets/support_widgets.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email="",password="",name="";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  registration() async{
    if(password!=null){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.red,
          content: Text('Registered Successfully', style: TextStyle(fontSize: 20.0),))));
          
          String Id = randomAlphaNumeric(10);
          Map<String, dynamic> addUserInfo = {
            "Name": namecontroller.text,
            "Email": mailcontroller.text,
            "Wallet":"0",
            "Id":Id,
          };
          await DatabaseMethods().addUserDetail(addUserInfo, Id);
          await SharedPreferenceHelper().saveUserName(namecontroller.text);
          await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
          await SharedPreferenceHelper().saveUserWallet('0');
          await SharedPreferenceHelper().saveUserId(Id);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNav()));
      }on FirebaseException catch(e){
        if(e.code == 'weak password'){
          ScaffoldMessenger.of(context).showSnackBar(
            
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text('Password is too weak', style: TextStyle(fontSize: 18),)));
        }
        else if(e.code=='email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text('Account already exsits', style: TextStyle(fontSize: 18),)));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                    Color(0xFFff5c30),
                    Color(0xFFe74b1a)
                  ])
        
                ),
              ),
              Container(
                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                height: MediaQuery.of(context).size.height/1.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  )
                ),
                child: Text(''),
              ),
              Container(
                margin: EdgeInsets.only(top: 60, left: 20,right: 20),
                child: Column(
                  
                  children: [
                  Center(child: Image.asset('images/logo.png', width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.cover,)),
                const SizedBox(height: 50,),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                  
                    ),
                    
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          Text('Sign up',style: AppWidget.textstyetype(),),
                          const SizedBox(height: 30,),
                           TextFormField(
                            controller: namecontroller,
                            validator: (value){
                              if(value==null || value.isEmpty ){
                                return 'Please Enter Name ';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: AppWidget.lightsemitextstyetype(),
                              prefixIcon: Icon(Icons.person_outlined)
                            ),
                      
                      
                          ),
                           const SizedBox(height: 30,),
                          TextFormField(
                            controller: mailcontroller,
                            validator: (value){
                              if(value==null || value.isEmpty ){
                                return 'Please Enter E-mail';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: AppWidget.lightsemitextstyetype(),
                              prefixIcon: Icon(Icons.email_outlined)
                            ),
                          ),
                          const SizedBox(height: 30,),
                          TextFormField(
                            controller: passwordcontroller,
                            validator: (value){
                              if(value==null || value.isEmpty ){
                                return 'Please Enter Password ';
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: AppWidget.lightsemitextstyetype(),
                              prefixIcon: Icon(Icons.password_outlined)
                            ),
                          ),
                          const SizedBox(height: 20,),
                         
                          const SizedBox(height: 80,),
                          GestureDetector(
                            onTap: () async{
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = mailcontroller.text;
                                  name = namecontroller.text;
                                  password = passwordcontroller.text;
                                });
                                
                              }
                              registration();
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                                    
                                  color: Color(0Xffff5722),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  
                  ),
                ),
                const SizedBox(height: 60,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> LogIn()));
                  },
                  child: Text("Already have an account? Login", style: AppWidget.lightsemitextstyetype(),))
                
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
} 