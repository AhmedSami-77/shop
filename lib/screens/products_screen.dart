import 'package:carousel_slider/carousel_slider.dart';
import 'package:demoshopapp/controllers/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          if (cubit.homeData != null && cubit.categoriesData != null) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: cubit.homeData!.data.banners
                        .map(
                          (e) => Image(
                            image: NetworkImage(e.image),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                        height: 250,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Image.network(
                                        cubit.categoriesData!.data.data[index]
                                            .image,
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        color: Colors.black.withOpacity(.8),
                                        width: 100,
                                        child: Text(
                                          cubit.categoriesData!.data.data[index]
                                              .name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                              itemCount:
                                  cubit.categoriesData!.data.data.length),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'New Products',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                          cubit.homeData!.data.products.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Image.network(
                                          cubit.homeData!.data.products[index]
                                              .image,
                                          fit: BoxFit.cover,
                                        ),
                                        if (cubit.homeData!.data.products[index]
                                                .discount !=
                                            0)
                                          Container(
                                            color: Colors.red,
                                            padding:const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: const Text(
                                              'DISCOUNT',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.homeData!.data.products[index]
                                            .name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${cubit.homeData!.data.products[index].price} \$',
                                            style:const TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          if (cubit.homeData!.data
                                                  .products[index].discount !=
                                              0)
                                            Text(
                                              '${cubit.homeData!.data.products[index].oldPrice} \$',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              print(cubit.homeData!.data
                                                  .products[index].id);
                                              cubit.changeFavorites(cubit.homeData!.data
                                                  .products[index].id);
                                            },
                                            icon: CircleAvatar(
                                              backgroundColor:
                                                  HomeCubit.get(context)
                                                              .favorites[
                                                          cubit
                                                              .homeData!
                                                              .data
                                                              .products[index]
                                                              .id]!
                                                      ? Colors.purple
                                                      : Colors.grey,
                                              radius: 15.0,
                                              child: Icon(
                                                Icons.favorite_border,
                                                color: Colors.white,
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {});
  }
}
