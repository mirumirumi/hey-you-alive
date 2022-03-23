import '../../importer.dart';

class MessageSettingsPage extends StatefulWidget {
  @override
  _MessageSettingsPageState createState() => _MessageSettingsPageState();
}

class _MessageSettingsPageState extends State<MessageSettingsPage> with AutomaticKeepAliveClientMixin {
  final String _title = 'Message to...';

  dynamic _getMessageTypeIcon(String messageType) {
    switch (messageType) {
      case "Mail":
        return Image.asset(
          "assets/img/mail.png",
          width: 60,
          height: 60,
        );
      case "SMS":
        return Image.asset(
          "assets/img/sms.png",
          width: 60,
          height: 60,
        );
      case "LINE":
        return Image.asset(
          "assets/img/line.png",
          width: 50,
          height: 60,
        );
    }
  }

  Widget _widgetMessageTypeCard(String messageType) {
    final Color gray = Color(0xFFd2d2d2);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Color(0xFF535353).withOpacity(0.15),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(1, 1.5),
        )],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () => {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              messageType,
              style: TextStyle(
                color: Color(0xFF848484),
                fontWeight: FontWeight.bold,
              ),
            ),
            _getMessageTypeIcon(messageType),
            Column(
              children: [
                Icon(
                  messageType == "Mail"
                    ? Icons.check_circle_rounded
                    : Icons.do_not_disturb_on_outlined,
                  size: 21,
                  color:
                    messageType == "Mail"
                      ? MyColorSet.primaryColor
                      : gray,
                ),
                Text(
                  messageType == "Mail"
                      ? "設定されています"
                      : "設定されていません",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                      messageType == "Mail"
                        ? MyColorSet.primaryColor
                        : gray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //なくても動くけどweak warningを消せる
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _title,
          style: TextStyle(
            fontSize: 25,
            color: MyColorSet.textColor,
            fontFamily: "Gochi_Hand",
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColorSet.colorWhite,
        // backgroundColor: MyColorSet.colorGreen,
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 20,
        childAspectRatio: 0.65,
        children: [
          _widgetMessageTypeCard(AppMeta.messageType[0]), //Mail
          _widgetMessageTypeCard(AppMeta.messageType[1]), //SMS
          _widgetMessageTypeCard(AppMeta.messageType[2]), //LINE
        ],
      ),
      // backgroundColor: MyColorSet.colorGreen,
    );
  }
}


