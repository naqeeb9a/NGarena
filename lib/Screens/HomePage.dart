import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:phonearena/Data/data.dart';
import 'package:phonearena/Screens/DetailPage.dart';
import 'package:phonearena/Screens/SpecsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var textSize = 0.04;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // drawer: Drawer(child: drawerItems(size, context, textSize)),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                giveSpace(size, 0.03),
                giveSideText(
                    "Phones of the year", context, size, textSize, false),
                giveSpace(size, 0.033),
                imageCarousal(context, topPhoneData, size, 0.25),
                giveSpace(size, 0.03),
                giveSideText("Best Deals", context, size, textSize, true),
                giveSpace(size, 0.03),
                verticalPhoneCards(context, size, bestDealPhoneData, 0.2, 0.27),
                giveSpace(size, 0.03),
                giveSideText("Camera Phones", context, size, textSize, true),
                giveSpace(size, 0.03),
                verticalPhoneCards(context, size, bestCameraPhones, 0.2, 0.27),
                giveSpace(size, 0.03),
                giveSideText(
                    "Big Battery Phones", context, size, textSize, true),
                giveSpace(size, 0.03),
                verticalPhoneCards(context, size, bigBatteryPhones, 0.2, 0.27),
                giveSpace(size, 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget giveSpace(size, value) {
  return SizedBox(
    height: size.height * value,
  );
}

Widget imageCarousal(context, items, size, length) {
  return CarouselSlider(
      items: items.map<Widget>((i) {
        return Container(
          height: size.height * length,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecsPage(
                              phoneName: i["name"],
                              phoneImage: i["imageUrl"],
                              phoneSpecLink: i["phoneLink"],
                            )),
                  );
                },
                child: Container(
                  height: size.height * 0.2,
                  child: CachedNetworkImage(
                      imageUrl: i["imageUrl"].toString(),
                      errorWidget: (context, url, error) => Container()),
                ),
              ),
              Container(
                child: Text(i["name"]),
              )
            ],
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: size.height * length,
        initialPage: 0,
        autoPlay: true,
        aspectRatio: 2.0,
      ));
}

Widget giveSideText(text, context, size, textSize, iconVisible) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.width * textSize)),
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        text: text,
                      )));
        },
        child: Icon(
          Icons.arrow_forward_ios,
          size: size.width * textSize,
          color: (iconVisible == true) ? Colors.black : Colors.white,
        ),
      )
    ],
  );
}

Widget verticalPhoneCards(context, size, imageData, heightLength, widthLenght) {
  var dataLength;
  if (imageData.length > 5) {
    dataLength = 5;
  } else {
    dataLength = imageData.length;
  }
  return Container(
    height: size.height * heightLength,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataLength,
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
                              phoneName: imageData[index]["name"],
                              phoneImage: imageData[index]["imageUrl"],
                              phoneSpecLink: imageData[index]["phoneLink"],
                            )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: size.height * (heightLength - 0.05),
                  width: size.width * widthLenght,
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: imageData[index]["imageUrl"],
                    errorWidget: (context, url, error) => Container(),
                  ),
                ),
              ),
              Container(child: Text(imageData[index]["name"]))
            ],
          );
        }),
  );
}

Widget drawerCategoriesCards(size, text, imageUrl) {
  return Stack(children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.3,
        color: Colors.transparent,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => Container(),
          fit: BoxFit.cover,
        ),
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.3,
        color: Colors.black38,
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
      ),
    ),
  ]);
}

Widget drawerItems(size, context, textSize) {
  return SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            giveSpace(size, 0.03),
            Text(
              "Phone Arena",
              style: TextStyle(fontSize: size.width * 0.06),
            ),
            giveSpace(size, 0.05),
            giveSideText("All categories", context, size, textSize, false),
            giveSpace(size, 0.05),
            Container(
              height: size.height * 0.45,
              width: size.width * 0.6,
              child: GridView.builder(
                  itemCount: drawerCategoryCardsData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 6,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return drawerCategoriesCards(
                        size,
                        drawerCategoryCardsData[index]["name"],
                        drawerCategoryCardsData[index]["imageUrl"]);
                  }),
            )
          ],
        ),
      ),
    ),
  );
}
