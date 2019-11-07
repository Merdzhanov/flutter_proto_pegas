import 'package:flutter/material.dart';
import 'package:proto_pegas/components/rounded_button.dart';
import 'package:proto_pegas/components/my_app_bar.dart';
import 'package:proto_pegas/screens/qr_screen.dart';
import 'package:proto_pegas/screens/webview_screen.dart';
import 'package:proto_pegas/screens/info_screen.dart';
import 'package:proto_pegas/screens/informed_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MainMapScreen extends StatefulWidget {
  MainMapScreen({this.latitude, this.longitude});

  static String id = 'main_map_screen';

  final latitude;
  final longitude;

  @override
  _MainMapScreenState createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
//  Map<String, Marker> _markers;
  List<Marker> _markers = [];
  GoogleMapController controller;
  BitmapDescriptor _markerIcon;

//  Completer<GoogleMapController> _controller = Completer();
  double latitude;
  double longitude;
  LatLng _center;
  BitmapDescriptor myIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    BitmapDescriptor.fromAssetImage(
//            ImageConfiguration(size: Size(48, 48)), 'images/pegascard.png')
//        .then((onValue) {
//      myIcon = onValue;
//    });

    print('My Icon $myIcon');

//    _markers.addAll([
//      Marker(
//        icon: myIcon,
//        markerId: MarkerId('Test'),
//        draggable: false,
//        position: LatLng(42.3343766, 23.5582211),
//        onTap: () {
//          print('marker tapped');
//        },
//        infoWindow: InfoWindow(
//          title: 'Test',
//          snippet: 'Tochen adres',
//        ),
//      ),
//      Marker(
//        icon: myIcon,
//        markerId: MarkerId('Test2'),
//        draggable: false,
//        position: LatLng(42.3410701, 23.5473099),
//        infoWindow: InfoWindow(
//          title: 'Test2',
//          snippet: 'Tochen adres Test2',
//        ),
//      )
//    ]);

    updateUI(widget.latitude ?? 0.0, widget.longitude ?? 0.0);
  }

  void updateUI(dynamic latitudeData, dynamic longitudeData) {
    setState(() {
      latitude = latitudeData;
      longitude = longitudeData;
      _center = LatLng(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
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
                title: 'Информация',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InfoScreen();
                        },
                      ),
                    );
                  });
                }),
            RoundedButton(
                title: 'Вход',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return InformedScreen();
                        },
                      ),
                    );
                  });
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
//              ListTile(
//                title: Text('Политика за защита на личните данни WEB'),
//                onTap: () {
//                  setState(() {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return WebViewScreen(
//                            url:
//                                'http://pegascard.com/%d1%82%d0%b5%d0%ba%d1%83%d1%89%d0%b8-%d0%bf%d1%80%d0%be%d0%bc%d0%be%d1%86%d0%b8%d0%b8/',
//                          );
//                        },
//                      ),
//                    );
//                  });
//                },
//              ),
//              ListTile(
//                title: Text('10.0.2.2:3000'),
//                onTap: () {
//                  setState(() {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return WebViewScreen(
//                            url: 'http:/10.0.2.2:3000/',
//                          );
//                        },
//                      ),
//                    );
//                  });
//                },
//              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0))),
        child: Center(
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
//              (GoogleMapController controller) {
//              _controller.complete(controller);
//            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
//            markers: _markers..values.toSet(),
            markers: _createMarker(),
//            _markers.toSet(),
          ),
        ),
      ),
    );
  }

  Set<Marker> _createMarker() {
    // TODO(iskakaushik): Remove this when collection literals makes it to stable.
    // https://github.com/flutter/flutter/issues/28312
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Петрол – Суходол'),
        draggable: false,
        position: LatLng(42.691375, 23.230411),
        infoWindow: InfoWindow(
          title: 'Петрол – Суходол',
          snippet:
              'Гр. София – бензиностанция „Петрол – Суходол”, Околовръстен път, кв. “Суходол”, тел. 02/920 13 71;',
        ),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Пегас - Скравена'),
        draggable: false,
        position: LatLng(42.955644, 23.763007),
        infoWindow: InfoWindow(
          title: 'Пегас - Скравена',
          snippet:
              'Гр. Ботевград – община Ботевград, област Софийска, бензиностанция „Пегас - Скравена”, път Е79, посока Мездра дясно, веднага след с.Скравена, тел. 07137/2018',
        ),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Пегас - Ребърково'),
        draggable: false,
        position: LatLng(43.114744, 23.695549),
        infoWindow: InfoWindow(
            title: 'Пегас - Ребърково',
            snippet:
                'Гр. Мездра – община Мездра, област Враца, бензиностанция “Пегас - Ребърково”, път Е79, посока Мездра ляво, с. Ребърково, тел. 09109/ 22 62'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Пегас – Елин Пелин'),
        draggable: false,
        position: LatLng(42.6771666534, 23.6094978523),
        infoWindow: InfoWindow(
            title: 'Пегас – Елин Пелин',
            snippet:
                'Гр. Елин Пелин – бензиностанция „Пегас – Елин Пелин”, бул. „Новоселци” №101, тел. 0725/66905'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Пегас - Велинград'),
        draggable: false,
        position: LatLng(42.031576, 24.068074),
        infoWindow: InfoWindow(
            title: 'Пегас - Велинград',
            snippet:
                'Гр.Велинград – бензиностанция „Пегас - Велинград”, гара Костандово, разклона гр.Велинград – с.Ракитово, тел. 0899 877 543'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('Пегас - Брезник'),
        draggable: false,
        position: LatLng(42.738218, 22.916903),
        infoWindow: InfoWindow(
            title: 'Пегас - Брезник',
            snippet:
                'Гр.Брезник – община Перник, бензиностанция „Пегас - Брезник”, ул.”Андрей Михайлов”, срещу поделение на М.О. , тел. 0775/12181'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Весан”'),
        draggable: false,
        position: LatLng(42.663071, 23.452457),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Весан”',
            snippet:
                'Гр.София – бензиностанция „Весан”, кв.Казичене, ул.”Циклама”№1'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “Теком”'),
        draggable: false,
        position: LatLng(42.709187, 23.393611),
        infoWindow: InfoWindow(
            title: 'бензиностанция “Теком”',
            snippet:
                'Гр.София – бензиностанция “Теком”, бул.”Владимир Вазов” №402-ІІ, срещу Bauhaus'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “Данеста”'),
        draggable: false,
        position: LatLng(42.708468, 23.338702),
        infoWindow: InfoWindow(
            title: 'бензиностанция “Данеста”',
            snippet:
                'Гр.София – бензиностанция “Данеста”, ул.”Медникарска” №1, срещу входа на София-Мел'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “Интерспийд”'),
        draggable: false,
        position: LatLng(42.638583, 23.393462),
        infoWindow: InfoWindow(
            title: 'бензиностанция “Интерспийд”',
            snippet:
                'Гр.София – бензиностанция “Интерспийд”, ж.к.”Младост”, ул.”Георги Белов”№2'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “Пегас - Ихтиман”'),
        draggable: false,
        position: LatLng(42.428703, 23.826743),
        infoWindow: InfoWindow(
            title: 'бензиностанция “Пегас - Ихтиман”',
            snippet:
                'Гр. Ихтиман – община Ихтиман, област Софийска, бензиностанция “Пегас - Ихтиман”, ул.”Цар Освободител” 199, тел. 0724/85956'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Еко Кар Газ”'),
        draggable: false,
        position: LatLng(43.218772, 27.8982),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Еко Кар Газ”',
            snippet:
                'Гр.Варна – бензиностанция „Еко Кар Газ”, ул.”Академик Андрей Сахаров” №3'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Ергос”'),
        draggable: false,
        position: LatLng(43.312998, 27.152049),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Ергос”',
            snippet:
                'Гр.Каспичан – бензиностанция „Ергос”, ул.”Мадарски конник”'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Инс 2002”'),
        draggable: false,
        position: LatLng(42.473409, 27.440154),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Инс 2002”',
            snippet:
                'Гр.Бургас – бензиностанция „Инс 2002”, ул.”Генерал Владимир Вазов”№2'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Лем Инвест”'),
        draggable: false,
        position: LatLng(42.09382, 24.761901),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Лем Инвест”',
            snippet:
                'Гр.Пловдив – бензиностанция „Лем Инвест”, Околовръстен път, изход към с.Белащица'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Лайт Комерс”'),
        draggable: false,
        position: LatLng(42.163579, 24.772711),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Лайт Комерс”',
            snippet:
                'Гр.Пловдив – бензиностанция „Лайт Комерс”, ул.”Рогошко шосе”№32'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “ТИП-2”'),
        draggable: false,
        position: LatLng(44.012768, 22.898001),
        infoWindow: InfoWindow(
            title: 'бензиностанция “ТИП-2”',
            snippet:
                'Гр.Видин - бензиностанция “ТИП-2”, ул.”Пътя към ферибота”№1, GPS: 44.012768'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция “ТИП-3”'),
        draggable: false,
        position: LatLng(44.00742, 22.885409),
        infoWindow: InfoWindow(
            title: 'бензиностанция “ТИП-3”',
            snippet:
                'Гр.Видин - бензиностанция “ТИП-3”, бул.”Панония”№120, GPS: 44.007424, 22.885409'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Джи Ем Петрол”'),
        draggable: false,
        position: LatLng(43.866508, 25.990673),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Джи Ем Петрол”',
            snippet:
                'Гр.Русе – бензиностанция „Джи Ем Петрол”, бул.”Тутракан” №22, зад сградата на Филкаб'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Омикс”'),
        draggable: false,
        position: LatLng(42.664403, 23.456409),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Омикс”',
            snippet:
                'Гр.София – бензиностанция „Омикс”, кв.Казичене, ул.”Фармапарк”№5'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Омакс”'),
        draggable: false,
        position: LatLng(42.476093, 26.504082),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Омакс”',
            snippet:
                'Гр.Ямбол – бензиностанция „Омакс”, ул.”Индже Воевода”№29'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Газ Лоджистикс”'),
        draggable: false,
        position: LatLng(43.083762, 25.620391),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Газ Лоджистикс”',
            snippet:
                'Гр.Велико Търново – бензиностанция „Газ Лоджистикс”, ул.”Стоян Михайловски”№6'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „99 плюс”'),
        draggable: false,
        position: LatLng(42.452832, 25.630271),
        infoWindow: InfoWindow(
            title: 'бензиностанция „99 плюс”',
            snippet:
                'Гр. Стара Загора – бензиностанция „99 плюс”, ул.”Хан Аспарух”, изход за гр.Казанлък'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Спринт Ойл”'),
        draggable: false,
        position: LatLng(43.431191, 24.602201),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Спринт Ойл”',
            snippet:
                'Гр.Плевен – бензиностанция „Спринт Ойл”, бул.”Българска авиация”№39'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Мираж”'),
        draggable: false,
        position: LatLng(43.113263, 25.711884),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Мираж”',
            snippet:
                'Гр.Лясковец – бензиностанция „Мираж”, ул.”Стефан Калинов”№11'),
      ),
      Marker(
        icon: _markerIcon,
        markerId: MarkerId('бензиностанция „Варко”'),
        draggable: false,
        position: LatLng(42.000500, 23.108821),
        infoWindow: InfoWindow(
            title: 'бензиностанция „Варко”',
            snippet:
                'Гр.Благоевград – бензиностанция „Варко”, ул.”Пейо Яворов”№2'),
      ),
    ].toSet();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(10.0, 10.0));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'images/pegascard.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
