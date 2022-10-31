import 'package:carousel_slider/carousel_slider.dart';
import 'package:demoshopapp/controllers/home_cubit.dart';
import 'package:demoshopapp/data/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          cubit.homeData ?? cubit.getHomeData();
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: productsBuilder(cubit.homeData),
          );
        },
        listener: (context, state) {});
  }

  Widget productsBuilder(HomeModel? homeModel) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: homeModel!.data.banners
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
            SizedBox(
              height: 10,
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  homeModel.data.products.length,
                  (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Stack(

                              alignment: AlignmentDirectional.bottomStart,

                              children: [
                                Image.network(
                                  homeModel.data.products[index].image,
                                  fit: BoxFit.cover,
                                ),
                                if(homeModel.data.products[index].discount!=0)
                                Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 10),),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeModel.data.products[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${homeModel.data.products[index].price} \$',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                 const SizedBox(
                                    width: 7,
                                  ),
                                  if(homeModel.data.products[index].discount!=0)
                                  Text(
                                    '${homeModel.data.products[index].oldPrice} \$',
                                    style:const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),


                                  ),
                                const  Spacer(),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,size: 18,),),
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
            ),
          ],
        ),
      );
}
