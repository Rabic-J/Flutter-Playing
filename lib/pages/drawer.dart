import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//import 'home.dart';
//import 'about.dart';
//import 'settings.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Drawer(
        width: MediaQuery.of(context).size.width*0.7,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.primary,
              child: SvgPicture.asset(
                themeProvider.getTheme == 
                Themes.darkMode ? 'assets/images/3mDark.svg' : 'assets/images/3mLight.svg',
                semanticsLabel: '3M Logo',
                height: 50,
                width: 280,
              ),
            ),
            ListTile(
              title: const Text('Home'),
              hoverColor: Theme.of(context).colorScheme.secondary,
              trailing: const Icon(
                Icons.home,
              ),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            ListTile(
              title: const Text('About'),
              trailing: const Icon(
                Icons.info_rounded,
              ),
              onTap: () => Navigator.pushReplacementNamed(context, '/about'),
            ),
            ListTile(
              title: const Text('Settings'),
              trailing: const Icon(
                Icons.settings,
              ),
              onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
            ),
          ],
        ),
      );
  }
}


