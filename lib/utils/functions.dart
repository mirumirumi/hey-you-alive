import '../importer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> getPreferenceValues() async {
  List<dynamic> result = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  result.add(prefs.getBool("active") ?? false);
  result.add(prefs.getInt("timeValue") ?? 24);
  result.add(prefs.getString("unitValue") ?? "時間");
  result.add(prefs.getInt("maxTerm") ?? 24);
  return result;
}













































