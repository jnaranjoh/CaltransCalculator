import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:documents_picker/documents_picker.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget{


  // Future<void> sharFile() async{
  //   List<dynamic> docs = await DocumentsPicker.pickDocuments;
  //   if(docs == null || docs.isEmpty) return null;
    
  //   await FlutterShare.shareFile(
  //     title: 'Example Share',
  //     text: 'Example Share text',
  //     filePath: docs[0] as String,
  //   );
  // }
  @override  
  SavedPageState createState() => SavedPageState();
} 
 
class SavedPageState extends State<SavedPage> {
  Future<void> share() async{
    await FlutterShare.share(
      title: 'Example share',
      text: 'Share Projects',
      linkUrl: 'https://google.com/',
      chooserTitle: 'Example Chooser'
    );
  }
  
  Query _reference;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child("Projects");
    @override
  void initState(){
    super.initState();
    _reference = FirebaseDatabase.instance.reference().child("Projects").orderByChild("nameOfProject");
  }
  Widget buildProjectItem({Map projects}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 130,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.doc,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                projects['nameOfProject'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // Icon(
              //   Icons.phone_iphone,
              //   color: Theme.of(context).accentColor,
              //   size: 20,
              // ),
              SizedBox(
                width: 6,
              ),
              Text(
                projects['lbs of mulch'] ?? 'empty',
                style: TextStyle(
                    fontSize: 16,
                    // color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(' lbs of mulch'),
              SizedBox(width: 6),
              // Icon(
              //   Icons.group_work,
              //   size: 20,
              // ),
            ]
          ),
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Text(
                projects['bags'] ?? 'empty',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(' bags'),
              SizedBox(
                width: 6,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 6,
              ),
              Text(
                projects['bags per tank'] ?? 'empty',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                ' bags per tank'
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
          Row( 
            children: [
              SizedBox(
                width: 6,
              ),
              // Text(
              //   projects['mixingRateValue'] ?? 'empty',
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   width: 6,
              // ),
              Text(
                projects['tank'] ?? 'empty',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text(' tank loads'),
            ],
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (_) => EditContact(
          //                       contactKey: contact['key'],
          //                     )));
          //       },
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.edit,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           SizedBox(
          //             width: 6,
          //           ),
          //           Text('Edit',
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   color: Theme.of(context).primaryColor,
          //                   fontWeight: FontWeight.w600)),
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     // GestureDetector(
          //     //   onTap: () {
          //     //     _showDeleteDialog(contact: contact);
          //     //   },
          //     //   child: Row(
          //     //     children: [
          //     //       Icon(
          //     //         Icons.delete,
          //     //         color: Colors.red[700],
          //     //       ),
          //     //       SizedBox(
          //     //         width: 6,
          //     //       ),
          //     //       Text('Delete',
          //     //           style: TextStyle(
          //     //               fontSize: 16,
          //     //               color: Colors.red[700],
          //     //               fontWeight: FontWeight.w600)),
          //     //     ],
          //     //   ),
          //     // ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
  Widget buildShare(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    child: 
      ElevatedButton.icon(
        label: Text('Share'),
        icon: Icon(Icons.share_sharp),
        onPressed:() => Share.share("Testing", subject: "test"),

        //   controller: weightMulchValue,
        // decoration: buildDecoration("Weight of Mulch (lbs)"),
        // keyboardType: TextInputType.number,
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Saved Projects'),
        ),
        body:
         Container(
          height: double.infinity,
           child: new Column(
            children: <Widget>[
              Flexible(
                child: 
                  FirebaseAnimatedList(
                    query: _reference,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index){
                      Map project = snapshot.value;
                      project['key'] = snapshot.key;
                      return buildProjectItem(projects: project);
                  },
                ),
              ),
              buildShare(),
            ],
           ),
          ),

    );
  }


  
}