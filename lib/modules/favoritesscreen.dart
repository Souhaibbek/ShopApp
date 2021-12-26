import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/models/getfavmodel.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopcubit.dart';
import 'package:shopapp/shared/cubit/shopcubit/shopstates.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            conditionBuilder: (BuildContext context) =>
                state is! ShopLoadingGetFavState,
            context: context,
            widgetBuilder: (BuildContext context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return favItemBuilder(
                      ShopCubit.get(context).favoritesModel!.data.data[index],
                      context);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colors.grey,
                    height: 1.0,
                  );
                },
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data.length,
              );
            },
            fallbackBuilder: (BuildContext context) =>
                Center(child: CircularProgressIndicator()),
          );
        });
  }
}

Widget favItemBuilder(FavData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Image(
                  image: NetworkImage('${model.product.image}'),
                  height: 120.0,
                  width: 120.0,
                ),
                if (model.product.discount != 0)
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
                    model.product.name.toString(),
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
                        '${model.product.price.round()} USD',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          '${model.product.oldPrice.round()} USD',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFav(model.product.id);
                        },
                        icon:ShopCubit.get(context).favorites[model.product.id] == true? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
