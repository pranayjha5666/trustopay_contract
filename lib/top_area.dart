import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  const CustomAppBar({Key? key, required this.contractData}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String currentDate; // Dynamic date from API
  late String userName; // Dynamic seller name from API
  int notificationCount = 0; // Example dynamic notification count
  bool isScrollable = false; // Flag to determine whether scrolling should be enabled
  double wid = 1000;

  @override
  void initState() {
    super.initState();

    // Initialize dynamic data from the API
    final contract = widget.contractData;
    currentDate = formatDate(contract['contract_created']);
    userName = contract['seller'] ?? 'Seller Name';
  }

  String formatDate(String dateString) {
    // Parse the timestamp and format it as "day month year"
    final DateTime date = DateTime.parse(dateString);
    return DateFormat("dd MMMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      wid = screenWidth;
    });

    // Update the scroll behavior based on the screen width
    if (screenWidth < 1000) {
      isScrollable = true; // Enable scroll view for small screen sizes
    } else {
      isScrollable = false; // Disable scroll view for larger screen sizes
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding
      child: isScrollable
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildAppBarWidgets(),
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildAppBarWidgets(),
      ),
    );
  }

  List<Widget> _buildAppBarWidgets() {
    return [
      // Date Widget
      Row(
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            currentDate, // Dynamic date from API
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(width: 100),

      // Search Bar
      wid > 600
          ? Container(
        width: wid * 0.4,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search user using number or name",
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      )
          : IconButton(
        icon: const Icon(Icons.search, color: Colors.grey),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Search"),
              content: TextField(
                decoration: InputDecoration(
                  hintText: "Search user using number or name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      ),
      const SizedBox(width: 16),

      // Vertical Divider
      Container(
        width: 1,
        height: 40,
        color: Colors.grey,
      ),
      const SizedBox(width: 16),

      // Notification Icon
      Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                notificationCount++; // Increment notification count dynamically
              });
            },
          ),
          if (notificationCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  '$notificationCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(width: 16),

      // Vertical Divider
      Container(
        width: 1,
        height: 40,
        color: Colors.grey,
      ),
      const SizedBox(width: 16),

      // User Avatar and Name
      Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            ),
            radius: 18,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                userName = "Updated User"; // Update username dynamically
              });
            },
            child: Text(
              userName, // Dynamic seller name from API
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
