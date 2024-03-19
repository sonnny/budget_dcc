// my_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import './tcp_controller.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final String? data;
  const MyButton({@required this.title, @required this.data});
  
  Widget build(BuildContext context){
  final TcpController tcp = Get.put(TcpController());
    return Expanded(child: Center( 
      child: ElevatedButton(child: Text(title??'empty'), onPressed:(){tcp.send(data??' ');})));}}
