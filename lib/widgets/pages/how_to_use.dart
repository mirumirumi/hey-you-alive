import '../../importer.dart';

class HowToUsePage extends StatefulWidget {
  @override
  _HowToUsePageState createState() => _HowToUsePageState();
}

class _HowToUsePageState extends State<HowToUsePage> with AutomaticKeepAliveClientMixin {
  final String _title = 'How to Use';
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //なくても動くけどweak warningを消せる
    return Scaffold(
      // appBar: mainAppBar(_title),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$_counter"),
              Container(color: Colors.green, width: 100, height: 100),
              TextButton(onPressed: _increment,
                child: Container(
                    color: Colors.purple, width: 100, height: 100),)
            ],
          ),
        ),
      ),
    );
  }
}


