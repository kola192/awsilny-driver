import 'package:awsilny_driver/screens/home/orders/singleOrder.dart';
import 'package:awsilny_driver/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('orders').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Text('Some error happend !!!');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleOrder(order: data.docs[index]),
                              ),
                            );
                          },
                          title: Text(
                              'من ${data.docs[index]['startPlace']} _ إلى ${data.docs[index]['arrivePlace']}'),
                          subtitle: Text('\$${data.docs[index]['price']}'),
                          trailing: data.docs[index]['status'] == 'pending'
                              ? GestureDetector(
                                  child: const Text(
                                    'قبول',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(data.docs[index].id)
                                        .set({
                                      'startPlace': data.docs[index]
                                          ['startPlace'],
                                      'arrivePlace': data.docs[index]
                                          ['arrivePlace'],
                                      'customerID': data.docs[index]
                                          ['customerID'],
                                      'price': data.docs[index]['price'],
                                      'status': 'accepted',
                                      'time': data.docs[index]['time'],
                                      'updatedAt': DateTime.now()
                                    });
                                  },
                                )
                              : GestureDetector(
                                  child: const Text(
                                    'تراجع',
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(data.docs[index].id)
                                        .set({
                                      'startPlace': data.docs[index]
                                          ['startPlace'],
                                      'arrivePlace': data.docs[index]
                                          ['arrivePlace'],
                                      'customerID': data.docs[index]
                                          ['customerID'],
                                      'price': data.docs[index]['price'],
                                      'status': 'pending',
                                      'time': data.docs[index]['time'],
                                      'updatedAt': DateTime.now()
                                    });
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
