import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/order.controller.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
