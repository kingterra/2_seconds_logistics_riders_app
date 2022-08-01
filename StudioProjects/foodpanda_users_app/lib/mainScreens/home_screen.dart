import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/models/sellsers.dart';
import 'package:foodpanda_users_app/widgets/carousel_publi.dart';
import 'package:foodpanda_users_app/widgets/homescreen_filter.dart';

import 'package:foodpanda_users_app/widgets/my_drawer.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:foodpanda_users_app/widgets/sellers_design.dart';

import '../widgets/NavigationBar.dart';

import 'package:flutter/src/material/colors.dart';

import '../widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    CollectionReference userData = FirebaseFirestore.instance.collection("sellers");

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            elevation: 0,
            toolbarHeight:   65,        /*MediaQuery.of(context).size.height/15,*/
            backgroundColor: Colors.white,
            pinned: true,
            floating: true,
            automaticallyImplyLeading: false,
            flexibleSpace:
            SafeArea(
              child: Container(
                height: 100,
                //color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width-90,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.5),
                              borderSide: BorderSide(width: 0.8),
                            ),
                            hintText: 'Search food or restaurants',
                            prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              color: Colors.black,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.tune),
                        onPressed: () {
                          showModalBottomSheet(

                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0),
                              ),
                            ),

                            context: context,
                            builder: (context) => homescreenFilter(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),

          SliverToBoxAdapter(
            child: Categories(),
          ),

          SliverToBoxAdapter(
              child: CarouselPubli()
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 75,
              /*decoration: const BoxDecoration(
                  color: Colors.white,
                ),*/
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: const Text(
                        'Nearby restaurants',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'Signatra',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //SliverPersistentHeader(pinned: true, delegate: delegate)
          //from the sellers collection file we will take all the sellers
          FutureBuilder<QuerySnapshot>(
            future: userData.get(),
            //if the sellers file is empty from the firestore do a circular progression
            builder: (context, snapshot)
            {
              if (snapshot.connectionState != ConnectionState.done) {
                return SliverToBoxAdapter(
                  child: Text('waiting'),
                );
              }
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: Text('error')),
                );
              }
              final data = snapshot.data;
              return SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Sellers sModel = Sellers.fromjson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>

                  );

                  //design  for display sellers-cafes-restaurant
                  return SellersDesignWidget(
                    model: sModel,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,

              );
            },
          ),
        ],
      ),
    );
  }
}