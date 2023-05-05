import  "package:flutter/material.dart";
import 'package:s_pay/Activity.dart';
import 'package:s_pay/main.dart';



class AddMoney extends StatelessWidget {
  AddMoney({Key? key}) : super(key: key);


  final TextEditingController amt = TextEditingController();

  final TextEditingController remarks = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add Money',style: TextStyle(
              fontSize: 30,
              fontFamily: 'NovaSquare'
          ),),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          centerTitle: true,),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(height:20.0,thickness: 10.0,),


                  Container(
                    padding:EdgeInsets.all(10.0),
                    margin:EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        labelText: 'Amount',
                        labelStyle:TextStyle(

                            color: Colors.white
                        ),
                        hintStyle: TextStyle(
                          color:Colors.black,
                        ),
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(),


                      ),
                      controller: amt,
                    ),
                  ),

                  Container(
                    padding:EdgeInsets.all(10.0),
                    margin:EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'remarks',
                        labelText: 'remarks',
                        labelStyle:TextStyle(

                            color: Colors.white
                        ),
                        hintStyle: TextStyle(
                          color:Colors.black,
                        ),
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(),


                      ),
                      controller: remarks,
                    ),
                  ),

                  TextButton(onPressed: (){
                    add_conn a = add_conn();
                    a.credit(double.parse(amt.text));
                  }, child:Text("Add"),style: TextButton.styleFrom(backgroundColor: Colors.yellow,alignment: Alignment.center),),
                ]
            )
        )
    );
  }
}
