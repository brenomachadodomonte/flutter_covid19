import 'package:flutter/material.dart';
import 'charts/bar.dart';
import 'charts/pie.dart';
import 'package:intl/intl.dart';
import 'api/api.dart';

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {

  Material myCircularItems(String title, int confirmed, int deaths){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(title,style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),),
                  ),

                  Padding(
                    padding:EdgeInsets.all(8.0),
                    child:SizedBox(
                      width: 120,
                      height: 160,
                      child: Pie(Pie.createSampleData(confirmed, deaths), animate: true,),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myTextItems(String title, String subtitle){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(title,style:TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(subtitle,style:TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myBarChart(String title, bool isBlue){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(title,style:TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                    ),),
                  ),

                  /*Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(subtitle,style:TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),*/

                  Padding(
                    padding:EdgeInsets.all(8.0),
                    child:SizedBox(
                      width: 320,
                      height: 160,
                      child: Bar(Bar.createSampleData(isBlue), animate: true,),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final format = NumberFormat("#,###", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: AssetImage("assets/virus.png"),
          width: 40.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white,),
            onPressed: (){
              print('refresh');
            },
          )
        ],
      ),
      body: FutureBuilder<Map>(
        future: loadData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Dialog(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 25),
                          Text('Carregando...',
                            style: TextStyle(fontSize: 20.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
              );
            default:
              if(snapshot.hasError){
                return Center(
                    child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    )
                );
              } else {
                List data = snapshot.data['results'];
                int confirmed = data.fold(0, (t, e) => t + e['confirmed']);
                int deaths = data.fold(0, (t, e) => t + e['deaths']);
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: myBarChart('Confirmed per Month', true),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: myCircularItems('Death Rate', confirmed, deaths),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: myTextItems('Confirmed', format.format(confirmed)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: myTextItems('Deaths', format.format(deaths)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: myBarChart('Deaths per Months', false),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
