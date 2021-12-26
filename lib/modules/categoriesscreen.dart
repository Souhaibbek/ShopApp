import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categoriesmodel.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopstates.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCatScreen(
                  ShopCubit.get(context).categoriesModel!.data.data[index]);
            },
            separatorBuilder: (context, index) => Container(
              height: 1.0,
              color: Colors.grey,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          );
        });
  }
}

Widget buildCatScreen(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
