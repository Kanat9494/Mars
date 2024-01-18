import 'package:flutter/material.dart';
import 'package:mars/second.dart';
import 'package:cached_network_image/cached_network_image.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 115.0,
            floating: true,
            backgroundColor: Colors.transparent,
            // backgroundColor:
            //     const Color.fromARGB(255, 22, 9, 206), // Розовый фон
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // Нижний левый угол
                bottomRight: Radius.circular(20.0), // Нижний правый угол
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 0, right: 0),
             centerTitle: true,
              title: Container(
                decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 22, 9, 206),
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(20), // Закругление левого нижнего угла
                bottomRight:
                    Radius.circular(20), // Закругление правого нижнего угла
              ),
            ),

               
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  const Text(
                    'Текст по середине',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск',
                        hintStyle: TextStyle(fontSize: 14.0),
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              )
            ),
          ),

          SliverFixedExtentList(
            itemExtent: 225,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                  height: 225,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int innerIndex) {
                      // print('First row $innerIndex');
        final item = popularItems[index % popularItems.length];
        return PopularItemCard(item: item);
                    }
                  ),
                );
              },
              childCount: 1,
            ),

),
          const SliverToBoxAdapter(child: const SizedBox(height: 10.0),),
          SliverPadding(
  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
  sliver: SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 5,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
      mainAxisExtent: 355.0
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        // print(index);
        //final itemIndex = index % allItems3.length; // Handle index overflow
        final item = allItems3[index];
      
        return MarketplaceItemCard(item: item);
      },
      childCount: 1000, // Display 1000 elements
    ),
  ),
  
),
        ],
      ),
     floatingActionButton:  Container(
          width: double.infinity, // Растягиваем на всю ширину
          padding: EdgeInsets.symmetric(horizontal: 16.0), // Произвольные отступы по бокам
          child: FloatingActionButton(
            onPressed: () {
              // Handle button press
            },
            backgroundColor: const Color.fromARGB(255, 22, 9, 206),
            tooltip: 'Increment',
            child: const Text('В корзину', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class MarketplaceItemCard extends StatelessWidget {
  final Item item;

  const MarketplaceItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//     return Container(
//   margin: const EdgeInsets.all(3.0),
//   decoration: BoxDecoration(
//             color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
//   child: Stack(
//     children: [
//       Column(
//           children: <Widget>[
//             AspectRatio(
//               aspectRatio: 1.0,
             
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: CachedNetworkImage(
//                   imageUrl: item.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
              
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               item.name,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 4.0),
//             Text(
//               item.category ?? "Нет",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 4.0),
//             Text(
//               item.additionalInfo ?? "Нет",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),

//          Positioned.fill(
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10.0),
//                   splashColor:
//                       Colors.grey.withOpacity(0.4), // Цвет волны при нажатии
//                   highlightColor: Colors.grey.withOpacity(0.3),
//                   splashFactory: InkRipple.splashFactory,
//                   onTap: () {
//                     Future.delayed(Duration.zero, () {
//                       if (!context.mounted) return;
//                       Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               const SliverPage(),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                       );
//                     });
//                   },
//                 ),
//               ),
//             )
//     ],
//   ),
// );


return Container(
  margin: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0)),
  child: Stack(
    children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
             
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                ),
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
              item.additionalInfo ?? "Нет",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            MaterialButton(
  onPressed: () {},
  color: const Color.fromARGB(255, 22, 9, 206),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Указываете радиус закругления
  ),
  child: const Text('В корзину', style: TextStyle(color: Colors.white)),
)
          ],
        ),

         Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  splashColor:
                      Colors.grey.withOpacity(0.4), // Цвет волны при нажатии
                  highlightColor: Colors.grey.withOpacity(0.3),
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {

                    // Future.delayed(Duration.zero, () {
                    //   if (!context.mounted) return;
                    //   Navigator.push(
                    //     context,
                    //     PageRouteBuilder(
                    //       pageBuilder: (context, animation1, animation2) =>
                    //           const SliverPage(),
                    //       transitionDuration: Duration.zero,
                    //       reverseTransitionDuration: Duration.zero,
                    //     ),
                    //   );
                    // });
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const SliverPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                  },
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
  final String? category; // Made 'category' parameter optional with '?'
  final String? additionalInfo; // Made 'additionalInfo' parameter optional with '?'
  final String price;

  Item({
    required this.imageUrl,
    required this.name,
    this.category, // Updated to make it optional
    this.additionalInfo, // Updated to make it optional
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
          onTapDown: (details){},
        onTap: (){},
        // borderRadius: BorderRadius.circular(10.0),
        
        child: Column(
        children: <Widget>[
            Ink.image(
              image: NetworkImage(
              item.imageUrl,
            ),


            
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
              color: Colors.white, // Изменение цвета текста на белый
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            item.price,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white, // Изменение цвета текста на белый
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
      ),

//       child: InkWell(
//   onTap: () {
//     // Обработчик при касании (поднимите соответствующий код обработки здесь)
//     print('Tapped');
//   },
//   onTapDown: (details) {
//     // Обработчик при касании экрана
//     print('Tapped Down');
//     // Вызовите свой код обработки, если это необходимо
//   },
//   highlightColor: Colors.transparent, // Устанавливаем прозрачный цвет ряби
//   child: Column(
//     children: <Widget>[
//       Ink.image(
//         image: NetworkImage(item.imageUrl),
//         height: 120,
//         width: 120,
//         fit: BoxFit.cover,
//       ),
//       const SizedBox(height: 16.0),
//       Text(
//         item.name,
//         style: const TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//       const SizedBox(height: 4.0),
//       Text(
//         item.price,
//         style: const TextStyle(
//           fontSize: 14.0,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
// )






      )
    );
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