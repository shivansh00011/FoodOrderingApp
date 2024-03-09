import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zotato/admin/admin_login.dart';
import 'package:zotato/pages/bottomnavbar.dart';
import 'package:zotato/pages/forgotpassword.dart';
import 'package:zotato/pages/signup.dart';
import 'package:zotato/widgets/support_widgets.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}


class _LogInState extends State<LogIn> {
  
  String email="", password = "";
  final _formkey = GlobalKey<FormState>();
  TextEditingController useremailController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();

  userLogin() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNav()));
      
    } on FirebaseAuthException catch(e){
      if (e.code=='user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found with that email',style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),)));
        
      }else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong Password!',style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),)));
        

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
                height: MediaQuery.of(context).size.height/2,
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
                    height: MediaQuery.of(context).size.height/2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                  
                    ),
                    
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          Text('Login',style: AppWidget.textstyetype(),),
                          const SizedBox(height: 30,),
                          TextFormField(
                            controller: useremailController,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please Enter Email';
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
                            controller: userpasswordController,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please Enter Password';
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text('Forgot Password?', style: AppWidget.lightsemitextstyetype(),),
                              
                            ),
                          ),
                          const SizedBox(height: 80,),
                          GestureDetector(
                            onTap: (){
                              if(_formkey.currentState!.validate()){
                                setState(() {
                                  email = useremailController.text;
                                  password = userpasswordController.text;
                                });
                              }
                              userLogin();
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius:  BorderRadius.circular(20),
                              
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                                    
                                  color: Color(0Xffff5722),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  
                  ),
                ),
                const SizedBox(height: 70,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                  },
                  child: Text("Don't have an account? Sign up", style: AppWidget.lightsemitextstyetype(),)),

                  const SizedBox(height: 40,),
                  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminLogin()));
                  },
                  child: Text("Login as Admin", style: AppWidget.lightsemitextstyetype(),))
                
                ],),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}