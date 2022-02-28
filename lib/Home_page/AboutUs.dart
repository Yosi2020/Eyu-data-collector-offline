import 'package:boaz/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({Key key}) : super(key: key);

  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {

  launchurl1() async{
    final url = "https://walaict.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }

  launchurl2() async{
    final url = "https://deboengineering.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl3() async{
    final url = "mailto:dagmawi@walaict.com";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl4() async{
    final url = "mailto:boazict@gmail.com";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl5() async{
    final url = "mailto:eyosimar524@gmail.com";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl6() async{
    final number = "+251911086178";
    await launch("tel://$number");
  }
  launchurl7() async{
    final number = "+25197118898";
    await launch("tel://$number");
  }
  launchurl8() async{
    final number = "+251913135813";
    await launch("tel://$number");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 2, bottom: 0, left: 5, right: 5
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  avatar: GFAvatar(
                    backgroundImage: AssetImage("assets/images/image_2022-02-11_22-45-13.png"),
                  ),
                  title: Text('Image Data Collector For AI', style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22
                  ),),
                  subTitleText: '@debo_engineering',
                ),
                content: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.info_sharp),
                      title: Text("Version"),
                      subtitle: Text("3.1"),
                    ),
                  ],
                ),
              ),
              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  title: Text('Developers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                content: Column(
                  children: [
                    GFListTile(
                      avatar: GFAvatar(
                        backgroundColor: Colors.black12,
                        backgroundImage: AssetImage(
                            "assets/images/color_debo.png"
                        ),
                      ),
                      title: Text("Debo Engineering"),
                      subTitleText: '@Boaz_B & @Jermi_B',
                    ),
                    GFListTile(
                      avatar: GFAvatar(
                        backgroundColor: Colors.white70,
                        backgroundImage: AssetImage("assets/images/wala.png"),
                      ),
                      title: Text("Wala ICT"),
                    )
                  ],
                ),
              ),
              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  title: Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                content: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Debo Engineering"),
                      subtitle: Text('boazict@gmail.com'),
                      onTap: ()=>launchurl4(),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Wala ICT"),
                      subtitle: Text("dagmawi@walaict.com"),
                      onTap: ()=>launchurl3(),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Eyosiyas Tibebu"),
                      subtitle: Text("eyosimar524@gmail.com"),
                      onTap: ()=>launchurl5(),
                    )
                  ],
                ),
              ),
              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  title: Text('Website', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                content: Column(
                  children: [
                    ListTile(
                      leading: Icon(FontAwesome.globe),
                      title: Text("Debo Engineering"),
                      subtitle: Text('deboengineering.com'),
                      onTap: ()=>launchurl2(),
                    ),
                    ListTile(
                      leading: Icon(FontAwesome.globe),
                      title: Text("Wala ICT"),
                      subtitle: Text("https://walaict.com/"),
                      onTap: ()=>launchurl1(),
                    ),
                  ],
                ),
              ),

              GFCard(
                boxFit: BoxFit.cover,
                titlePosition: GFPosition.start,
                title: GFListTile(
                  title: Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                content: Column(
                  children: [
                    ListTile(
                      leading: Icon(FontAwesome.phone),
                      title: Text("Debo Engineering"),
                      subtitle: Text('+251911086178'),
                      onTap: ()=>launchurl6(),
                    ),
                    ListTile(
                      leading: Icon(FontAwesome.phone),
                      title: Text("Wala ICT"),
                      subtitle : Text("+25197118898 | +251905556045"),
                      onTap: ()=>launchurl7(),
                    ),
                    ListTile(
                      leading: Icon(FontAwesome.phone),
                      title: Text("Eyosiyas Tibebu"),
                      subtitle: Text("+251913135813"),
                      onTap: ()=>launchurl8(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
    );
  }
}
