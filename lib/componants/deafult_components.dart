import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../layout/cubit/cubit.dart';
import '../modules/login/login_screen.dart';
import '../shared/network/local/cahce_helper.dart';
import '../style/colors.dart';
String? token ='';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required void Function()? todofunction,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: todofunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void navigateTo (context , widget) => Navigator.push(
  context, MaterialPageRoute
  (
  builder: (context) =>  widget,
),
);
void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route)  // بقدر ارجع للسكرين الي قبلها ولا لا
      {
        return false;
      },
    );
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  void Function()? suffixPressed,
  required String label,
  bool isClickable = true,
  IconData? prefix,
  IconData? suffix,
  required dynamic validate,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      enabled: isClickable,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ) : null,
        border: const OutlineInputBorder(),
      ),
    );


void showToast({
  required String text,
  required ToastStates state,
})
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
// ignore: constant_identifier_names
enum ToastStates {SUCCESS , ERROR , WARNING} //لما يكون عندك كذا اختيار من اشي
Color chooseToastColor(ToastStates state)
{
  Color color;
switch(state) {
  case ToastStates.SUCCESS:
    color = Colors.green;
    break;
  case ToastStates.ERROR:
    color = Colors.red;
    break;
  case ToastStates.WARNING:
    color = Colors.amber;
    break;
}
return color;
}

void signOut (context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
    {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text)// هاي ميثود بتطبع التكست بشكل كامل في الكونسول
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>match.group(0));
}

Widget myDivider() => Padding(
  padding:  const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildListProduct(model, context,{bool isOldPrice = true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        SizedBox(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(
                model.image,
              ),
                width: double.infinity,
                height: 120.0,
              ),
              if(model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child: const Text('Discount',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),

            ],
          ),
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name,

                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text('${model.price}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount !=0 && isOldPrice)
                    Text('${model.oldPrice}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon:  CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                      child: const Icon(Icons.favorite_border,
                        color: Colors.white,
                        size: 14.0,
                      ),
                    ),
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