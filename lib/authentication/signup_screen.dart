import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healnet/methods/common_methods.dart';
import 'package:healnet/authentication/login_screen.dart';
import 'package:healnet/widgets/loading_dialog.dart';
import 'package:healnet/pages/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController userphoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvailable()
  {
    cMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation(){
    if(usernameTextEditingController.text.trim().length<4)
    {
      cMethods.displaySnackBar("Your name must have atleast 4 or more characters.", context);
    }
    else if(userphoneTextEditingController.text.trim().length<9)
    {
      cMethods.displaySnackBar("Please enter a valid phone number.", context);
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      cMethods.displaySnackBar("Please enter a valid email.", context);
    }
    else if(passwordTextEditingController.text.trim().length<6)
    {
      cMethods.displaySnackBar("Your name must have atleast 6 or more characters.", context);
    }
    else
    {
      registerNewUser();
    }
  }

  void registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
      const LoadingDialog(messageText: "Registering"),
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim()
      );

      final User? userFirebase = userCredential.user;

      if (!mounted) return;
      Navigator.pop(context);

      DatabaseReference usersRef = FirebaseDatabase.instance.ref()
          .child("users")
          .child(userFirebase!.uid);

      Map userDataMap =
      {
        "name": usernameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": userphoneTextEditingController.text.trim(),
        "id": userFirebase.uid,
        "blockStatus": "no",
      };

      usersRef.set(userDataMap);

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const HomePage()));
    } catch (errorMsg) {
      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
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

                    const Text(
                      'Create a user account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(22), 
                child: Column(
                  children: [

                    TextField(
                      controller: usernameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Username:",
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
                      controller: userphoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone number:",
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
                        "Sign Up"
                      ),)
                  ],
                ),
              ),
              
              TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
                }, 
                child: const Text(
                  "Already have an account? Log in here",
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