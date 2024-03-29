import 'package:boaz/DatabaseHandler/AuthDbHelper.dart';
import 'package:boaz/auth_page/login.dart';
import 'package:boaz/auth_page/new_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boaz/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  DbHelper dbHelper;
  @override
  void initState() {
    super.initState();
    //getUserData();

    dbHelper = DbHelper();
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController controlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                children: [
            Image.asset(
            MediaQuery.of(context).platformBrightness ==
                Brightness.light ? "assets/images/1.jpeg"
                : 'assets/images/4.jpg',
            height: 300,
          ),Container(
              padding: EdgeInsets.only(
                  top: 40.0, right: 50.0,
                  left: 50.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Forget Password",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Merriweather"
                    ),),
                  const SizedBox(height: 21.0,),
                  buildTextField(
                      title: "Email",
                      controller: controlEmail,
                      autoHint: "test@gmail.com",
                      size: MediaQuery.of(context).size.width/1.4,
                      match: r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}'),

                  SizedBox(height: 21.0,),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                          color: Colors.lightBlue,
                          onPressed: (){
                            final isValid = formKey.currentState.validate();

                            if (isValid) {
                              //login(controlEmail.text.trim());
                              forget();
                            }
                          },
                          child: Text("Reset password",
                            style: TextStyle(color: Colors.white),)),
                      FlatButton(
                          color: Colors.grey[600],
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancel",
                            style: TextStyle(color: Colors.white),)),
                    ],)
                ],
              ),
            ),
          ])
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    @required title,
    @required TextEditingController controller,
    int maxLines=1,
    @required String autoHint,
    @required size,
    @required match,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size, child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: autoHint,
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value.isEmpty || !RegExp(match).hasMatch(value))
                  return "Enter a correct " + title;
                else
                  return null;
              }
          ),
          )

        ],
      );

  final CollectionReference collectionRef =
  FirebaseFirestore.instance.collection("Create_Account");


  Future<void> login(String Email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
        email: Email)
        .then((value) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>LogInPage())
    ))
        .catchError((error) =>
        _showAlertDialog("Image Data Collection for AI",
            "Problem on sending Your request, please see your email."));
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LogInPage())
              );
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }

  forget() async {
    String uid = controlEmail.text;
    await dbHelper.getForgetUser(uid).then((userData) {
      if (userData != null) {
        setSP(userData).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => NewPassword()),
                  (Route<dynamic> route) => false);
        });
      } else {
        _showAlertDialog("Image Data Collection for AI",
            "Error: User Not Found");
      }
    }).catchError((error) {
      print(error);
      _showAlertDialog("Image Data Collection for AI",
          "Error: forget Fail");
    });
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

}
