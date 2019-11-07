import 'package:flutter/material.dart';
import 'package:proto_pegas/components/rounded_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:proto_pegas/components/my_app_bar.dart';
import 'package:proto_pegas/screens/qr_screen.dart';
import 'package:proto_pegas/screens/info_screen.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({this.asset, this.url});
  static String id = 'webview_screen';
  final String asset;
  final String url;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController _controller;
//  'assets/terms.html'
  _loadHtmlFromAssets() async {
    if (widget.asset != null) {
      String fileText = await rootBundle.loadString(widget.asset);
      await _controller.loadUrl(Uri.dataFromString(fileText,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());
    } else if (widget.url != null) {
      await _controller.loadUrl(widget.url);
    } else {
      Navigator.pop(context);
    }
//    String fileText = await rootBundle.loadString(asset);
//    _controller.loadUrl(Uri.dataFromString(fileText,
//            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//        .toString());
  }

//  _loadURL(String url) {
//    _controller.loadUrl(url);
//  }

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 8),
            RoundedButton(
                title: 'Назад',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(width: 8),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Hero(
                  tag: 'logoPegas',
                  child: Container(
                    height: 50.0,
                    child: Image.asset('images/pegascard.png'),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('QR scan'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return QrScreen();
                        },
                      ),
                    );
                  });
                },
              ),
              ListTile(
                title: Text('Информация'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WebViewScreen(asset: 'assets/info.html');
                        },
                      ),
                    );
                  });
                },
              ),
              ListTile(
                title: Text('Актуални цени на горивата WEB'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WebViewScreen(
                            url:
                                'http://pegascard.com/%D0%B5%D0%BB%D0%B8%D0%BD-%D0%BF%D0%B5%D0%BB%D0%B8%D0%BD/%D1%86%D0%B5%D0%BD%D0%B8-%D0%B3%D0%BE%D1%80%D0%B8%D0%B2%D0%B0/',
                          );
                        },
                      ),
                    );
                  });
                },
              ),
              ListTile(
                title: Text('Политика за защита на личните данни WEB'),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WebViewScreen(
                            url:
                                'http://pegascard.com/%d1%82%d0%b5%d0%ba%d1%83%d1%89%d0%b8-%d0%bf%d1%80%d0%be%d0%bc%d0%be%d1%86%d0%b8%d0%b8/',
                          );
                        },
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
                initialUrl: '',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  _controller = webViewController;
                  await _loadHtmlFromAssets();
                }),
          ),
        ],
      ),
    );
  }
}
