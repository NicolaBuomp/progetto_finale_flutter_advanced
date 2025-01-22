import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Stack(
        children: [stackProducts(), floatingActionButton()],
      ),
    );
  }

  AppBar appBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "Luigi's",
              style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            Text(
              "Spedizione gratuita per ordini > 50\$",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            ),
          ],
        ),
      );

  Widget stackProducts() => GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 95),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemCount: 10,
        itemBuilder: (contex, index) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://loremflickr.com/640/480/food"),
                        fit: BoxFit.cover)),
              )),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Testo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "prezzo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 4,
              ),
              MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.black12)),
                child: const Text('Aggiungi'),
              )
            ],
          ),
        ),
      );

  Widget floatingActionButton() => Positioned(
        left: 16,
        right: 16,
        bottom: 32,
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, '/checkout');
          },
          height: 50,
          elevation: 0,
          minWidth: double.infinity,
          color: Colors.yellow.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text("Completa Acquisto (0)"),
        ),
      );
}
