import 'package:flutter/material.dart';
import 'package:quiz/services/auth.dart';
import 'package:quiz/views/home.dart';
import '../widgets/widgets.dart';
import './signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value){
        if(value != null){
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, 
            MaterialPageRoute(
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
      body: Form( 
        key: _formKey,
        child: _isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),
        ) : 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Enter correct name' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Name'
                ),
                onChanged: (value) {
                  name = value.toString().trim();
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (value) {
                  return value.isEmpty ? 'Enter correct email' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                onChanged: (value) {
                  email = value.toString().trim();
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  return value.isEmpty ? 'Enter correct password' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
                onChanged: (value) {
                  password = value.toString().trim();
                },
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  signUp();
                },
                child: blueButton(context: context, label: 'Sign Up')
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(fontSize: 15),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignIn(),
                        )
                      );
                    },
                    child: Text('Sign In', style: TextStyle(fontSize: 15, decoration: TextDecoration.underline,))
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