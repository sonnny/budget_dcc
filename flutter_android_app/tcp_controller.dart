// tcp client

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class TcpController {
Socket? socket;
var dataReceived = ' '.obs;

void connect(ip) {
    Socket.connect(ip, 8080).then((Socket sock) {
      socket = sock;
      socket?.listen(
          dataHandler,
          onError: errorHandler,
          onDone: doneHandler,
          cancelOnError: false
      );
    });
  }
  
void errorHandler(error, StackTrace trace){
    print(error);
  }
  void doneHandler(){
    socket?.destroy();
  }
 void dataHandler(data){
   print(data);
   dataReceived.value = new String.fromCharCodes(data);
  } 
  
void send(msg) { print(msg);
  socket?.writeln(msg);}
  
}
