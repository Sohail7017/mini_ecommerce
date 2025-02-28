part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

/// VIEW PRODUCT DATA

class ViewProductEvent extends ProductEvent{}
