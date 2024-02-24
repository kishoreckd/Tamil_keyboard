import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF080808),
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Color(0XFFE9ECF1)), // Set the back icon color

        backgroundColor: const Color(0XFF080808),
        title: const Text(
          'உதவி',
          style:
              TextStyle(color: Color(0XFFE9ECF1), fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const Column(
            children: [
              Text(
                'தமிழ் விசைப்பலகை',
                style: TextStyle(
                    color: Color(0XFFE9ECF1),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Column(
                children: [
                  Image.network(
                    'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg',
                    height: 200.0, // You can adjust the height as needed
                  ),
                  const SizedBox(height: 16.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'தமிழில் எளிதாக தட்டச்சு செய்யலாம்',
                        style: TextStyle(
                            color: Color(0XFFE9ECF1),
                            fontWeight: FontWeight.w600),
                      ),
                      // const Text(
                      //   'முதலில் த வை அழுத்தவும் பிறகு ஒலி தட்டச்சு செய்யவும் ',
                      //   style: TextStyle(fontSize: 16.0),
                      // ),
                    ],
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 300.0, // You can adjust the height as needed
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                // Handle page change if needed
              },
            ),
          ),
          const SizedBox(height: 16.0),
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Your help content goes here. Add your detailed content, instructions, or any other information you want to provide.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          CarouselIndicator(
            count: 3,
            index: 0,
            activeColor: Colors.blue, // Customize the active indicator color
            // inactiveColor: Colors.grey, // Customize the inactive indicator color
          ),
        ],
      ),
    );
  }
}
