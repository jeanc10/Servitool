import 'package:flutter/material.dart';
import 'package:servitools_app/models/Farmer.dart';
import 'package:servitools_app/screen/home/homeDash.dart';
class FarmerCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Farmer farmerModel;

  const FarmerCard(
      {Key key, this.animationController, this.animation,this.farmerModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 16),
                child: InkWell(
                  onTap: () {
//                  Navigator.pushNamed(context, '/farmer_info', arguments: this.farmerModel.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDash(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 16),
                                      child: Text(
                                        'Nombre',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            //fontFamily: Font.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: Colors.brown),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 1),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    farmerModel.name,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 3,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      //fontFamily:
                                                      //Colors.fontName,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, top: 16),
                                      child: Text(
                                        'Teléfono',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            //fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color: Colors.brown),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 1),
                                                child: SizedBox(width: 100, child: Text(
                                                  farmerModel.telephone,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    //fontFamily: AppTheme.fontName,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.green,
                                                  ),
                                                ),)
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 8),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8, bottom: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Dirección',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                       // fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: SizedBox(
                                        width: 300,
                                        child: Text(
                                          farmerModel.address,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            //fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:Colors.white
                                            //AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
