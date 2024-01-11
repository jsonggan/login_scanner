import 'package:flutter/material.dart';
import 'package:login_scanner/src/display_user/api_response_model.dart';
import 'package:login_scanner/src/layouts/admin_setup_layout.dart';

class DisplayUserView extends StatelessWidget {
  const DisplayUserView({super.key, required this.attendeeResponse});

  final AttendeeResponse attendeeResponse;

  static const routeName = "/display";
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Attendee Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Title(title: "Check in status",),
            Content(content: attendeeResponse.message,),
            SizedBox(height: 10),
            Title(title: 'Name'),
            Content(content: '${attendeeResponse.attendee.title}'),
            SizedBox(height: 10),
            Title(title: 'Ticket ID'),
            Content(content: '#${attendeeResponse.attendee.ticket.id}'),
            SizedBox(height: 10),
            Title(title: 'Ticket Title'),
            Content(content: '${attendeeResponse.attendee.ticket.title}'),
            SizedBox(height: 10),
            Title(title: 'Order Total'),
            Content(content: '${attendeeResponse.attendee.price}'),
            SizedBox(height: 10),
            Title(title: 'Email'),
            Content(content: '${attendeeResponse.attendee.email}'),
            SizedBox(height: 10),
            Title(title: 'Phone'),
            Content(content: '${attendeeResponse.attendee.phone}'),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(content,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black
      ));
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black54
      )
    );
  }
}