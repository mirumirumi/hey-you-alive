import '../../importer.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final List<dynamic> pref;

  HomePage(this.pref);

  @override
  _HomePageState createState() => _HomePageState(pref[0], pref[1], pref[2], pref[3]);
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String _title = AppMeta.appName;
  final int _minTerm = 1;
  bool _enabled;
  int _timeValue;
  String _unitValue;
  int _maxTerm;

  _HomePageState(this._enabled, this._timeValue, this._unitValue, this._maxTerm);

  void _changeSwitch() async {
    setState(() {
      _enabled = !_enabled;
    });
    _saveIsEnabled();
  }

  void _onChangedTimeValue(int value) {
    setState(() {
      _timeValue = value;
    });
    _saveTimeValue();
  }

  void _onChangedUnitValue(String? value) {
    setState(() {
      _unitValue = value ?? "時間";
      switch (value) {
        case "日":
          _maxTerm = 30;
          if (_timeValue > _maxTerm) {
            _onChangedTimeValue(_maxTerm);
          }
          return;
        case "時間":
          _maxTerm = 24;
          if (_timeValue > _maxTerm) {
            _onChangedTimeValue(_maxTerm);
          }
          return;
        case "分":
          _maxTerm = 60;
          if (_timeValue > _maxTerm) {
            _onChangedTimeValue(_maxTerm);
          }
          return;
      }
    });
    _saveUnitValue();
    _saveMaxTerm();
  }

  void _saveIsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("enabled", _enabled);
  }

  void _saveTimeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("timeValue", _timeValue);
  }

  void _saveUnitValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("unitValue", _unitValue);
  }

  void _saveMaxTerm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("maxTerm", _maxTerm);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //なくても動くけどweak warningを消せる
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColorSet.colorPink,
      appBar: mainAppBar(_title, _scaffoldKey),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.mail_outline_rounded),
              title: Text(
                "送信先の設定",
                style: TextStyle(
                  color: Color(0xFF4b4b4b),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/message_settings");
              }
            ),
            Container(width: double.infinity, height: 1, color: Color(0xFFe6e6e6)),
            ListTile(
              leading: Icon(Icons.help_outline_rounded),
              title: Text(
                "つかいかた",
                style: TextStyle(
                  color: Color(0xFF4b4b4b),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/how_to_use");
              }
            ),
            Container(width: double.infinity, height: 1, color: Color(0xFFe6e6e6)),
            ListTile(
              leading: Icon(Icons.military_tech_rounded),
              title: Text(
                "有料版について",
                style: TextStyle(
                  color: Color(0xFF4b4b4b),
                ),
              ),
              onTap: () => {

              },
            ),
            Container(width: double.infinity, height: 1, color: Color(0xFFe6e6e6)),
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text(
                "プライバシーポリシー",
                style: TextStyle(
                  color: Color(0xFF4b4b4b),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/privacy_policy");
              }
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 1,
              height: 120,
              color: Colors.transparent,
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 4.0,
                      child: Switch(
                        value: _enabled,
                        activeTrackColor: Color(0xFFdbe9de),
                        activeColor: MyColorSet.primaryColor,
                        inactiveTrackColor: Color(0xFFdddddd),
                        inactiveThumbColor: Color(0xFFb7b7b7),
                        onChanged: (e) => {}, //ダミー
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Container(
                        width: 120,
                        height: 90,
                      ),
                      onPressed: _changeSwitch,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    _enabled
                        ? "ON"
                        : "OFF",
                    style: TextStyle(
                      color: _enabled
                          ? MyColorSet.primaryColor
                          : Color(0xFFb7b7b7),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 170,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 113,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Icon(
                                 Icons.keyboard_arrow_up_rounded,
                                 color: MyColorSet.colorArrowIcon,
                               ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: MyColorSet.colorArrowIcon,
                                ),
                              ],
                            ),
                          ),
                          NumberPicker(
                            itemCount: 1,
                            value: _timeValue,
                            minValue: _minTerm,
                            maxValue: _maxTerm,
                            itemWidth: 100,
                            itemHeight: 100,
                            haptics: true,                          //要テスト
                            textStyle: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF858b94),
                            ),
                            selectedTextStyle: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: MyColorSet.colorMainText,
                            ),
                            decoration: BoxDecoration(

                            ),
                            onChanged: _onChangedTimeValue,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 3),
                        child: DropdownButton(
                          value: _unitValue,
                          iconEnabledColor: MyColorSet.colorArrowIcon,
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: MyColorSet.colorMainText,
                          ),
                          underline: Container(

                          ),
                          dropdownColor: Color(0xFFf4f6fa),
                          onChanged: _onChangedUnitValue,
                          items: <String>["日", "時間", "分"].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "の間一度も生存反応がないと連絡する",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF858b94),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




