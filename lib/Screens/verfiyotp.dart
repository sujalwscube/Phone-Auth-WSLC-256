import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerfiyOTP extends StatefulWidget {
  String id;
   VerfiyOTP({super.key,required this.id});

  @override
  State<VerfiyOTP> createState() => _VerfiyOTPState();
}

class _VerfiyOTPState extends State<VerfiyOTP> {
  TextEditingController otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                try{
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.id, smsCode: otpController.text.toString());
                  await FirebaseAuth.instance.signInWithCredential(credential);
                }
                catch(e){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Wrong OTP'),
                      actions: [
                        TextButton(onPressed: (){}, child: Text('Ok'))
                      ],
                    );
                  });
                }
              },
              child: Text("Send OTP"))
        ],
      ),
    );
  }
}
