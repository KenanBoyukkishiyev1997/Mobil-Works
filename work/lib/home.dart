import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movie_ui/movie_ui.dart';
import './model/movie.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  final List movies = [
    "Avatar",
    "I Am Legend",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade900,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: <Widget>[
              movieCard(movieList[index], context),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        movie.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 17),
                      )),
                      Text(
                        'Rating: ${movie.imdbRating} / 10',
                        style: mainTextStyle(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Released: ${movie.released}',
                          style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle())
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListViewDetails(
                      movieName: movie.title,
                      movie: movie,
                    )))
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15, color: Colors.grey);
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl ??
                  'https://images-na.ssl-images-amazon.com/images/S/abs-image-upload-na/a/AmazonStores/ATVPDKIKX0DER/93063bdd178d46e55dd73b73571fd2f4.w400.h400._CR0,0,400,400_SX640_.jpg'),
              fit: BoxFit.cover)),
    );
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails({Key key, this.movieName, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies ${this.movieName}'),
          backgroundColor: Colors.grey.shade900,
        ),
        body: ListView(
          children: <Widget>[
            MovieDetailsThumbnail(
              thumbnail: movie.images[1],
            ),
            MovieDetailsHeaderWithPoster(
              movie: movie,
            ),
            HorizontalLine(),
            MovieDetailsCast(movie: movie,),
            HorizontalLine(),
            MovieDetailsExtraPosters(posters: movie.images,)
          ],
        ));
  }
}


