import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greetings_and_wishes/utils/ad_helper.dart';
import 'package:share_plus/share_plus.dart';

class MessageDataScreen extends StatefulWidget {
  const MessageDataScreen({Key? key, required this.title, required this.itemDataList}) : super(key: key);

  final String title;
  final List itemDataList;

  @override
  State<MessageDataScreen> createState() => _MessageDataScreenState();
}

class _MessageDataScreenState extends State<MessageDataScreen> {

  BannerAd? _bannerAd;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Container(
              child: Icon(Icons.arrow_back, color: Colors.white,)
            ),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
        title: Text(widget.title),
      ),
      body: SafeArea(
        bottom: false,
        child: listDataWidget(),
      ),
    );
  }

  Widget listDataWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.itemDataList.isNotEmpty
            ? Expanded(
          child: ListView.separated(
            itemCount: widget.itemDataList.length,
            separatorBuilder: (context, index) {
              if ((index + 1) % 2 == 0) {
                return Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                );
              } else {
                return Container();
              }
            },
            itemBuilder: (context, index) {
              return Container(
                key: new Key(index.toString()),
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow:[BoxShadow(color: Colors.black.withOpacity(0.07), offset: Offset(1, 1), spreadRadius: 0.5, blurRadius: 10.0)],
                ),
                child: Column(
                    children :[
                      Text(widget.itemDataList[index]["message"], style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'fonts/ubunturegular.ttf'),),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Container(
                                  child: Icon(Icons.copy, color: Colors.black,)
                              ),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: widget.itemDataList[index]["message"]));
                              // copied successfully
                            },),
                          SizedBox(width: 15.0,),
                          IconButton(
                            icon: Container(
                                child: Icon(Icons.share, color: Colors.black,)
                            ),
                            onPressed: () {
                              Share.share(widget.itemDataList[index]["message"]);
                            },),
                        ],
                      )
                    ]
                ),
              );
            },
          ),
        )
            : Container()
      ],
    );
  }


}