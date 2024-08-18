import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healnet/methods/common_methods.dart';
import 'package:healnet/authentication/signup_screen.dart';
import 'package:healnet/pages/home_page.dart';
import 'package:healnet/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable()
  {
    cMethods.checkConnectivity(context);
    signInFormValidation();
  }

  signInFormValidation(){
    if(!emailTextEditingController.text.contains("@"))
    {
      cMethods.displaySnackBar("Please enter a valid email.", context);
    }
    else if(passwordTextEditingController.text.trim().length<6)
    {
      cMethods.displaySnackBar("Your name must have atleast 6 or more characters.", context);
    }
    else
    {
      signInUser();
    }
  }

  signInUser() async
  {
    showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const LoadingDialog(messageText: "Logining in..."),
  );

  try {
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    );

    final User? userFirebase = userCredential.user;

    if (!mounted) return;
    Navigator.pop(context);

    if (userFirebase != null) {
      DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase.uid);
      userRef.once().then((snap)
      {
        if(snap.snapshot.value != null){
          if((snap.snapshot.value as Map)["blockStatus"]=="no"){
            Navigator.push(context, MaterialPageRoute(builder: (c) => const HomePage())); 
          }
          else{
            FirebaseAuth.instance.signOut();
            cMethods.displaySnackBar("Your are blocked!", context);         
          }
        }
        else{
          FirebaseAuth.instance.signOut();
          cMethods.displaySnackBar("Your record does not exist!", context);
        }
      }
    );
    }
  } catch (e) {
    Navigator.pop(context);
    cMethods.displaySnackBar(e.toString(), context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Center(
                child: Column(
                  children: [

                    Image.asset(
                      "assets/HealNet-removebg-preview.png",
                      width: 250,
                      height: 250,
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      'Log in as a user',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(22), 
                child: Column(
                  children: [

                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email:",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 22,),
                    
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        labelText: "Password:",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    
                    const SizedBox(height: 32,),

                    ElevatedButton(
                      onPressed: ()
                      {
                        checkIfNetworkIsAvailable();
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10)
                      ),
                      child: const Text(
                        "Login"
                      ),)
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignUpScreen()));
                }, 
                child: const Text(
                  "Don't have an account? Sign up here",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
