import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SideShowScreen extends StatefulWidget {
  @override
  _SideShowScreenState createState() => _SideShowScreenState();
}

class _SideShowScreenState extends State<SideShowScreen> {
  bool isSideShowOpen = false;
  String selectedTile = 'My Contract';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    isSideShowOpen = screenWidth > 1350 ? true : false;



    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isSideShowOpen ? 250 : 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: isSideShowOpen
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/images/tp_logo.svg',
                      height: 29,
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.grey[300],
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSideShowOpen = !isSideShowOpen;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  // Expand/Collapse Button
                  Center(
                    child: ClipOval(

                      child: Material(
                        color: Colors.deepPurple.withOpacity(0.2), // Light purple background
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isSideShowOpen = !isSideShowOpen;
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            size: 24, // Increased size for better visibility
                            color: Colors.deepPurple, // Matching color with the background
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30), // Extra space below the arrow for a more spacious design

                  // Divider with a slight shadow effect
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 30), // Adding some breathing space after the divider

                  // Icons with Stylish Backgrounds and Spacing
                  _buildCollapsedMenuIcon(Icons.home_outlined, Colors.pink),
                  SizedBox(height: 30), // More space between icons
                  _buildCollapsedMenuIcon(Icons.assignment_outlined, Colors.blue),
                  SizedBox(height: 30),
                  _buildCollapsedMenuIcon(Icons.people_outlined, Colors.green),
                  SizedBox(height: 30),
                  _buildCollapsedMenuIcon(Icons.attach_money_outlined, Colors.orange),
                  SizedBox(height: 30),
                  _buildCollapsedMenuIcon(Icons.message_outlined, Colors.purple),
                ],
              ),
            ),
            if (isSideShowOpen) ...[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.add_circle_outline),
                    title: Text('Create Contract',
                        style: GoogleFonts.roboto(fontSize: 14)),
                    onTap: () {},
                  ),
                ),
              ),
              Divider(),
              _buildTile(Icons.home_outlined, 'Home', () {
                setState(() {
                  selectedTile = 'Home';
                });
              }, highlight: selectedTile == 'Home'),
              _buildTile(Icons.assignment_outlined, 'My Contract', () {
                setState(() {
                  selectedTile = 'My Contract';
                });
              }, highlight: selectedTile == 'My Contract'),
              _buildTile(Icons.people_outlined, 'Friends', () {
                setState(() {
                  selectedTile = 'Friends';
                });
              }, highlight: selectedTile == 'Friends'),
              _buildTile(Icons.attach_money_outlined, 'Transactions', () {
                setState(() {
                  selectedTile = 'Transactions';
                });
              }, highlight: selectedTile == 'Transactions'),
              _buildTile(Icons.message_outlined, 'Messages', () {
                setState(() {
                  selectedTile = 'Messages';
                });
              }, highlight: selectedTile == 'Messages'),
              Spacer(),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, right: 16.0),
                child: _buildTile(Icons.help_outline, 'Help', () {
                  setState(() {
                    selectedTile = 'Help';
                  });
                }),
              ),
            ]



          ],
        ),
      ),
                );

  }

  // Widget _buildCollapsedMenuIcon(IconData icon, Color bgColor) {
  //   return Material(
  //     color: bgColor.withOpacity(0.2), // Soft background for each icon
  //     shape: CircleBorder(
  //
  //     ), // Circle shape for each icon
  //     elevation: 4, // Slight shadow for a 3D effect
  //     child: InkWell(
  //       onTap: () {
  //         // Action when the icon is tapped
  //       },
  //       borderRadius: BorderRadius.circular(50), // Round effect on click
  //       child: Icon(
  //         icon,
  //         size: 36, // Increased icon size for better clarity and impact
  //         color: bgColor, // Color of the icon to match the background
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCollapsedMenuIcon(IconData icon, Color bgColor) {
    return CircleAvatar(
     backgroundColor: bgColor,
      minRadius: 15,
      child: Center(
        child: Icon(
          icon,
          color: Colors.white, // Icon color
          size: 24, // Icon size
        ),
      ),
    );
  }


  Widget _buildTile(IconData icon, String title, VoidCallback onTap,
      {bool highlight = false}) {
    return Container(
      decoration: BoxDecoration(
        color: highlight ? Color(0XFFdbbbf9).withOpacity(0.80) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: highlight ? Color(0xff360930) : null),
        title: Text(
          title,
          style: GoogleFonts.roboto(
            color: highlight ? Color(0xff360930) : null,
            fontSize: 13,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
