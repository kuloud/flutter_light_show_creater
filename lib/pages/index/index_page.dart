import 'package:flutter/material.dart';
import 'package:flutter_light_show_creator/pages/index/navigation_item.dart';
import 'package:flutter_light_show_creator/pages/music/library_music_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<NavigationItem> _railMenus = [
    NavigationItem(icon: const Icon(Icons.browse_gallery), label: 'Project'),
    NavigationItem(icon: const Icon(Icons.library_music), label: 'Music'),
    NavigationItem(icon: const Icon(Icons.auto_mode), label: 'Auto'),
    NavigationItem(icon: const Icon(Icons.create), label: 'Manual'),
    NavigationItem(icon: const Icon(Icons.movie), label: 'Dancing'),
  ];

  final List<NavigationItem> _bottomMenus = [
    NavigationItem(icon: const Icon(Icons.browse_gallery), label: 'Project'),
    NavigationItem(icon: const Icon(Icons.library_music), label: 'Music'),
    NavigationItem(icon: const Icon(Icons.auto_mode), label: 'Create'),
    NavigationItem(icon: const Icon(Icons.settings), label: 'Setting'),
  ];

  late List<NavigationItem> _menus;

  final List<Widget> _mainContents = [
    // Content for Home tab
    Container(
      color: Colors.yellow.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(fontSize: 40),
      ),
    ),
    const LibraryMusicPage(),
    // Content for Feed tab
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Feed',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Favorites tab
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Favorites',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Settings tab
    Container(
      color: Colors.pink.shade300,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    )
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 640) {
      _menus = _bottomMenus;
    } else {
      _menus = _railMenus;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                useLegacyColorScheme: false,
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: _menus
                    .map((e) =>
                        BottomNavigationBarItem(icon: e.icon, label: e.label))
                    .toList())
            : null,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Show the navigaiton rail if screen width >= 640
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                  // minWidth: 55.0,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  trailing: const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [Icon(Icons.settings), Text('Settings')],
                          ),
                        )
                      ],
                    ),
                  ),
                  destinations: _menus
                      .map((e) => NavigationRailDestination(
                          icon: e.icon, label: Text(e.label!)))
                      .toList()),

            Expanded(child: _mainContents[_selectedIndex]),
          ],
        ));
  }
}
