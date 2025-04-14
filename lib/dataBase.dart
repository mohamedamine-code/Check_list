import 'package:hive/hive.dart';

class Database {

  List MyList=[];
  
  var box= Hive.box('ListChekes');

void iniCreation(){
  MyList=[
    ['Welcome Home',false],
  ];
}


void loadData(){
MyList=box.get('item');
}

void setData(){
  box.put('item', MyList);
}
}