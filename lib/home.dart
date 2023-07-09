import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Crypto> cryptoList = [];

  @override
  void initState() {
    getInfo();
    getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xfff3f3f3),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Image.asset("assets/icon.png"),
          title: const Text(
            "قیمت ارز",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 25, 0),
                child: Row(
                  children: [
                    Image.asset("assets/icon2.png"),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "نرخ ارز ازاد چیست",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.all(12),
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xff828282),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "نام ارز",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "قیمت",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "تغییر",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              cryptoList.isEmpty
                  ? SizedBox(
                      width: size.width,
                      height: size.height / 2,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      width: size.width,
                      height: size.height / 2,
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cryptoList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: size.width,
                            height: 55,
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                  color:
                                      const Color(0xff707070).withOpacity(0.5),
                                  blurRadius: 2,
                                ),
                              ],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(1000),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cryptoList[index].title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cryptoList[index].price,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cryptoList[index].changes,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: cryptoList[index].status == "p"
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              Container(
                width: size.width,
                height: 55,
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xffe8e8e8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1000),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getInfo();
                        getTime();
                      },
                      child: Container(
                        width: size.width / 3,
                        decoration: const BoxDecoration(
                          color: Color(0xffcac1ff),
                          borderRadius: BorderRadius.all(
                            Radius.circular(1000),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset("assets/icon3.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "به روز رسانی",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "اخرین به روز رسانی",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        getTime(),
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTime() {
    DateTime newTime = DateTime.now();
    String hour = newTime.hour.toString();
    String minute = newTime.minute.toString();
    return "${hour.padLeft(2, "0")} : ${minute.padLeft(2, "0")}";
  }

  Future<void> getInfo() async {
    setState(
      () {
        cryptoList.clear();
      },
    );
    Uri url = Uri.parse(
      "https://sasansafari.com/flutter/api.php?access_key=flutter123456",
    );
    var response = await http.get(url);
    List json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (cryptoList.isEmpty) {
        for (var i = 0; i < json.length; i++) {
          setState(() {
            cryptoList.add(
              Crypto.formMapJson(json[i]),
            );
          });
        }
      }
    }
  }
}
