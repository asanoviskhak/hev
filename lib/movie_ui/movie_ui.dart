import 'package:flutter/material.dart';
import 'package:hev/model/readingList.dart';



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