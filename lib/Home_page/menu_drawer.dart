import 'package:boaz/Home_page/AboutUs.dart';
import 'package:boaz/Home_page/clear%20database.dart';
import 'package:boaz/auth_page/login.dart';
import 'package:flutter/material.dart';
import 'package:boaz/constants.dart';
import 'package:boaz/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boaz/Home_page/export_to_csv.dart';


class MainDrawer extends StatefulWidget {
  final String eyu;
  final String first_name;
  final String Last_name;
  final String certifi;
  MainDrawer(@required this.eyu, @required this.first_name, @required this.Last_name,
      @required this.certifi,
      {Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState(eyu, first_name, Last_name, certifi);
}

class _MainDrawerState extends State<MainDrawer> {
  final String eyu;
  final String first_name;
  final String Last_name;
  final String certifi;
  _MainDrawerState(@required this.eyu,
      @required this.first_name, @required this.Last_name, @required this.certifi,);

  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: kPrimaryColor,
        width: double.infinity,
        //MediaQuery.of(context).platformBrightness ==
          //  Brightness.light ? kPrimaryColor :kSecondaryColor,

        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/images/1.jpeg"),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${first_name} ${Last_name} (${certifi})",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                eyu,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24,)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {_showAlertDialog("Add Label Name",
            "Your request send Successfully.");},
        leading: Icon(
          Icons.category,
          color: Colors.black,
        ),
        title: Text("Add Category"),
      ),

      ListTile(
        onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>clearData(eyu))),
        leading: Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: Text("Clear Database"),
      ),

      ListTile(
        onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>researchRequest(eyu))),
        leading: Icon(
          Icons.assessment,
          color: Colors.black,
        ),
        title: Text("Export to CSV"),
      ),
      Divider(color: Colors.blueGrey.shade400,
        thickness: 2,),

      Text("Personal"),

      ListTile(
        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AboutUS())),
        leading: Icon(
          Icons.account_box,
          color: Colors.black,
        ),
        title: Text("About Us"),
      ),
      ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute
          (builder: (context)=>LogInPage())),
        leading: Icon(
          Icons.account_circle_outlined,
          color: Colors.black,
        ),
        title: Text("Log Out"),
      ),
    ]);
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Enter Your new class'),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: Text('Save'),
            onPressed: () {
              items.add(textEditingController.text);
              Navigator.pop(context);
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then(
            (value) => Navigator.of(context).push(MaterialPageRoute
              (builder: (context)=>LogInPage())));
  }


}

