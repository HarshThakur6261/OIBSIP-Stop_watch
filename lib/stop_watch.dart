import 'dart:async';

import 'package:flutter/material.dart';

class stop_watch extends StatefulWidget {
  const stop_watch({super.key});

  @override
  State<stop_watch> createState() => _stop_watchState();
}

class _stop_watchState extends State<stop_watch> {
  Timer? timer;
  bool started = false;
  int seconds = 0;
  int minutes = 0;
  int Hours = 0;
  String digitseconds = "00";
  String digitminutes = "00";
  String digitHours = "00";
  List laps = [];

  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }
  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes=0;
      Hours =0 ;
      digitminutes ="00";
      digitseconds = "00";
      digitHours = "00";
      started = false;
      laps.clear();
    });
  }

  void lap(){
    String lap = "$digitHours:$digitminutes:$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }



  void start(){
started = true;
timer = Timer.periodic(Duration(seconds: 1), (timer) {
int localseconds = seconds+1;
int localminutes = minutes;
int localHours = Hours;

if(localseconds>59){
  if(localminutes>59){
    localHours++;
  }else{
    localminutes++;
    localseconds = 0;
  }
}
setState(() {
  seconds = localseconds;
  minutes = localminutes;
  Hours = localHours;
  digitseconds = (seconds>=10)? "$seconds":"0$seconds";
  digitminutes = (minutes>=10)? "$minutes":"0$minutes";
  digitHours = (Hours>=10)? "$Hours":"0$Hours";

});


});
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1c2757),
      body: SafeArea(
child:SizedBox(
  width: double.infinity,
  child:   Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Text("Stop Watch App",style: TextStyle(color: Colors.white,fontSize:28,fontWeight: FontWeight.bold),),
        SizedBox(height: 20),
        Flexible(

          fit: FlexFit.loose,
          child: Container(
            width: double.infinity,
            height: 100,
            child:  FittedBox(
                child: Text("$digitHours:$digitminutes:$digitseconds",style: TextStyle(color: Colors.white,fontSize:82,fontWeight: FontWeight.bold),)),
          ),
        ),

        SizedBox(height: 20,),

        Flexible(
          fit: FlexFit.loose,
          flex: 3,
          child: Container(

            height: 500,
            decoration: BoxDecoration(  color: Color(0xFF323F68),borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(itemCount:laps.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text("lap {$index}",style: TextStyle(color: Colors.white),),
                  trailing: Text("${laps[index]}",style: TextStyle(color: Colors.white),),
                ),
              );

            }),

          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: ElevatedButton(onPressed: (){
              (!started) ? start() : stop();
            },
                style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: 
                BorderRadius.circular(22)),backgroundColor: Colors.transparent )
                ,child: Text((!started)? "Start" : "stop"))),

            IconButton(onPressed: (){
              lap();
            }, icon: Icon(Icons.flag),color: Colors.white,),


            Expanded(child: ElevatedButton(onPressed: (){
              reset();
            },
                style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(22)) )
                ,child: Text("Restart"))),
          
          
          ],
        )



      ],
    ),
  ),
),
      )
    );
  }
}
