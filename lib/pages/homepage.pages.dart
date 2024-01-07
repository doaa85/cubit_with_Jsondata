import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:closure_task6/models/ad.models.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();

  var sliderIndex = 0;
  List<Ad> adsList = [];
  Ad ad = Ad();

  late final String image;

  void getAds() async {
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);

    adsList = List<Ad>.from(dataDecoded.map((e) => Ad.fromjson(e)));
    setState(() {});
  }

  @override
  void initState() {
    getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'my home page',
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(children: [
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800)),
                carouselController: buttonCarouselController,
                items: adsList.map((i) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(ad.image!))),
                      child: Text(
                        'text $i',
                        style: const TextStyle(fontSize: 16.0),
                      ));
                }).toList(),
              ),
              DotsIndicator(
                dotsCount: adsList.length,
                position: sliderIndex,
                onTap: (position) async {
                  await buttonCarouselController.animateToPage(position);
                  sliderIndex = position;
                  setState(() {});
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(300, 75, 0, 0),
            child: FloatingActionButton(
              onPressed: () => buttonCarouselController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              child: const Text('>'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 75, 0, 0),
            child: FloatingActionButton(
              onPressed: () => buttonCarouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              child: const Text('<'),
            ),
          )
        ]));
  }
}
