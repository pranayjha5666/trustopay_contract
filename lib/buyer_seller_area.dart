import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  final dynamic contractData; // Contract data fetched from the API
  const Person({Key? key, required this.contractData}) : super(key: key);

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  bool isAccepted = false;
  bool isRejected = false;

  @override
  Widget build(BuildContext context) {
    final contract = widget.contractData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildCard(
                  title: "Buyer Details",
                  name: contract['buyer'] ?? "Buyer",
                  email: generateEmail(contract['buyer'] ?? "buyer"),
                  phone: contract['buyerPhone'] ?? "0000000000",
                  imageUrl: "assets/images/boy.jpg",
                ),
                SizedBox(height: 10),
                buildCard(
                  title: "Seller Details",
                  name: contract['seller'] ?? "Seller",
                  email: generateEmail(contract['seller'] ?? "seller"),
                  phone: contract['sellerPhone'] ?? "0000000000",
                  imageUrl: "assets/images/girls.png",
                ),
                SizedBox(height: 10),
                buildRecentActivityCard(contract['buyer'], contract['project_name']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateEmail(String name) {
    // Converts the name to lowercase and removes spaces
    return "${name.toLowerCase().replaceAll(' ', '')}@gmail.com";
  }

  Widget buildCard({
    required String title,
    required String name,
    required String email,
    required String phone,
    required String imageUrl,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "Email: $email",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "Phone: $phone",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecentActivityCard(String? buyerName, String? projectName) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isAccepted && !isRejected) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      '$buyerName wants to create a contract with you for the project $projectName. Please review and respond.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Decline Button
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isRejected = true;
                            });
                          },
                          child: Text(
                            'Decline',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      // Accept Button
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isAccepted = true;
                            });
                          },
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else if (isAccepted) ...[
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'You accepted the offer!',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ] else if (isRejected) ...[
                  Icon(Icons.cancel, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'You rejected this offer!',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
