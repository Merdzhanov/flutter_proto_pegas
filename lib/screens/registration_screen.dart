import 'package:flutter/material.dart';
import 'package:proto_pegas/components/rounded_button.dart';
import 'package:proto_pegas/components/input_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
//        SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logoPegas',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logoPegas.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Text('Моля попълнете коректно следните данни:'),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'Три имена/Наименование',
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'Адрес/само за юридическо лице/',
                maxLines: 3,
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'E-mail',
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'ЕИК/ЕГН',
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              Text(
                  'Моля, в случай че сте физическо лице и искате да получавате данъчна фактура, да въведете коректно своето ЕГН (това поле да не е задължитено за попълване)'),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'Данни  за фактура',
                maxLines: 3,
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              InputTextField(
                hintText: 'Парола',
                onChanged: (value) {
                  //Do something with the user input.
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () {
                    //Implement registration functionality.
                  })
            ],
          ),
        ),
      ),
    );
  }
}
