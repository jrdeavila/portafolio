import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var src =
    "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/pass/GoogleMapTA.jpg";

class MapsChangeNotificationListener extends StatefulWidget {
  const MapsChangeNotificationListener({super.key});

  @override
  State<MapsChangeNotificationListener> createState() =>
      _MapsChangeNotificationListenerState();
}

class _MapsChangeNotificationListenerState
    extends State<MapsChangeNotificationListener> {
  late DraggableScrollableController _controller;

  double percent = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    var topbarHeight = MediaQuery.of(context).size.height * 0.29;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              src,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              child: const Icon(Icons.menu),
            ),
          ),
          Positioned.fill(
            child: NotificationListener<DraggableScrollableNotification>(
                onNotification: ((notification) {
                  setState(() {
                    percent = (notification.extent - 0.3) / 0.5;
                  });
                  return true;
                }),
                child: _draggableWidget()),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: -topbarHeight * (1 - percent),
            height: topbarHeight,
            child: _SearchNavigationBar(),
          ),
        ],
      ),
    );
  }

  DraggableScrollableSheet _draggableWidget() {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      minChildSize: 0.3,
      initialChildSize: 0.3,
      builder: (context, scrollController) {
        return Material(
            elevation: 10,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 2,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "It's good to see you",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Where are you going?",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search, color: Colors.red),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      itemCount: 20,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text("Address: $index"),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class _SearchNavigationBar extends StatelessWidget {
  const _SearchNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                BackButton(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Choose Destination",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Where are you staying?",
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Where are you going?",
                border: InputBorder.none,
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
