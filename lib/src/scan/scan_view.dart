import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_scanner/src/display_user/api_response_model.dart';
import 'package:login_scanner/src/display_user/display_user_view.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';
import 'package:login_scanner/src/scan/qr_listener.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ScanViews extends StatefulWidget {
  const ScanViews({super.key});

  static const routeName = "/scan";

  @override
  State<ScanViews> createState() => _ScanViewsState();
}

class _ScanViewsState extends State<ScanViews> {
  final storage = FlutterSecureStorage();
  String url = '';
  String api_key = '';
  bool visibleLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    url = await storage.read(key: 'url') ?? '';
    api_key = await storage.read(key: 'api_key') ?? '';
    print(url + api_key );
    setState(() {}); // Update the UI after loading the credentials
  }

  String? _barcode;
  late bool visible;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Add visiblity detector to handle barcode
        // values only when widget is visible
        child: VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            bufferDuration: Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) async{
              Fluttertoast.showToast(
                msg: "Making request to server...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0
              );
              setState(() {
                _barcode = barcode;
                visibleLoading = true;
              });
              if (!visible) return;
              print('check here');
              print(barcode);
              String finalCode = barcode;
              
              if (finalCode[0] == '[') {
                // implement logic to update url and api key
                Navigator.pushReplacementNamed(context, '/scan');
              } else {
                // logic to make call for user login status
                // Extract parameters from finalCode
                var uri = Uri.parse(barcode);
                var queryParams = uri.queryParameters;

                // Extracted parameters
                String eventQrCode = queryParams['event_qr_code'] ?? '';
                String ticketId = queryParams['ticket_id'] ?? '';
                String eventId = queryParams['event_id'] ?? '';
                String securityCode = queryParams['security_code'] ?? '';
                String path = queryParams['path'] ?? '';

                // API key
                String apiKey = api_key;

                String baseUrl = url[url.length - 1] == '/' ? url : url + '/';

                // Construct API URL
                var apiUrl = Uri.parse('$baseUrl$path')
                  .replace(queryParameters: {
                    'event_qr_code': eventQrCode,
                    'ticket_id': ticketId,
                    'event_id': eventId,
                    'security_code': securityCode,
                    'api_key': apiKey
                  });

                setState() {
                  _barcode = apiUrl.toString();
                }

                print(apiUrl);
                var response;
                // Make the GET request
                try {
                  response = await http.get(apiUrl);
                  print(response.body);
                  if (response.statusCode == 200 || response.statusCode == 403) {
                    // Handle the API response
                    print('Success: ${response.body}');
                  } else {
                    // Handle errors
                    print('Request failed with status: ${response.statusCode}.');
                  }
                } catch (e) {
                  print('An error occurred: $e');
                }

                AttendeeResponse attendeeResponse = AttendeeResponse.fromJson(jsonDecode(response.body));

                print(attendeeResponse.message);
                // setState() {
                //   _barcode = attendeeResponse.message;
                // }
                Fluttertoast.cancel();


                Navigator.pushNamed(
                  context,
                  DisplayUserView.routeName,
                  arguments: attendeeResponse,
                );
              }
              
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Scan User Qr Code",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                // Text(
                //   _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
                //   style: Theme.of(context).textTheme.headlineSmall,
                // )
                visibleLoading ? 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loading",style: Theme.of(context).textTheme.headlineSmall,),
                      SizedBox(width: 10,),
                      SpinKitPouringHourGlass(
                        color: Colors.black,
                        size: 50.0,
                      )
                    ],
                  ),
                ) 
                : 
                Container(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}