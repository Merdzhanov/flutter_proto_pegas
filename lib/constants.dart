import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:proto_pegas/components/rounded_button.dart';
import 'package:proto_pegas/components/my_app_bar.dart';
import 'package:proto_pegas/screens/qr_screen.dart';
import 'package:proto_pegas/screens/webview_screen.dart';
import 'package:proto_pegas/screens/info_screen.dart';
import 'package:proto_pegas/screens/informed_screen.dart';
import 'dart:async';

//class Marker {
//  /// Creates a set of marker configuration options.
//  ///
//  /// Default marker options.
//  ///
//  /// Specifies a marker that
//  /// * is fully opaque; [alpha] is 1.0
//  /// * uses icon bottom center to indicate map position; [anchor] is (0.5, 1.0)
//  /// * has default tap handling; [consumeTapEvents] is false
//  /// * is stationary; [draggable] is false
//  /// * is drawn against the screen, not the map; [flat] is false
//  /// * has a default icon; [icon] is `BitmapDescriptor.defaultMarker`
//  /// * anchors the info window at top center; [infoWindowAnchor] is (0.5, 0.0)
//  /// * has no info window text; [infoWindowText] is `InfoWindowText.noText`
//  /// * is positioned at 0, 0; [position] is `LatLng(0.0, 0.0)`
//  /// * has an axis-aligned icon; [rotation] is 0.0
//  /// * is visible; [visible] is true
//  /// * is placed at the base of the drawing order; [zIndex] is 0.0
//  const Marker({
//    @required this.markerId,
//    this.alpha = 1.0,
//    this.anchor = const Offset(0.5, 1.0),
//    this.consumeTapEvents = false,
//    this.draggable = false,
//    this.flat = false,
//    this.icon = BitmapDescriptor.defaultMarker,
//    this.infoWindow = InfoWindow.noText,
//    this.position = const LatLng(0.0, 0.0),
//    this.rotation = 0.0,
//    this.visible = true,
//    this.zIndex = 0.0,
//    this.onTap,
//    this.onDragEnd,
//  }) : assert(alpha == null || (0.0 <= alpha && alpha <= 1.0));

//final BitmapDescriptor kMyGoogleIcon = BitmapDescriptor.fromAssetImage(
//    ImageConfiguration(size: Size(48, 48)), 'assets/pegascard.png');

//final Map<String, Marker> kGoogleLocationMarkers = {
//  'Test': Marker(
////    icon: kMyGoogleIcon,
//    markerId: MarkerId('Test'),
//    position: LatLng(42.3343766, 23.5582211),
//    infoWindow: InfoWindow(
//      title: 'Test',
//      snippet: 'Tochen adres',
//    ),
//  ),
//  'Test2': Marker(
////    icon: myIcon,
//    markerId: MarkerId('Test2'),
//    position: LatLng(42.3410701, 23.5473099),
//    infoWindow: InfoWindow(
//      title: 'Test2',
//      snippet: 'Tochen adres Test2',
//    ),
//  )
//};

//Обекти
//Собствени – на тези обекти можете да зареждате с карти тип „В брой”, „Дебитна” и „Кредитна”
//Гр. София – бензиностанция „Петрол – Суходол”, Околовръстен път, кв. “Суходол”, тел. 02/920 13 71;
//Гр. Ботевград – община Ботевград, област Софийска, бензиностанция „Пегас - Скравена”, път Е79, посока Мездра дясно, веднага след с.Скравена, тел. 07137/2018;
//Гр. Мездра – община Мездра, област Враца, бензиностанция “Пегас - Ребърково”, път Е79, посока Мездра ляво, с. Ребърково, тел. 09109/ 22 62;
//Гр. Елин Пелин – бензиностанция „Пегас – Елин Пелин”, бул. „Новоселци” №101, тел. 0725/66905;
//Гр.Велинград – бензиностанция „Пегас - Велинград”, гара Костандово, разклона гр.Велинград – с.Ракитово, тел. 0899 877 543;
//Гр.Брезник – община Перник, бензиностанция „Пегас - Брезник”, ул.”Андрей Михайлов”, срещу поделение на М.О. , тел. 0775/12181;
//
//Партньорски – на тези обекти можете да зареждате с карти тип, „Дебитна” и „Кредитна”
//Гр.София – бензиностанция „Весан”, кв.Казичене, ул.”Циклама”№1;
//Гр.София – бензиностанция “Теком”, бул.”Владимир Вазов” №402-ІІ, срещу Bauhaus
//Гр.София – бензиностанция “Данеста”, ул.”Медникарска” №1, срещу входа на София-Мел
//Гр.София – бензиностанция “Интерспийд”, ж.к.”Младост”, ул.”Георги Белов”№2
//Гр. Ихтиман – община Ихтиман, област Софийска, бензиностанция “Пегас - Ихтиман”, ул.”Цар Освободител” 199, тел. 0724/85956;
//Гр.Варна – бензиностанция „Еко Кар Газ”, ул.”Академик Андрей Сахаров” №3;
//Гр.Каспичан – бензиностанция „Ергос”, ул.”Мадарски конник”;
//Гр.Бургас – бензиностанция „Инс 2002”, ул.”Генерал Владимир Вазов”№2
//Гр.Пловдив – бензиностанция „Лем Инвест”, Околовръстен път, изход към с.Белащица
//Гр.Пловдив – бензиностанция „Лайт Комерс”, ул.”Рогошко шосе”№32
//Гр.Видин - бензиностанция “ТИП-2”, ул.”Пътя към ферибота”№1, GPS: 44.012768,
//Гр.Видин - бензиностанция “ТИП-3”, бул.”Панония”№120, GPS: 44.007424, 22.885409
//Гр.Русе – бензиностанция „Джи Ем Петрол”, бул.”Тутракан” №22, зад сградата на Филкаб
//Гр.София – бензиностанция „Омикс”, кв.Казичене, ул.”Фармапарк”№5
//Гр.Ямбол – бензиностанция „Омакс”, ул.”Индже Воевода”№29
//Гр.Велико Търново – бензиностанция „Газ Лоджистикс”, ул.”Стоян Михайловски”№6
//Гр. Стара Загора – бензиностанция „99 плюс”, ул.”Хан Аспарух”, изход за гр.Казанлък
//Гр.Плевен – бензиностанция „Спринт Ойл”, бул.”Българска авиация”№39
//Гр.Лясковец – бензиностанция „Мираж”, ул.”Стефан Калинов”№11
//Гр.Благоевград – бензиностанция „Варко”, ул.”Пейо Яворов”№2

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
