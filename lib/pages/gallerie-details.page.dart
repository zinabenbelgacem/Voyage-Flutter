import 'package:flutter/material.dart';
import 'home.page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GallerieDetailsPage extends StatefulWidget {
  final TextEditingController pays;

  GallerieDetailsPage({Key? key, required this.pays}) : super(key: key);

  @override
  _GallerieDetailsPageState createState() => _GallerieDetailsPageState();

}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage = 1;
  int size = 10;
  List<dynamic> hits = [];
  dynamic galleryData;
  ScrollController _scrollController = ScrollController();
  int totalPages = 0;
  String cityName = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    cityName = widget.pays.text;
    GetGalleryData(cityName);
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Charger la page suivante
      currentPage++;
      if (currentPage <= totalPages) {
        GetGalleryData(cityName);
      }
    }
  }

  void GetGalleryData(String keyword) {
    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=$keyword&page=$currentPage&per_page=$size";

    http.get(Uri.parse(url)).then((resp) {
      if (resp.statusCode == 200) {
        setState(() {
          galleryData = json.decode(resp.body);
          if (galleryData['totalHits'] % size == 0) {
            totalPages = galleryData['totalHits'] ~/ size;
          } else {
            totalPages = (galleryData['totalHits'] ~/ size) + 1;
          }
          hits.addAll(galleryData['hits']);
          print(hits);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '$cityName, page $currentPage/$totalPages';
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          galleryData == null
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: hits.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                     margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          hits[index]['tags'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Image.network(
                      hits[index]['webformatURL'],
                      fit: BoxFit.cover,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
