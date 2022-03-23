import 'dart:io';
import 'dart:async';
import '../../importer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final Completer<WebViewController> _controller = Completer<
      WebViewController>();
  bool _isLoading = false;

  // AndroidのWebViewでの日本語入力対応
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final PageArgs arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        // appBar: mainAppBar(),
        body: Column(
          children: [
              LinearProgressIndicator(
                backgroundColor: Color(0xFFfffafafa),
                valueColor:
                _isLoading
                  ? AlwaysStoppedAnimation<Color>(Color(0xFFb5d7b8))
                  : AlwaysStoppedAnimation<Color>(Color(0xFFfafafa)),
              ),
            Expanded(
              child: WebView(
                  initialUrl: "",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: _controller.complete,
                  onPageStarted: (String url) {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                  onPageFinished: (String url) async {
                    setState(() {
                      _isLoading = false;
                    });
                  }
              ),
            )
          ],
        )
    );
  }
}


