import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hev/model/readingList.dart';

void main() => runApp(
    new MaterialApp(
      home: ReadingListView(),
      theme: new ThemeData.dark(
      ),
      debugShowCheckedModeBanner: false,
    )
);

class ReadingListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final List<Reading> readingList = Reading.getReading();
    return Scaffold(
      appBar: AppBar(
        title: Text("Namaz Rehberi"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 3.0, top:6.0, right: 3.0),
        child: ListView.builder(
            itemCount: readingList.length,
            itemBuilder: (BuildContext context, int index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(32.0),
                child: Card(
                  elevation: 4.5,
                  color: Colors.blueGrey.shade800,
                  child: ListTile(
                    title: Center(
                        child:
                        Text(
                          readingList.elementAt(index).readingName,
                          style:
                          TextStyle(
                              fontSize: 26.0,
                              color: Colors.lightGreenAccent
                          ),)),
                    subtitle: Center(child: Text("${readingList.elementAt(index).description}")),
                    contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
                    onTap:(){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) => ReadingListViewDetails(
                                readingTitle: readingList.elementAt(index).readingName,
                              )));
                    },
                    //onTap: ()=> debugPrint("We are viewing: ${readings.elementAt(index)}"),
                  ),
                ),
              );
          }
        ),
      ),

    );
  }
}
///new Route
class ReadingListViewDetails extends StatelessWidget{
  final String readingTitle;

  const ReadingListViewDetails({Key key, this.readingTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.readingTitle}"),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Back"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}