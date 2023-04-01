import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plnr_api_integration_pagination/controllers/api_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user_data.dart';

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
  void initState() {
    Provider.of<ApiProvider>(context, listen: false).getUserData(pageNumber: 1);
    super.initState();
  }

  Future<void> _loaddata(BuildContext context, bool reload) async {
    print("_loaddata()");

    await Provider.of<ApiProvider>(context, listen: false).getUserData(
      pageNumber: pageNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    _loaddata(context, false);

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("No content left"),
            ),
          );
        }
      }
      print("bellow");
    });

    return Scaffold(
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
                          itemCount: userList.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            final userItem = userList![index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(apiProvider.data[index].firstName),
                                  Text(apiProvider.data[index].lastName),
                                  Image.network(apiProvider.data[index].avatar),
                                  Text(apiProvider.data[index].email),
                                ],
                              ),
                            );
                          },
                        )
                      : SizedBox.shrink()
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              (!apiProvider.firstLoading && apiProvider.isLoading)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            // Dimensions
                            //     .ICON_SIZE_EXTRA_SMALL,
                            20),
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
    ));
  }

}
