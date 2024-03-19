/**************************
 * source.dart
 *************************/
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:get/get.dart';
import './code.dart';
import './dark_light.dart';

class Source extends StatelessWidget{
@override Widget build(BuildContext context) {

DarkLight dl = Get.put(DarkLight());


return Scaffold(
  appBar: AppBar(title: Text('Demo source'),
    actions:[
    IconButton(icon: const Icon(Icons.lightbulb),
    onPressed: dl.toggle)]),
         
  body: Column(children:[Container(
    height: MediaQuery.of(context).size.height * 0.80,
    child: Obx(() => SyntaxView(
      code: code,
      //syntax: Syntax.C,
      syntax: Syntax.DART,
      syntaxTheme: (dl.dark.value == 'OFF')
        ? SyntaxTheme.ayuLight()
        : SyntaxTheme.monokaiSublime(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
      expanded: true))),],),);}}
                  

/******** source.dart ******/
