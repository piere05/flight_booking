import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'bottom_nav_controller.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  const FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booking',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FlightBookingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  _FlightBookingScreenState createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  String selectedTrip = 'One-way';
  String fromAirport = 'DXB - Dubai, UAE';
  String toAirport = 'SEO - Seoul, Korea';
  DateTime selectedDate = DateTime.now().add(Duration(days: 30));
  String passengers = '1 Adult';
  String travelClass = 'Economy';

  final tripTypes = ['One-way', 'Round trip', 'Multi-city'];
  final airports = [
    'DXB - Dubai, UAE',
    'SEO - Seoul, Korea',
    'NYC - New York, USA',
    'LON - London, UK',
    'PAR - Paris, France',
    'TOK - Tokyo, Japan',
  ];
  final passengerOptions = [
    '1 Adult',
    '2 Adults',
    '3 Adults',
    '4 Adults',
    '5 Adults',
    '6 Adults',
  ];
  final classOptions = ['Economy', 'Business', 'First Class'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  buildAirportField(
                    'From',
                    fromAirport,
                    Icons.flight_takeoff,
                    true,
                  ),
                  SizedBox(height: 12),
                  buildAirportField('To', toAirport, Icons.flight_land, false),
                  SizedBox(height: 12),
                  buildDateField(),
                  SizedBox(height: 12),
                  buildPassengerAndClass(),
                  SizedBox(height: 20),
                  buildSearchButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.deepPurple, Colors.indigo]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location', style: TextStyle(color: Colors.white70)),
                Text(
                  'Dhaka, Bangladesh',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildAirportField(
    String label,
    String airport,
    IconData icon,
    bool isFrom,
  ) {
    return GestureDetector(
      onTap: () async {
        String? selected = await showDialog<String>(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Select $label Airport'),
            content: SizedBox(
              width: double.minPositive,
              height: 300,
              child: ListView.builder(
                itemCount: airports.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(airports[index]),
                    onTap: () {
                      Navigator.pop(context, airports[index]);
                    },
                  );
                },
              ),
            ),
          ),
        );
        if (selected != null) {
          setState(() {
            if (isFrom) {
              fromAirport = selected;
            } else {
              toAirport = selected;
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text(airport, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateField() {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (picked != null) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(Icons.calendar_today, color: Colors.deepPurple),
          title: Text('Departure'),
          subtitle: Text(
            DateFormat('EEE, dd MMM yyyy').format(selectedDate),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buildPassengerAndClass() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              String? selected = await showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Select Passengers'),
                  content: SizedBox(
                    width: double.minPositive,
                    height: 300,
                    child: ListView.builder(
                      itemCount: passengerOptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(passengerOptions[index]),
                          onTap: () {
                            Navigator.pop(context, passengerOptions[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
              if (selected != null) {
                setState(() {
                  passengers = selected;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Passengers', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text(
                    passengers,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              String? selected = await showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Select Class'),
                  content: SizedBox(
                    width: double.minPositive,
                    height: 200,
                    child: ListView.builder(
                      itemCount: classOptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(classOptions[index]),
                          onTap: () {
                            Navigator.pop(context, classOptions[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
              if (selected != null) {
                setState(() {
                  travelClass = selected;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text(
                    travelClass,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Flight Search'),
            content: Text(
              'Searching flights from $fromAirport to $toAirport on ${DateFormat('EEE, dd MMM yyyy').format(selectedDate)} for $passengers in $travelClass class.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Text('Search flights', style: TextStyle(fontSize: 16)),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final BottomNavController controller = Get.put(BottomNavController());

  final pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Bookings Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
