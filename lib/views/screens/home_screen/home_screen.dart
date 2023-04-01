import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plnr_api_integration_pagination/controllers/api_provider.dart';
import 'package:plnr_api_integration_pagination/utils/dimensions.dart';
import 'package:plnr_api_integration_pagination/views/screens/home_screen/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

import '../../../models/user_data.dart';
import 'widgets/user_item.dart';

class HomeScreen extends StatefulWidget {
  static final String route = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNumber = 1;
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          Provider.of<ApiProvider>(context, listen: false).data.isNotEmpty &&
          !Provider.of<ApiProvider>(context, listen: false).isLoading) {
        int totalPages =
            Provider.of<ApiProvider>(context, listen: false).totalPages;
        if (pageNumber < totalPages) {
          pageNumber++;

          Provider.of<ApiProvider>(context, listen: false).showbottomLoader();

          Provider.of<ApiProvider>(context, listen: false).getUserData(
            pageNumber: pageNumber,
          );
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text("End of Data"),
          //   ),
          // );
          
        }
      }
      print("bellow");
    });

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        controller: _scrollController,
        child: Consumer<ApiProvider>(
          builder: (context, apiProvider, child) {
            List<Datum>? userList;
            userList = apiProvider.data;

            return Column(
              children: [
                !apiProvider.firstLoading
                    ? userList.length != 0
                        ? ListView.builder(
                            padding: const EdgeInsets.only(
                              left: Dimensions.PADDING_10,
                              bottom: Dimensions.PADDING_30,
                              right: Dimensions.PADDING_15,
                            ),
                            itemCount: userList.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              final userItem = userList![index];
                              return UserItem(
                                userItem: userItem,
                              );
                            },
                          )
                        : const SizedBox.shrink()
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                (!apiProvider.firstLoading && apiProvider.isLoading)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_20
                              ),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            );
          },
        ),
      )),
    );
  }
}



  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<ApiProvider>(context, listen: false)
  //         .getUserData(pageNumber: 1);
  //   });
  //   super.initState();
  // }

  // Future<void> _loaddata(BuildContext context, bool reload) async {
  //   print("_loaddata()");

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     await Provider.of<ApiProvider>(context, listen: false).getUserData(
  //       pageNumber: pageNumber,
  //     );
  //   });
  // }

// return Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     children: [
                              //       Text(apiProvider.data[index].firstName),
                              //       Text(apiProvider.data[index].lastName),
                              //       Image.network(apiProvider.data[index].avatar),
                              //       Text(apiProvider.data[index].email),
                              //     ],
                              //   ),
                              // );


 // return Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children: [
                              //       UserAvatar(imageUrl: userItem.avatar),
                              //       SizedBox(
                              //         width: 15,
                              //       ),
                              //       Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             "${userItem.firstName} ${userItem.lastName}",
                              //             style: const TextStyle(
                              //               color: Colors.black,
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: 5,
                              //           ),
                              //           Text(
                              //             userItem.email,
                              //             style: const TextStyle(
                              //               color: Colors.black,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // );
