class order_model {
  order_model({
    //required this.orderId,
    required this.orderNumber,
    required this.weight,
    required this.serviceType,
    required this.deliveryCost,
    required this.recipientName,
    required this.paymentMethod,
    required this.parcelCount,
    required this.notes,
    required this.username,
    required this.lastUpdated,
  });

  //String orderId;
  String orderNumber;
  String weight;
  String serviceType;
  String deliveryCost;
  String recipientName;
  String paymentMethod;
  String parcelCount;
  String notes;
  String username;
  String lastUpdated;
}