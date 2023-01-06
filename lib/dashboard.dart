import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_delivery_app/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<DeliveryApp> getdata() async {
    String response = await rootBundle.loadString('assets/produk.json');
    final deliveryApp = deliveryAppFromJson(response);
    return deliveryApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101525),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/svg/top.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 83,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Your Location',
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Color(0xffF2994A),
                                ),
                                Text(
                                  'The current location is unknown',
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xff111830),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/Vector.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff202538),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Text(
                            'Search',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 26.0, horizontal: 16),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage('assets/image/banner.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                FutureBuilder<DeliveryApp>(
                  future: getdata(),
                  builder: (context, snapshot) {
                    var item = snapshot.data;
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Text('Waiting')
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            child: ListView.builder(
                              itemCount: item!.category.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: item.category[index].title == 'All'
                                        ? const Color(0xffCDFF06)
                                        : const Color(0xff202538),
                                  ),
                                  child: Row(children: [
                                    item.category[index].image == 'null'
                                        ? const Text('')
                                        : SizedBox(
                                            height: 32,
                                            width: 32,
                                            child: Image(
                                              image: AssetImage(
                                                  item.category[index].image),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        item.category[index].title,
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 16,
                                            color: item.category[index].title ==
                                                    'All'
                                                ? const Color(0xff111830)
                                                : Colors.white),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          );
                  },
                ),
                FutureBuilder<DeliveryApp>(
                  future: getdata(),
                  builder: (context, snapshot) {
                    var item = snapshot.data;
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Text('waiting')
                        : Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                                mainAxisExtent: 250,
                              ),
                              itemCount: item!.produckList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                              height: 215,
                                              width: 159,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:
                                                            const Offset(0, 4),
                                                        blurRadius: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.4))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color:
                                                      const Color(0xff202538)),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0),
                                                      child: Text(
                                                        '${item.produckList[index].price}\$',
                                                        style: GoogleFonts
                                                            .vazirmatn(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 36,
                                                        width: 56,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          16),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          16)),
                                                          color:
                                                              Color(0xffCDFF06),
                                                        ),
                                                        child: SvgPicture.asset(
                                                            'assets/svg/Vector.svg',
                                                            color: const Color(
                                                                0xff202538),
                                                            fit: BoxFit
                                                                .scaleDown))
                                                  ],
                                                ),
                                              ))),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: 159,
                                          height: 195,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 120,
                                                  width: 120,
                                                  child: Image(
                                                    image: AssetImage(item
                                                        .produckList[index]
                                                        .image),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.produckList[index]
                                                          .menuName,
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          item
                                                              .produckList[
                                                                  index]
                                                              .rating
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xffF2C94C),
                                                          size: 16,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  item.produckList[index]
                                                      .description,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.vazirmatn(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
