import 'package:demoshopapp/controllers/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  state is FavoritesLoadingDataState?const Center(child: CircularProgressIndicator(),): HomeCubit.get(context).favoritesModel!.data.data.isEmpty?const Center(child: Icon(Icons.no_sim_rounded,color: Colors.purple,size: 150,),): ListView.separated(
              itemBuilder: (context, index) => Row(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image.network(
                              HomeCubit.get(context)
                                  .favoritesModel!
                                  .data
                                  .data[index]
                                  .product
                                  .image,
                              fit: BoxFit.cover,
                            ),
                            if (HomeCubit.get(context)
                                    .favoritesModel!
                                    .data
                                    .data[index]
                                    .product
                                    .discount !=
                                0)
                              Container(
                                color: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeCubit.get(context)
                                  .favoritesModel!
                                  .data
                                  .data[index]
                                  .product
                                  .description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${HomeCubit.get(context).favoritesModel!.data.data[index].product.price} \$',
                                  style:
                                      const TextStyle(color: Colors.blueAccent),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                if (HomeCubit.get(context)
                                        .favoritesModel!
                                        .data
                                        .data[index]
                                        .product
                                        .discount !=
                                    0)
                                  Text(
                                    '${HomeCubit.get(context).favoritesModel!.data.data[index].product.oldPrice} \$',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).changeFavorites(
                                        HomeCubit.get(context)
                                            .favoritesModel!
                                            .data
                                            .data[index]
                                            .product
                                            .id);
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor:
                                        HomeCubit.get(context).favorites[
                                                    HomeCubit.get(context)
                                                        .favoritesModel!
                                                        .data
                                                        .data[index]
                                                        .product
                                                        .id] ??
                                                true
                                            ? Colors.purple
                                            : Colors.grey,
                                    radius: 15.0,
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  HomeCubit.get(context).favoritesModel!.data.data.length);
        },
      ),
    );
  }
}
