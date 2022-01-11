import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projet_flutter/data/providers/remote/storage_firestore.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key, required this.name, }) : super(key: key);

  final String name;

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  TextEditingController opinionController = TextEditingController();
  double ratingController = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opinion"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text("Rating",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingController = rating;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Give your opinion : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: TextFormField(
                  controller: opinionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: AddToCartButton(
                  trolley: Image.asset(
                    'assets/images/trone.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  text: const Text(
                    'Post opinion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  check: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(24),
                  backgroundColor: Colors.blue,
                  onPressed: (id) {
                    if (id == AddToCartButtonStateId.idle) {
                      StorageHelper().saveOpinion(opinion: opinionController.text, rating: ratingController, character: widget.name);
                      setState(() {
                        stateId = AddToCartButtonStateId.loading;
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            stateId = AddToCartButtonStateId.done;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    } else if (id == AddToCartButtonStateId.done) {
                      setState(() {
                        stateId = AddToCartButtonStateId.idle;
                      });
                    }
                  },
                  stateId: stateId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
