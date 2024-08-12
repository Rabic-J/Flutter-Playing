import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/pages/details.dart';
import 'package:flutter_application_1/services/user_api.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> items = [];
  int selectedValue = 0;
  final isDialOpen = ValueNotifier(false);
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    fetchItems();
  }

  bool isDescending = true;
  bool searching = false;
  String radioSorter = "Name";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (isDialOpen.value) {
          isDialOpen.value = false;
        }
      },
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: cusSearchBar,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          //backgroundColor: Colors.amber,
          //overlayColor: Colors.purpleAccent,
          spacing: 12,
          spaceBetweenChildren: 5,
          openCloseDial: isDialOpen,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.filter_alt),
              label: 'Filter',
            ),
            SpeedDialChild(
              child: const Icon(Icons.sort),
              label: 'Sort',
              onTap: () => showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder:
                      (BuildContext context, StateSetter setSheetState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const Text('Sort order:'),
                            TextButton.icon(
                                onPressed: () =>
                                    setSheetState(() => setState(() {
                                          isDescending = !isDescending;
                                        })),
                                icon: const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(Icons.compare_arrows, size: 28),
                                ),
                                label: Text(
                                    isDescending ? 'Decending' : 'Ascending')),
                            const Text('Sort on:'),
                            Row(
                              children: [
                                Radio(
                                  value: "Name",
                                  groupValue: radioSorter,
                                  onChanged: (value) {
                                    setSheetState(() => setState(() {
                                          radioSorter = value!;
                                        }));
                                  },
                                ),
                                const Text("Name")
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "Email",
                                  groupValue: radioSorter,
                                  onChanged: (value) {
                                    setSheetState(() => setState(() {
                                          radioSorter = value!;
                                        }));
                                  },
                                ),
                                const Text("Email")
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            SpeedDialChild(
              child: const Icon(Icons.search),
              label: 'Search',
              onTap: () => setState(() {
                cusSearchBar = SizedBox(
                  width: 350 > MediaQuery.of(context).size.width * 0.6
                      ? 350
                      : MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        hintText: "Search",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        filled: false,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        prefixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          color: Theme.of(context).colorScheme.tertiary,
                          onPressed: () {},
                          icon: const Icon(Icons.search_rounded),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            if (controller.text.isEmpty) {
                              cusSearchBar = const Text("Home");
                              searching = false;
                            } else {
                              controller.clear();
                            }
                          }),
                          icon: const Icon(Icons.close_rounded),
                        )),
                  ),
                );
                searching = true;
              }),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(child: buildItems(items)),
          ],
        ),
      ));

  Widget cusSearchBar = const Text("Home");

//Makes the list cards
  Widget buildItems(List<User> items) {
    //Search results
    items = items.where((user) {
      return user.fullName
          .toLowerCase()
          .contains(controller.text.toLowerCase());
    }).toList();

    //sort results
    items = sortUsers(items);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(item: item),
                ),
              );
            },
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(item.url),
              backgroundColor: Colors.amber,
            ),
            title: Text(item.fullName),
            subtitle: Text(item.email),
            //selectedColor: getImagePalette (NetworkImage(item.url))
          ),
        );
      },
    );
  }

//sorts user list with radioSorter
  List<User> sortUsers(List<User> items) {
    if (radioSorter == "Name") {
      final sortedItems = items
        ..sort((item1, item2) => isDescending
            ? item1.fullName.compareTo(item2.fullName)
            : item2.fullName.compareTo(item1.fullName));
      return sortedItems;
    } else if (radioSorter == "Email") {
      final sortedItems = items
        ..sort((item1, item2) => isDescending
            ? item1.email.compareTo(item2.email)
            : item2.email.compareTo(item1.email));
      return sortedItems;
    }
    return items;
  }

//fetches items from web
  Future<void> fetchItems() async {
    final responce = await UserApi.fetchUsers();
    setState(() {
      items = responce;
    });
  }



// Calculate dominant color from ImageProvider
Future<Color> getImagePalette (ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator = await PaletteGenerator
      .fromImageProvider(imageProvider);
  final color = paletteGenerator.dominantColor?.color??Theme.of(context).colorScheme.secondary;
  return color;
}
}


