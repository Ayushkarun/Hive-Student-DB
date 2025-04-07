import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String name;
  final String domain;
  final String age;
  final String place;
  final int index;

  const Screen2({
    super.key,
    required this.name,
    required this.domain,
    required this.age,
    required this.place,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueGrey[200],
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  domain,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),

              const Divider(height: 40, thickness: 1.2),

              Row(
                children: [
                  const Icon(Icons.cake, color: Colors.blueGrey),
                  const SizedBox(width: 10),
                  Text(
                    'Age: $age',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blueGrey),
                  const SizedBox(width: 10),
                  Text(
                    'Place: $place',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const Spacer(),

              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //  FocusScope.of(context).unfocus(); 
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}