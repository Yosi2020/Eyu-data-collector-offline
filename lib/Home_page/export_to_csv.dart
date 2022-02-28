import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:boaz/Home_page/homepage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boaz/DatabaseHandler/DataHelper.dart';
import 'package:boaz/model/dataInfo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:open_file/open_file.dart';


class researchRequest extends StatefulWidget {
  final String eyu;
  researchRequest(@required this.eyu,{Key key}) : super(key: key);

  @override
  _researchRequestState createState() => _researchRequestState(eyu);
}

class _researchRequestState extends State<researchRequest> {

  final String eyu;
  _researchRequestState(@required this.eyu);

  @override

  List<List<dynamic>> CollectedData;
  List researchList =[];

  DataHelper helper = DataHelper();
  List<dataInfo> dataList;
  int count = 0;

  void initState(){
    getData();
    helper.initializeDatabase().then((value){
      print("--------- database initialized");
    });
    buildItems(researchList);
    updateListView();
  }

  void getlist(){
    CollectedData  = List<List<dynamic>>.empty(growable: true);
    List<dynamic> row1 = List.empty(growable: true);
    row1.add("Date Time");
    row1.add("Email");
    row1.add("Image Name");
    row1.add("Label Name");
    row1.add("Longitude");
    row1.add("Latitude");
    CollectedData.add(row1);
    for (int i = 0; i <dataList.length; i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List.empty(growable: true);
      row.add(dataList[i].dateTime);
      row.add(dataList[i].email);
      row.add(dataList[i].image);
      row.add(dataList[i].Label_Name);
      row.add(dataList[i].Longitude);
      row.add(dataList[i].Latitude);
      CollectedData.add(row);
    }
  }

  bool loading = false;
  double progress = 0;
  File saveFile;

  getCsv() async {
    await getlist();

    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/DataCollector";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        String dir = (await directory.path + "/mycsv.csv");
        String file = "$dir";

        File f = new File(file);

        // convert rows to String and write as csv file

        String csv = const ListToCsvConverter().convert(CollectedData);
        f.writeAsString(csv).then((value) => _showAlertDialog("Image Data Collection for AI",
            "Your request send Successfully. You can get Your csv file \"internal Storage/DataCollector/mycsv.csv\""));
        await OpenFile.open(file);
      }

    }
    catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title : Text("Export to CSV Page"),
          centerTitle: true,
        ),
        body: Card(child: getBankListView(),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          getCsv();
        },
        label: const Text('Export to CSV'),
        icon: const Icon(Icons.cloud_download_outlined),
        backgroundColor: Colors.pink,),
    );
  }

  Widget buildItems(researchList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: researchList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        for(int k = 0; k<researchList.length; k++){
          if(researchList[k]["Email"] == "eyosimar524@gmail.com") {
            TextStyle titleStyle = Theme
                .of(context)
                .textTheme
                .subtitle1;
            return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person),
                ),
                title: Text("${researchList[k]["Email"]}", style: titleStyle,),
                subtitle: Text(researchList[k]["DateTime"]),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                onTap: () {}
            );
          }}});

  List libraryResearchList =[];

  final CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection("datacollected");

  Future getData() async{
    try{
      await _collectionRef.get().then((querySnapshot){
        for (var result in querySnapshot.docs){
          libraryResearchList.add(result.data());
        }
      });
      return libraryResearchList;
    } catch (e){
      debugPrint("Error -$e");
      return null;
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute
                (builder: (context) => HomePage(eyu)));
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }

  ListView getBankListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.photo_camera_outlined),
              ),
              title : Text(this.dataList[position].Label_Name.toString(), style: titleStyle,),
              subtitle: Text("Date " + this.dataList[position].dateTime.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap:(){ }
              ));},
            );
  }

  void updateListView(){
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database){

      Future<List<dataInfo>> bankListFuture = helper.getData();
      bankListFuture.then((dataList){
        setState(() {
          this.dataList = dataList;
          this.count = dataList.length;
        });
      });
    });
  }

}
