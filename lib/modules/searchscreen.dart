import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/searchcubit/searchcubit.dart';
import 'package:shopapp/shared/cubit/searchcubit/searchstates.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      label: 'Search',
                      type: TextInputType.text,
                      controller: searchController,
                      prefix: Icons.search,
                      onSubmit: (text) {
                        SearchCubit.get(context).getSearch(text);
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Insert Text';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        //   itemBuilder: (context, index) =>Container(child: Text('Test'),),
                        // itemCount: 10,
                        separatorBuilder: (context, index) => Container(
                          color: Colors.grey,
                          height: 1.0,
                        ),
                        itemBuilder: (context, index) => searchItemBuilder(SearchCubit.get(context).searchModel!.data.data[index],context),
                        itemCount: SearchCubit.get(context).searchModel!.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget searchItemBuilder(Product model, context) => Container(
  height: 120.0,
  child: Row(
    children: [
      Stack(
        alignment: Alignment.topRight,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 120.0,
            width: 120.0,
          ),
          if (model.discount != 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.red,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.0,
                height: 1.3,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${model.price.round()} USD',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Spacer(),
                // IconButton(
                //   padding: EdgeInsets.zero,
                //   onPressed: () {
                //     ShopCubit.get(context).changeFav(model.id);
                //   },
                //   icon:ShopCubit.get(context).favorites[model.id] == true? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                // ),

              ],
            ),
          ],
        ),
      ),
    ],
  ),
);
