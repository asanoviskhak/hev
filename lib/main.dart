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
    final List<Movie> readingList = Movie.getMovies();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        title: Text("Movies List"),
      ),
      body: Container(
        //margin: const EdgeInsets.only(left: 3.0, top:6.0, right: 3.0),
        child: ListView.builder(
            itemCount: readingList.length,
            itemBuilder: (BuildContext context, int index){
              return Stack(
                children:<Widget>[
                  readingCard(readingList[index], context),
                  Positioned(
                    top: 10,
                      child: readingImage(readingList[index].images[1])),
                ],);
                /*child: Card(
                  borderOnForeground: false,
                  semanticContainer: false,
                  shadowColor: Colors.transparent,
                  //elevation: 4.5,
                  margin: const EdgeInsets.only(left: 20.0, top:20.0, right: 20.0, bottom:12.0),
                  color: Colors.grey[850],
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 15.0, right:10.0, bottom: 15.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Container(
                            width:200,
                            height: 200,
                            decoration: BoxDecoration(
                               color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      title:  Center(
                        child: Text(
                              readingList.elementAt(index).readingName,
                              style:
                              TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white
                              ),),
                      ),
                      trailing: CircleAvatar(
                        child: Container(
                          width:200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      onTap:(){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder:(context) => ReadingListViewDetails(
                                  readingTitle: readingList.elementAt(index).readingName,
                                  reading: readingList.elementAt(index),

                                )));
                      },
                      //onTap: ()=> debugPrint("We are viewing: ${readings.elementAt(index)}"),
                    ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(3.0, 3.0),
                            blurRadius: 9.0,
                            spreadRadius: 0.8),
                        BoxShadow(
                            color: Colors.grey[800],
                            offset: Offset(-3.0, -3.0),
                            blurRadius: 9.0,
                            spreadRadius: 0.8),
                      ]),
                  ),
                ),
              */
          }
        ),
      ),

    );
  }
  Widget readingCard(Movie reading, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 50.0),
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 40.0, right: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(reading.title,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),),
                      ),
                      Text("Duration: ${reading.runtime}",
                      style: mainTextStyle(),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Rating: ${reading.imdbRating}/10",
                            style: mainTextStyle(),
                        ),
                      Text("Release: ${reading.released}",
                          style: mainTextStyle(),
                          )
                    ],
                  ),
                ]
              ),
            ),
          )
        )
      ),
      onTap:() {
        Navigator.push(context,
          MaterialPageRoute(
          builder:(context) => ReadingListViewDetails(
          readingTitle: reading.title,
          reading: reading, )));
      },
    );
  }

  Widget readingImage(String imgUrl){
    return Container(
      width: 80,
        height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              imgUrl ?? 'https://www.quranicthought.com/wp-content/uploads/2018/04/cropped-pgt-logo-270x270.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
///new Route
class ReadingListViewDetails extends StatelessWidget{
  final String readingTitle;
  final Movie reading;

  const ReadingListViewDetails({Key key, this.readingTitle, this.reading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.readingTitle}"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          readingListThumbnail(thumbnail: reading.images[0]),
          MovieHeaderWithPoster(movie: reading),
          HorizontalLine(),
          MovieDetailsCast(movie: reading),
          HorizontalLine(),
          MovieDetailsImages(images: reading.images),
        ],
      ),
//      body: Center(
//        child: Container(
//          child: RaisedButton(
//            child: Text("Back"),
//            onPressed: (){
//              Navigator.pop(context);
//            },
//          ),
//        ),
//      ),
    );
  }
}

// ignore: camel_case_types
class readingListThumbnail extends StatelessWidget{
  final String thumbnail;
  const readingListThumbnail({Key key, this.thumbnail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Icon(Icons.play_circle_filled, size: 80, color: Colors.white),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00), Colors.grey[850]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 120,
        ),
      ],
    );
  }
}

class MovieHeaderWithPoster extends StatelessWidget{
  final Movie movie;

  const MovieHeaderWithPoster({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieHeader(movie: movie)
          )
        ],
      )
    );
  }
}

class MovieHeader extends StatelessWidget{
  final Movie movie;
  const MovieHeader({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${movie.year}. ${movie.genre}".toLowerCase(),
          style: linkTextStyle(),
        ),
        Text( movie.title, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
        ),
        Text.rich(TextSpan(style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text:movie.plot
          ),
          TextSpan(
            text: " More...",
            style: linkTextStyle(),
          )
        ]

        ))
      ],
    );
  }
}
class MoviePoster extends StatelessWidget{
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      )
    );
  }
}

class MovieDetailsCast extends StatelessWidget{
  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Column(
        children: <Widget>[
          MovieField(field: "Language", value: movie.language),
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director(s)", value: movie.director),
          MovieField(field: "Country", value: movie.country),
          MovieField(field: "Awards", value: movie.awards),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget{
  final String field, value;
  const MovieField({Key key, this.field, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field : ", style: TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          height: 1.5,
        ),),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}


class HorizontalLine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Container(
        height: 0.5,
        color: Colors.white24,
      ),
    );
  }
}

class MovieDetailsImages extends StatelessWidget {
  final List<String> images;

  const MovieDetailsImages({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            "More Images from movie".toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.only(top: 10, left: 4),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8,),
              itemCount: images.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width/3,
                height:100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}






TextStyle mainTextStyle(){
  return TextStyle(
      fontSize: 12.0,
      color: Colors.white60
  );
}
TextStyle linkTextStyle(){
  return TextStyle(
      fontSize: 12.0,
      color: Colors.white54,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400
  );
}