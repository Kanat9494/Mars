import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  double _bottomBarHeight = 60.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar();
      } else {
        showBottomBar();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void showBottomBar() {
    setState(() {
      _bottomBarHeight = 60;
    });
  }

  void hideBottomBar() {
    setState(() {
      _bottomBarHeight = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255),
        systemNavigationBarDividerColor: Color.fromARGB(0, 255, 255, 255),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color.fromARGB(110, 0, 0, 0),
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
        backgroundColor: const Color.fromARGB(235, 236, 235, 235),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
              toolbarHeight: 100.0,
              floating: true,
              backgroundColor: const Color.fromARGB(255, 22, 9, 206),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              title: SizedBox(
                height: 110.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Location text',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 6.0),
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(fontSize: 22.0),
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                padding: const EdgeInsets.all(16.0),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Popular goods",
                    style: TextStyle(
                      fontSize: 20.0, // Увеличение размера шрифта на 20
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Изменение цвета текста на черный
                    ),
                  ),
                ),
              ),
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              sliver: SliverFixedExtentList(
                itemExtent: 255,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      height: 225,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 100,
                          itemBuilder: (BuildContext context, int innerIndex) {
                            // print('First row $innerIndex');
                            final item =
                                popularItems[index % popularItems.length];
                            return PopularItemCard(item: item);
                          }),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                  ),
                  items: [
                    '1.jpg',
                    '2.jpg',
                    '3.jpg',
                    '4.jpg',
                    '5.jpg',
                    '6.jpg',
                  ].map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/$imagePath'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                padding: const EdgeInsets.all(16.0),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Popular shops",
                    style: TextStyle(
                      fontSize: 20.0, // Увеличение размера шрифта на 20
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Изменение цвета текста на черный
                    ),
                  ),
                ),
              ),
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              sliver: SliverFixedExtentList(
                itemExtent: 255,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SizedBox(
                      height: 225,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 100,
                          itemBuilder: (BuildContext context, int innerIndex) {
                            // print('First row $innerIndex');
                            final item =
                                popularItems[index % popularItems.length];
                            return PopularItemCard(item: item);
                          }),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10.0),
            ),
            SliverToBoxAdapter(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/12.jpg',
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
              ),
            )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10.0,
              ),
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              sliver: SliverPadding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 1.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = popularItems[index % popularItems.length];
                        return Container(
                          height: 90.0,
                          decoration: BoxDecoration(
                            color: (index == 0 || index == 9)
                                ? Colors.orange[300]
                                : Colors.purple[100 * (index % 9)],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                height: 70,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 4.0,
                                      left: 5.0), // Отступы сверху и снизу
                                  child: Text(
                                    'Lorem ipsum isdf oisdfewlk leorem was lorem',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              SizedBox(
                                width: 70,
                                height: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: item.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 10,
                    ),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10.0),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                padding: const EdgeInsets.all(16.0),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "All",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              sliver: SliverPadding(
                padding:
                    const EdgeInsets.only(right: 8.0, left: 8.0, top: 20.0),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 2.0,
                    mainAxisExtent: 370.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return MarketplaceItemCard(item: allItems3[index]);
                  },
                  itemCount: 1000,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _bottomBarHeight,
              child: child,
            );
          },
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 35), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined, size: 35),
                  label: '')
            ],
          ),
        ));
  }
}

class MarketplaceItemCard extends StatelessWidget {
  final Item item;

  const MarketplaceItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item.category ?? "Нет",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item.additionalInfo ?? "No",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: MaterialButton(
                  onPressed: () {},
                  color: const Color.fromARGB(255, 22, 9, 206),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Указываете радиус закругления
                  ),
                  child: const Text('Add to cart',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                splashColor: const Color.fromARGB(85, 0, 0, 0),
                highlightColor: const Color.fromARGB(0, 0, 0, 0),
                splashFactory: InkRipple.splashFactory,
                radius: 250.0,
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Item {
  final String imageUrl;
  final String name;
  final String? category;
  final String? additionalInfo;
  final String price;

  Item({
    required this.imageUrl,
    required this.name,
    this.category,
    this.additionalInfo,
    required this.price,
  });
}

final List<Item> allItems3 = List.generate(
  1000,
  (index) => Item(
    imageUrl: 'https://picsum.photos/id/${index % 10 + 1}/200/300',
    name: 'Item $index',
    category: 'Category $index',
    additionalInfo: 'Info $index',
    price: '\$${index + 1}',
  ),
);

class PopularItemCard extends StatelessWidget {
  final Item item;

  const PopularItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 16.0, top: 26.0),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.transparent,
          child: InkResponse(
            splashFactory: InkRipple.splashFactory,
            containedInkWell: true,
            onTapDown: (details) {},
            onTap: () {},
            // borderRadius: BorderRadius.circular(10.0),

            child: Column(
              children: <Widget>[
                Ink.image(
                  image: const AssetImage('assets/images/12.jpg'),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ));
  }
}

final List<Item> popularItems = [
  Item(
    imageUrl: 'https://picsum.photos/id/1/200/300',
    name: 'Item 1',
    price: '\$10',
  ),
  Item(
    imageUrl: 'https://picsum.photos/id/2/200/300',
    name: 'Item 2',
    price: '\$15',
  ),
  Item(
    imageUrl: 'https://picsum.photos/id/3/200/300',
    name: 'Item 3',
    price: '\$20',
  ),
];
