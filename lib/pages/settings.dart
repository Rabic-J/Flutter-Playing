import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:flutter_application_1/themes/theme.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  bool notificationsOn =
      Settings.getValue<bool>("key-notifications", defaultValue: true)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          buildAcountTile(),
          Divider(height: 10,color: Colors.transparent,),
          SettingsGroup(
            title: 'General',
            children: <Widget>[buildDarkMode(), buildNotifications(),],
          ),
          SettingsGroup(
            title: 'Feedback',
            children: <Widget>[buildReportBug(), buildFeedback()],
          ),
          SettingsGroup(
            title: 'General',
            children: <Widget>[buildLogout(), buildDeleteAcount()],
          ),
        ],
      )),
    );
  }

  Widget buildAcountTile() =>  ListTile(
        title: Text("data"),
        subtitle: Text("data"),
        leading: CircleAvatar(
          radius: 40,
          //backgroundImage: NetworkImage(item.url),
          backgroundColor: Colors.amber,
        ),
  );
        

  Widget buildLogout() => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: IconButton(
          onPressed: () {},
          color: Colors.amber,
          icon: const Icon(Icons.logout),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("NOT YET FUNCTIONAL"),
            duration: Durations.long1,
          ),
        ),
      );

  Widget buildDeleteAcount() => SimpleSettingsTile(
        title: 'Delete Acount',
        subtitle: '',
        leading: IconButton(
          onPressed: () {},
          color: Colors.pink,
          icon: const Icon(Icons.delete),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("NOT YET FUNCTIONAL"),
            duration: Durations.long1,
          ),
        ),
      );

  Widget buildReportBug() => SimpleSettingsTile(
        title: 'Report a Bug',
        subtitle: '',
        leading: IconButton(
          onPressed: () {},
          color: Colors.green,
          icon: const Icon(Icons.bug_report),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("NOT YET FUNCTIONAL"),
            duration: Durations.long1,
          ),
        ),
      );

  Widget buildFeedback() => SimpleSettingsTile(
        title: 'FeedBack',
        subtitle: '',
        leading: IconButton(
          onPressed: () {},
          color: Colors.purple,
          icon: const Icon(Icons.feedback),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("NOT YET FUNCTIONAL"),
            duration: Durations.long1,
            //behavior: SnackBarBehavior.floating,
            //margin: EdgeInsets.only(left: 10,right: 10,bottom: MediaQuery.of(context).size.height - 50),
          ),
        ),
        child: SafeArea(child: ListView(children: [Text('bob'),Text('tom')],)),
      );

  Widget buildDarkMode() {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return SwitchSettingsTile(
      settingKey: "key-dark-mode",
      title:
          themeProvider.getTheme == Themes.darkMode ? 'Darkmode' : 'Lightmode',
      subtitle: '',
      leading: IconButton(
        onPressed: () {},
        icon: themeProvider.getTheme == Themes.darkMode
            ? const Icon(Icons.dark_mode)
            : const Icon(Icons.light_mode),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        color: themeProvider.getTheme == Themes.darkMode
            ? Colors.blueAccent
            : Colors.amber[800],
      ),
      onChange: (_) {
        themeProvider.toggleTheme();
      },
    );
  }

  Widget buildNotifications() {
    return SwitchSettingsTile(
      settingKey: "key-notifications",
      title: 'Notifications',
      subtitle: '',
      leading: IconButton(
        onPressed: () {},
        icon: notificationsOn
            ? const Icon(Icons.notifications)
            : const Icon(Icons.notifications_off),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        color: notificationsOn ? Colors.amber[300] : Colors.blueGrey[300],
      ),
      onChange: (_) {
        setState(() {
          notificationsOn = !notificationsOn;
        });
      },
    );
  }
}
