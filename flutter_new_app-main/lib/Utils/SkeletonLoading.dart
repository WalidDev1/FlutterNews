import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatefulWidget {
  const SkeletonLoading({ Key key }) : super(key: key);

  @override
  _SkeletonLoadingState createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
            padding: EdgeInsets.only(top: 30),
            itemCount: 8,
            itemBuilder: (BuildContext ctx, index) {
              int timer = 1000;
              return  Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey.shade300,
                period: Duration(milliseconds: timer),
                child: box(),
              );
            }
        );
  }

  Widget box(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}