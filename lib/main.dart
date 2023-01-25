import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greetings_and_wishes/message_data_screen.dart';
import 'package:greetings_and_wishes/model/firebase_event_data_responce.dart';
import 'package:greetings_and_wishes/utils/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';


/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}*/

/*class MyMainPage extends StatelessWidget {
  const MyMainPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greetings and Wishes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}*/

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List _items = [];
  BannerAd? _bannerAd;

  // final databaseReference = FirebaseDatabase.instance.reference();

  Query dbRef = FirebaseDatabase.instance.ref().child('data');

  // Fetch content from the json file
  /*Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/file/datafile.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["data"]["category"];
    });
  }*/

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    // readJson();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Greetings'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

            // String eventData = jsonEncode(snapshot.value);

            final Map<String, dynamic> data = json.decode(jsonEncode(snapshot.value))[0];
            // List<dynamic> eventCategoryList = json.decode(jsonEncode(snapshot.value));
            // Category categoryItem = Category.fromJson(eventCategoryList[index]);
            debugPrint("Category Title  => ${data.toString()}");

            // eventData['key'] = snapshot.key;

            // _items = eventData['category'];

            // debugPrint("In Animation Builder === EventData ==>> ${eventData.toString()}");
            // debugPrint("In Animation Builder === eventData['key'] ==>> ${eventData['key'].toString()}");
            // debugPrint("In Animation Builder === _items ==>> ${eventData}");

            return Container(
              child: Text("text"),
            );

            /*return Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
              // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.black87, Colors.black54], begin: Alignment.topRight, end: Alignment.bottomLeft)),
              child: Column(
                  children:[
                    // TODO: Display a banner when ready
                    if (_bannerAd != null)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: _bannerAd!.size.width.toDouble(),
                          height: _bannerAd!.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd!),
                        ),
                      ),
                    _items.isNotEmpty ?
                    Expanded(
                      child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (3 / 2),
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20
                          ),
                          itemCount: _items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.teal, Colors.black54], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(5.0)),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => MessageDataScreen(
                                          title: _items[index]["title"],
                                          itemDataList: _items[index]["message"],
                                        ),
                                      ));
                                },
                                child: Card(
                                  key: ValueKey(_items[index]["id"]),
                                  // color: Colors.transparent,
                                  child: Center(
                                    child: Text(_items[index]["title"], style: TextStyle(color: Colors.black, fontSize: 19, fontFamily: 'fonts/merriweatherregular.ttf'),),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ) : Center(child: Text('No record', style: TextStyle(color: Colors.white),),),
                  ]),
            );*/
          },
        ),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Greetings and Wishes', textAlign: TextAlign.center,),backgroundColor: Colors.black,),
     // body: SingleChildScrollView(
     backgroundColor: Colors.black,
       body: Container(
         padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
         // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.black87, Colors.black54], begin: Alignment.topRight, end: Alignment.bottomLeft)),
         child: Column(
           children:[
             // TODO: Display a banner when ready
             if (_bannerAd != null)
               Align(
                 alignment: Alignment.topCenter,
                 child: Container(
                   width: _bannerAd!.size.width.toDouble(),
                   height: _bannerAd!.size.height.toDouble(),
                   child: AdWidget(ad: _bannerAd!),
                 ),
               ),
             _items.isNotEmpty ?
               Expanded(
                 child: GridView.builder(
                     physics: ScrollPhysics(),
                     shrinkWrap: true,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       childAspectRatio: (3 / 2),
                       mainAxisSpacing: 20,
                       crossAxisSpacing: 20
                     ),
                     itemCount: _items.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Container(
                         // decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.teal, Colors.black54], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(5.0)),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (BuildContext context) => MessageDataScreen(
                                     title: _items[index]["title"],
                                     itemDataList: _items[index]["message"],
                                   ),
                                 ));
                           },
                           child: Card(
                             key: ValueKey(_items[index]["id"]),
                             // color: Colors.transparent,
                             child: Center(
                               child: Text(_items[index]["title"], style: TextStyle(color: Colors.black, fontSize: 19, fontFamily: 'fonts/merriweatherregular.ttf'),),
                             ),
                           ),
                         ),
                       );
                     }),
               ) : Center(child: Text('No record', style: TextStyle(color: Colors.white),),),
         ]),
       ),
     // ),
   );
  }*/



}
