

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWebviewScreen extends StatefulWidget {
  final String approvalUrl;
  final Future<void> Function() onPaymentApproved;

  const PaypalWebviewScreen({super.key, required this.approvalUrl, required this.onPaymentApproved});

  @override
  State<PaypalWebviewScreen> createState() => _PaypalWebviewScreenState();
}

class _PaypalWebviewScreenState extends State<PaypalWebviewScreen> {
  late final WebViewController _controller;
  bool _isCapturing = false;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request)async{
          final url = request.url;
          if(url.contains('payment-success')){
            if(!_isCapturing){
              _isCapturing = true;
              await widget.onPaymentApproved();

              if(mounted){
                Navigator.pop(context);
              }

            }

            return NavigationDecision.prevent;


          }

          if(url.contains('payment-cancel')){
            if(mounted){
              Navigator.pop(context);
            }

              return NavigationDecision.prevent;

          }

                      return NavigationDecision.navigate;

        }
      )
    )..loadRequest(Uri.parse(widget.approvalUrl));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAY WITH PAYPAL'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}