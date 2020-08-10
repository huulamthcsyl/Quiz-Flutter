import 'package:flutter/material.dart';
import 'package:quiz/services/databse.dart';
import 'package:quiz/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  AddQuestion({this.quizId});
  
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _keyForm = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService db = new DatabaseService();

  bool _isLoading = false;

  uploadQuestionData() async {
    if(_keyForm.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
      };

      await db.addQuestionData(questionMap, widget.quizId).then((value) {
        setState(() {
          _isLoading = false;
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
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
        ) : 
        Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              validator: (value) => value.isEmpty ? 'Enter question' : null,
              decoration: InputDecoration(
                hintText: 'Question'
              ),
              onChanged: (value) => question = value,
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Enter option 1' : null,
              decoration: InputDecoration(
                hintText: 'Option 1 (Correct answer)'
              ),
              onChanged: (value) => option1 = value,
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Enter option 2' : null,
              decoration: InputDecoration(
                hintText: 'Option 2'
              ),
              onChanged: (value) => option2 = value,
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Enter option 3' : null,
              decoration: InputDecoration(
                hintText: 'Option 3'
              ),
              onChanged: (value) => option3 = value,
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Enter option 4' : null,
              decoration: InputDecoration(
                hintText: 'Option 4'
              ),
              onChanged: (value) => option4 = value,
            ),
            Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: blueButton(context: context, label: 'Submit', buttonWidth: MediaQuery.of(context).size.width / 2 - 30)
                ),
                SizedBox(width: 16,),
                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                  },
                  child: blueButton(context: context, label: 'Add', buttonWidth: MediaQuery.of(context).size.width / 2 - 30)
                ),
              ],
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}