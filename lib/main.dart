import 'importer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<dynamic> pref = await getPreferenceValues();
  return runApp(App(pref));
}

class App extends StatelessWidget {
  final MaterialColor materialWhite = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  final List<dynamic> pref;

  App(this.pref);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppMeta.appName,
      theme: ThemeData(
        primarySwatch: materialWhite,
      ),
      // darkTheme: ThemeData.dark(),
      home: HomePage(pref),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/message_settings': (BuildContext context) => MessageSettingsPage(),
        '/how_to_use': (BuildContext context) => HowToUsePage(),
        '/privacy_policy': (BuildContext context) => PrivacyPolicyPage(), //WebView
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', ''), // Japanese
      ],
    );
  }
}


