import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_scanner/src/display_user/api_response_model.dart';
import 'package:login_scanner/src/display_user/display_user_view.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';
import 'package:login_scanner/src/scan/qr_listener.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:http/http.dart' as http;


class ScanViews extends StatefulWidget {
  const ScanViews({super.key});

  static const routeName = "/scan";

  @override
  State<ScanViews> createState() => _ScanViewsState();
}

class _ScanViewsState extends State<ScanViews> {
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
              setState(() {
                _barcode = barcode;
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
                var uri = Uri.parse('https://cimbwealthsymposium.com/wp-json/tribe/tickets/v1/qr?event_qr_code=1&ticket_id=4877&event_id=4591&security_code=ecf9cfc19c&api_key=e04e6b86');
                var queryParams = uri.queryParameters;

                // Extracted parameters
                String eventQrCode = queryParams['event_qr_code'] ?? '';
                String ticketId = queryParams['ticket_id'] ?? '';
                String eventId = queryParams['event_id'] ?? '';
                String securityCode = queryParams['security_code'] ?? '';
                String path = queryParams['path'] ?? '';

                // API key
                String apiKey = 'e04e6b86';

                // Construct API URL
                var apiUrl = Uri.parse('https://cimbwealthsymposium.com/$path')
                  .replace(queryParameters: {
                    'event_qr_code': eventQrCode,
                    'ticket_id': ticketId,
                    'event_id': eventId,
                    'security_code': securityCode,
                    'api_key': apiKey
                  });

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
                Text(
                  _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}