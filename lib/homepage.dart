import 'package:app/dataBase.dart';
import 'package:app/util/list_note.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TextEditingController controller = TextEditingController();
  bool ischecked =false;
  Database bd =Database();

  var box = Hive.box('ListChekes');


  void clear(){
    setState(() {
      controller.clear();
    });
  }
  void add_note(){
    setState(() {
      bd.MyList.add([controller.text,false]);
      // ajoute dans un autre list 
    });
    controller.clear();
    bd.setData();
  }

  void onChanged(index){
    setState(() {
      bd.MyList[index][1]=!bd.MyList[index][1];
    });
    bd.setData();
  }

void delatenote(index){
  setState(() {
    bd.MyList.removeAt(index);
  });
  bd.setData();
}
@override
  void initState() {
    if(box.get('item')==null){
      bd.iniCreation();
    }else{
      bd.loadData();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Check List',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                ),
                SizedBox(
                  height: 100,
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Take a note ..')
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        add_note();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 0, 129, 4)
                        ),
                        child: Center(child: Text('ADD',style: TextStyle(fontSize: 17))),
                    )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        clear();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:  Colors.grey
                        ),
                        child: Center(child: Text('Clear',style: TextStyle(fontSize: 17))),
                    )
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 25,bottom: 20,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name Tache ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text('State ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                      child: ListView.builder(
                        itemCount: bd.MyList.length,
                        itemBuilder: (BuildContext context,index){
                        return list_note(
                          delatenote: (){
                            delatenote(index);
                          },
                          data: bd.MyList[index][0],
                          ischecked: bd.MyList[index][1],
                          onChanged: (){
                            onChanged(index);
                          },
                        );
                      }),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}