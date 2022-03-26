import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phonearena/Data/data.dart';

import 'SpecsPage.dart';

class DetailPage extends StatefulWidget {
  final text;
  DetailPage({Key? key, required this.text}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.text,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Expanded(child: check(widget.text, context, size))
            ],
          ),
        ),
      ),
    );
  }
}

Widget check(name, context, size) {
  if (name == "Best Deals") {
    return horizontalPhoneCards(context, size, bestDealPhoneData, 0.2, 0.27);
  } else if (name == "Camera Phones") {
    return horizontalPhoneCards(context, size, bestCameraPhones, 0.2, 0.27);
  } else if (name == "Big Battery Phones") {
    return horizontalPhoneCards(context, size, bigBatteryPhones, 0.2, 0.27);
  } else {
    return Center(
      child: Container(
        child: Text("An Error occured plz try again"),
      ),
    );
  }
}

Widget horizontalPhoneCards(context, size, data, heightL, widthL) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 6,
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecsPage(
                              phoneName: data[index]["name"],
                              phoneImage: data[index]["imageUrl"],
                              phoneSpecLink: data[index]["phoneLink"],
                            )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: size.height * (heightL - 0.05),
                  width: size.width * widthL,
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: data[index]["imageUrl"],
                    errorWidget: (context, url, error) => Container(),
                  ),
                ),
              ),
              Container(child: Text(data[index]["name"]))
            ],
          );
        }),
  );
}
