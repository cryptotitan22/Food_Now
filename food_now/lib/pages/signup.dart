import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_now/pages/bottomnav.dart';
import 'package:food_now/pages/login.dart';
import 'package:food_now/widget/widget_support.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email="", password="", name="";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();

  final _formkey= GlobalKey<FormState>();


  registration()async{
    if(password!=null){
      try{
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Registered Successfull", style: TextStyle(fontSize: 20.0),),)));






        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNav()));
      }on FirebaseException catch(e){
        if(e.code=='weak-password'){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("password provied is to week", style: TextStyle(fontSize: 18.0),),)));
        }
        else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Account Already exists", style: TextStyle(fontSize: 18.0),),)));
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5 ,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFff5c30),
                    Color(0xFFff5c30),
                  ]
              )
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(30))),
          child: const Text(""),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0 ),
          child: Column(children: [
            Center(child: Image(image: const AssetImage("images/logo.png"), width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.cover,)),
            const SizedBox(height: 50.0,),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.5,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                    Text(
                      "Sign Up",
                      style: AppWidget.headlineTextFeildStyle(),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value==null|| value.isEmpty){
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: AppWidget.semiBoldTextFeildStyle(),
                          prefixIcon: const Icon(Icons.person_outlined)),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: mailController,
                      validator: (value){
                        if(value==null|| value.isEmpty){
                          return 'Please Enter E-mail';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: AppWidget.semiBoldTextFeildStyle(),
                          prefixIcon: const Icon(Icons.email_outlined)),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),

                    TextFormField(
                      controller: passwordController,
                      validator: (value){
                        if(value==null|| value.isEmpty){
                        return 'Please Enter Password';}
                        return null;        },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: AppWidget.semiBoldTextFeildStyle(),
                          prefixIcon: const Icon(Icons.password_outlined)),
                    ),

                    const SizedBox(height: 80.0,),
                    GestureDetector(
                      onTap: ()async{
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mailController.text;
                            name= nameController.text;
                            password= passwordController.text;
                          });
                        }
                        registration();
                      },
                        child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          width: 200,
                          decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    )
                  ],),
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));
                },
                child: Text("Already have an account? Login", style: AppWidget.boldTextFeildStyle(),))
          ],),
        )
      ],),),
    );
  }
}
