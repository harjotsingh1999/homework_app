import 'package:flutter/material.dart';
import 'package:flutter_homework_app/data_provider.dart';
import 'package:flutter_homework_app/subject_model.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton(
          child: Text(
            "Thank you",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 130,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            overlayColor: MaterialStateProperty.all(Colors.white10),
            backgroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 56,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 66),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 66,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/img.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              "You teach these\nclass & subjects",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container(
            child: ListView.builder(
              itemCount: provider.selectedSubs.length,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (context, index) => SubjectItem(
                provider.selectedSubs[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  final Subject subject;

  SubjectItem(this.subject);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            subject.standard,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          subject.subjectName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
