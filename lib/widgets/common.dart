import '../importer.dart';

PreferredSizeWidget mainAppBar(String title, scaffoldKey) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.menu),
      color: MyColorSet.textColor,
      onPressed: () => scaffoldKey.currentState.openDrawer(),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        color: MyColorSet.textColor,
        fontFamily: "Gochi_Hand",
      ),
    ),
    centerTitle: true,
    backgroundColor: MyColorSet.colorPink,
  );
}


