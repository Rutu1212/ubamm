import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List dataList = [];
  String imagePath = 'assets/images/';
  String imageNo = 'imgContent2.png';

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/guidance.json');
    final data = await json.decode(response);
    dataList = data;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dataList.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dataList[index]['type'] == 'image'
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10, top: 10),
                                  child: SizedBox(width: double.infinity, child: Image.asset("$imagePath$imageNo")),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 5),
                                  child: Text(
                                    dataList[index]['data'],
                                    style: TextStyle(
                                      color: dataList[index]['type'] == 'title'
                                          ? Colors.cyanAccent
                                          : dataList[index]['type'] == 'paragraph'
                                              ? Colors.white
                                              : null,
                                      fontWeight: dataList[index]['type'] == 'title' ? FontWeight.bold : null,
                                      fontSize: dataList[index]['type'] == 'title'
                                          ? 19
                                          : dataList[index]['type'] == 'paragraph'
                                              ? 19
                                              : null,
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                    itemCount: dataList.length,
                  ),
                )
              : const Center(
                  child: Text('No Data'),
                ),
        ],
      ),
    );
  }
}
