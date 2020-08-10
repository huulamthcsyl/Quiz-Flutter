import 'package:flutter/material.dart';
import 'package:quiz/helpers/functions.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/views/home.dart';
import 'package:quiz/views/signup.dart';
import '../widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((value){
        if(value != null){
          setState(() {
            _isLoading = false;
          });
          // HelperFunctions.saveUserLoggedInDetail(isLoggedIn: true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home(),
            )
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : 
      Form( 
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Enter email' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  return value.isEmpty ? 'Enter password' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  signIn();
                },
                child: blueButton(context: context, label: 'Sign in')
              )
              ,
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have a account? ", style: TextStyle(fontSize: 15),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignUp(),
                        )
                      );
                    },
                    child: Text('Sign Up', style: TextStyle(fontSize: 15, decoration: TextDecoration.underline,))
                  )
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      )
    );
  }
}