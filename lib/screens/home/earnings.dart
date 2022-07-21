import 'package:flutter/material.dart';

class EarnigsTabPage extends StatelessWidget {
  const EarnigsTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Column
      (
    children:[
      Container(
        color: Colors.black54,
        width: double.infinity,
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            children: const [
              Text("مبلغ كل الرحلات 40",style: TextStyle(color: Colors.white,fontSize: 20),),
            ],
          ),
          
        ),
      ),
      FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: ()
        {
          print("go to history");
        },
        child: Row(
          children: [
            Image.asset('images/uberx.png',width: 70,height: 90,),
            const SizedBox(width: 30,),
            const Text(' مبلغ الرحلة ', style: TextStyle(fontSize: 16),),
            const Expanded(child: Text("20",textAlign: TextAlign.end,style: TextStyle(fontSize: 18),)),
          ],
        ),
      ),
     const Divider(height: 2.0,thickness: 2.0,),

    ],
      );
  }
}