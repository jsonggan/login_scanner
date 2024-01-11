class AttendeeResponse {
  final String message;
  final Attendee attendee;

  AttendeeResponse({required this.message, required this.attendee});

  factory AttendeeResponse.fromJson(Map<String, dynamic> json) {
    return AttendeeResponse(
      message: json['msg'],
      attendee: Attendee.fromJson(json['attendee']),
    );
  }
}

class Attendee {
  final String title;
  final Ticket ticket;
  final String email;
  final String phone;
  final int price;

  Attendee({required this.title, required this.ticket, required this.email, required this.phone, required this.price});

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      title: json['title'],
      ticket: Ticket.fromJson(json['ticket']),
      email: json['email'],
      phone: json['information']['Phone'],
      price: json['payment']['price'],
    );
  }
}

class Ticket {
  final String id;
  final String title;

  Ticket({required this.id, required this.title});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
    );
  }
}
