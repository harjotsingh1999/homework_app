import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework_app/data_provider.dart';
import 'package:flutter_homework_app/welcome_screen.dart';
import 'package:provider/provider.dart';

class SelectClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TextButton(
          child: Text(
            "Continue",
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
              provider.selected.isNotEmpty ? Colors.black : Colors.grey,
            ),
          ),
          onPressed: () {
            if (provider.selected.isNotEmpty) {
              print("continue");
              provider.sortSubs();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            }
          },
        ),
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: provider.selected.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          provider.deselectAll();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      )
                    : Container(),
                toolbarHeight: 56,
                backgroundColor: Colors.white,
                actions: [
                  DotsIndicator(
                    dotsCount: 2,
                    position: provider.selected.isNotEmpty ? 1 : 0,
                    decorator: DotsDecorator(
                      color: Colors.grey,
                      activeColor: Colors.black,
                    ),
                  ),
                ],
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
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              "Teacher profile",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              "Which grades &\nsubjects do you teach",
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
              shrinkWrap: true,
              itemCount: provider.classList.length + 1,
              padding: EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                if (index == provider.classList.length)
                  return SizedBox(
                    height: 50,
                  );
                return ClassListItem(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ClassListItem extends StatelessWidget {
  final int index;

  ClassListItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => Container(
        height: 330,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 15,
                top: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      provider.classList[index].standard,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 70.0,
              left: 0.0,
              right: 0.0,
              bottom: 10.0,
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    left: 40,
                    top: 10,
                    bottom: 10,
                    right: 30,
                  ),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.classList[index].subjects.length,
                  itemBuilder: (context, itemIndex) =>
                      SubjectItem(this.index, itemIndex),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  final int listIndex, itemIndex;

  SubjectItem(this.listIndex, this.itemIndex);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => SizedBox(
        width: 200,
        child: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Color(0xfffaf2f0),
                ),
                child: CachedNetworkImage(
                  imageUrl: provider
                      .classList[listIndex].subjects[itemIndex].subjectImageUrl,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Checkbox(
                      // value: provider.selectedSubjects[listIndex]
                      //         ?.contains(itemIndex) ??
                      //     false,
                      value: provider
                          .classList[listIndex].subjects[itemIndex].isSelected,
                      activeColor: Colors.black,
                      onChanged: (val) {
                        if (val == true)
                          provider.selectSubject(
                              listIndex: listIndex, itemIndex: itemIndex);
                        else
                          provider.deselectSubject(
                              listIndex: listIndex, itemIndex: itemIndex);
                      },
                    ),
                    Text(
                      provider
                          .classList[listIndex].subjects[itemIndex].subjectName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
