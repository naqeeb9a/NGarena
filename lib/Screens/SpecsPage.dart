import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpecsPage extends StatefulWidget {
  String phoneName;
  String phoneImage;
  String phoneSpecLink;
  SpecsPage(
      {Key? key,
      required this.phoneName,
      required this.phoneImage,
      required this.phoneSpecLink})
      : super(key: key);

  @override
  _SpecsPageState createState() => _SpecsPageState();
}

class _SpecsPageState extends State<SpecsPage> {
  var phoneSpecs;
  var phoneData;
  var phoneDataCounter = 0;
  bool isLoading = true;
  bool isLoadingError = false;
  fetchData() async {
    try {
      // print("okaaayy");
      var response = await http.get(Uri.parse(widget.phoneSpecLink));
      var jsonData = jsonDecode(response.body);
      phoneSpecs = jsonData["data"]["specifications"];
      // print(phoneSpecs);
    } catch (e) {
      setState(() {
        isLoadingError = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isLoading == true)
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : (isLoadingError == true)
              ? Scaffold(
                  appBar: AppBar(
                    leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        )),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: Center(
                    child: Container(
                      child: Text(
                          "Server busy try again later or check your internet"),
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      pinned: true,
                      leading: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                      expandedHeight: MediaQuery.of(context).size.height * 0.45,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          "Specifications",
                          style: TextStyle(color: Colors.black),
                        ),
                        centerTitle: true,
                        background: CachedNetworkImage(
                          imageUrl: widget.phoneImage,
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      phoneData = phoneSpecs[index]["specs"];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  phoneSpecs[index]["title"] + " :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                for (var i = 0; i < phoneData.length; i++)
                                  Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(phoneData[i]["key"].toString()),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(phoneData[i]["val"][0]
                                              .toString()))
                                    ],
                                  )),
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      );
                    }, childCount: phoneSpecs.length))
                  ],
                ),
    );
  }
}
