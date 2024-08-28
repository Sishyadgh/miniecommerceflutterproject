import 'package:ecommerce_app/Providers/FavouriteProvider.dart';
import 'package:ecommerce_app/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/Product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  ProductCardState createState() =>  ProductCardState();
}

class  ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
   // print(widget.product.image); debugging
    final provider = FavouriteProvider.of(context);

    return Container(
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey.withOpacity(0.1),
      ),
      child:  Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
onTap: ()=>provider.toggleFavourite(widget.product),
                child:  Icon(
                  provider.isExist(widget.product)?
                      Icons.favorite: Icons.favorite_border_outlined,
                  color: Colors.red,
                ),

              ),

            ],
          ),
          SizedBox(
            height: 130,
            width: 130,
            child: Image.asset(widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(widget.product.name,
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(widget.product.category,
            style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.red),),
          Text('\$''${widget.product.price}',style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
