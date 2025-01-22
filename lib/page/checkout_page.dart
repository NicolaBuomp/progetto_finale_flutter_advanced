import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: CustomScrollView(
        slivers: [sectionProductList(), sectionCostRecap()],
      ),
    );
  }

  AppBar appBar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      );

  Widget sectionProductList() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://loremflickr.com/640/480/food'),
              ),
              title: const Text(
                'Nome',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('7\$'),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle_outline)),
            ),
          ),
          childCount: 9,
        ),
      );

  Widget sectionCostRecap() => const SliverToBoxAdapter(
        child: Column(
          children: [
            CheckoutRow(
              title: 'Sottototale',
              value: 10.50,
            ),
            CheckoutRow(
              title: 'Tasse',
              value: 1,
            )
          ],
        ),
      );
}

class CheckoutRow extends StatelessWidget {
  final String title;
  final double value;
  const CheckoutRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: Text(
        '${value.toStringAsFixed(2)}\$',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
