import 'package:flutter/material.dart';
import 'package:quiz/services/databse.dart';
import 'package:quiz/views/add_question.dart';
import 'package:quiz/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _keyForm = GlobalKey<FormState>();
  String quizImgUrl, quizTitle, quizDescription, quizId;
  DatabaseService db = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if(_keyForm.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        'quizID': quizId,
        'quizImgUrl': quizImgUrl,
        'quizTitle': quizTitle,
        'quizDescription': quizDescription
      };

      await db.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AddQuestion(quizId: quizId),
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _keyForm,
        child: _isLoading ? Container(
          child: Center(child: CircularProgressIndicator(),),
        ) :
         Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter image URL' : null,
                decoration: InputDecoration(
                  hintText: 'Quiz Image URL (Optional)'
                ),
                onChanged: (value) => quizImgUrl = value,
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter image URL' : null,
                decoration: InputDecoration(
                  hintText: 'Quiz Title'
                ),
                onChanged: (value) => quizTitle = value,
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter image URL' : null,
                decoration: InputDecoration(
                  hintText: 'Quiz Description'
                ),
                onChanged: (value) => quizDescription = value,
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  createQuizOnline();
                },
                child: blueButton(context: context, label: 'Create Quiz')
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}