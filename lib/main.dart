import 'dart:core';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/ai_footer.dart';
import 'components/ai_input.dart';
import 'components/message_content.dart';
import 'firebase_options.dart';
import 'provider/license_provider.dart';
import 'provider/message_provider.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  MyApp({required this.prefs, Key? key});
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LicenseProvider>(
          create: (context) => LicenseProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          create: (context) => MessageProvider(prefs),
        ),
      ],
      child: MaterialApp(
        title: 'AIノほめのびくん',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: HomePage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja', 'JP'),
        ],
        locale: const Locale('ja', 'JP'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    final messageProvider = Provider.of<MessageProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AIノほめのびくん',
          style: GoogleFonts.notoSansJavanese(
              textStyle: Theme.of(context).textTheme.bodyText1,
              color: Colors.white),
        ),
        actions: [
          ElevatedButton.icon(
              icon: FaIcon(FontAwesomeIcons.trash),
              onPressed: () {
                messageProvider.resetMessage();
              },
              label: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 0),
                child: Text(
                  "履歴を削除",
                  style: GoogleFonts.notoSansJavanese(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      color: Colors.white),
                ),
              ))
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: MessageContent(),
          ),
          AiInput(
            controller: _controller,
          ),
          AiFooter(),
        ],
      ),
    );
  }
}
