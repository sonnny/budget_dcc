//
// flutter app for dcc station March 16, 2024
// https://github.com/pico-cs/firmware
// text send from button press from protocol
//   - protocol https://github.com/pico-cs/firmware/blob/main/protocol.md
//
// develop on Linux Ubuntu - -22.04.4 LTS
// Flutter version - 3.19.3 channel stable
// Dart - 3.3.1
// DevTools - 2.31.1
//
// to create the app:
//   flutter create dcc_app --empty
//   cd dcc_app
//   flutter pub add get
//   flutter pub add wheel_chooser
//   flutter pub add syncfusion_flutter_sliders
//   
// services is used to exit app SystemNavigator.pop()
//
// plugin used for this app:
//   wheel_chooser is used for the horizontal slider
//   syncfusion sliders is used for the vertical slider
//   get is used to update the status from the pico w

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:get/get.dart';
import './source.dart';
import './tcp_controller.dart';
import './my_button.dart';

void main() { runApp(MyApp()); }

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);
  @override Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'main',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: MainApp());}}


class MainApp extends StatefulWidget {
const MainApp({Key? key}):super(key: key);
@override
State<MainApp> createState() => _MyApp(); }

class _MyApp extends State<MainApp>{
_MyApp();

final myController = TextEditingController();
double speed = 0.0;
String address = ' ';

void updateAddress(a) {
  setState(() {
    address = a.toString();});}
    
void updateSpeed(s) {
  setState(() {
    speed = s;});}

@override
Widget build(BuildContext context) {

final TcpController tcp = Get.put(TcpController());

return Scaffold(
resizeToAvoidBottomInset:false, //prevents overflow when touch keypad pops on the screen

appBar: AppBar(title: const Text('DCC demo'),
  actions: [
    IconButton(icon: const Icon(Icons.settings),
      onPressed:(){ Get.to(Source());}),
      
    IconButton(icon: const Icon(Icons.lightbulb),
      onPressed:() { Get.isDarkMode
        ? Get.changeTheme(ThemeData.light())
        : Get.changeTheme(ThemeData.dark());})]),

body: 
      
Column(children: [SizedBox(height:10.0),

Text('enter picow ip address and press connect'),
SizedBox(height:20.0),

////////////////////////// row ip text field connect button
Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children:[
SizedBox(width: 200, child: TextField(controller: myController,
            decoration: InputDecoration(border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20),
              labelText: 'pico w ip address'),
            style: TextStyle(fontSize: 20))),
            
SizedBox(width:10.0),          
ElevatedButton(child: Text('connect'), onPressed:(){tcp.connect(myController.text);}),
]),

SizedBox(height:20.0),

////////////////////// row loco address text and horizontal slider
Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:[
  Text('loco address:'),
  SizedBox(width:10.0),
  SizedBox(height:50.0, width:250,
            child: WheelChooser.integer(onValueChanged:(s) => updateAddress(s),
            maxValue: 99, minValue: 1, initValue: 30, horizontal: true,
            magnification: 1.5, selectTextStyle: TextStyle(color: Colors.red),
            unSelectTextStyle: TextStyle(color: Colors.green)))]),  
            
SizedBox(height:30.0),

//////////// begin row of column of buttons, vertical slider, more buttons
Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  
  ///////////// left side of row (column of buttons)
  Expanded(child: Container(height: 300.0, 
    child: Column(children: [
      MyButton(title: 'power on', data: '+mte t'),
      MyButton(title: 'dir', data: '+ld ' + address + ' ~'),
      IconButton(icon: const Icon(Icons.stop_circle_rounded), color: Colors.red, iconSize: 50.0,
        onPressed:(){ tcp.send('+ls ' + address + ' 0'); }),
    ]))),
   
  //////////////// middle of row (vertical slider for speed)
  Expanded(child: Container(height: 300.0,
    child: SfSlider.vertical(
      min: 0.0,
      max: 100.0,
      value: speed,
      interval: 20,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      onChanged: (dynamic value) { updateSpeed(value); }))),
    
   ////////////// right side of row (column of buttons)
   Expanded(child: Container(height: 200.0,
      child: Column(children: [
        MyButton(title: 'send speed', data: '+ls ' + address + ' ' + speed.toInt().toString()),
        MyButton(title: 'temp', data: '+t'),
      ]))),      
      
]), //////////// end row of column of buttons, vertical slider, more buttons
      
SizedBox(height: 10.0),

// nice to see what the picow sends back
Obx(() => Text('received: ${tcp.dataReceived.value}')),

SizedBox(height:10.0),

ElevatedButton(child: Text('quit'), onPressed:(){SystemNavigator.pop();}),
         
]));}}

