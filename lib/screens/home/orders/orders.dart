import 'package:awsilny_driver/screens/home/orders/ordersList.dart';
import 'package:awsilny_driver/shared/colors.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrdersList(),
    );
  }
}
