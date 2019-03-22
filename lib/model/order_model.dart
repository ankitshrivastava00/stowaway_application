class OrderModel{
  final String Id,Commodity,Receving_Address,Delivery_Address,Giver_Name,Giver_Phone,
      Recevier_Phone,Recevier_Name,Recevier_Email,Price,Date,Weight;
  OrderModel({this.Id,this.Commodity,this.Receving_Address,this.Delivery_Address
    , this.Giver_Name,this.Giver_Phone,this.Recevier_Phone,this.Recevier_Name,this.Recevier_Email,this.Price,this.Weight,this.Date});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return new OrderModel(
      Id: json['_id'],
      Commodity: json['Commodity'],
      Receving_Address: json['Receving_Address'],
      Delivery_Address: json['Delivery_Address'],
      Giver_Name: json['Giver_Name'],
      Giver_Phone: json['Giver_Phone'],
      Recevier_Phone: json['Recevier_Phone'],
      Recevier_Name: json['Recevier_Name'],
      Recevier_Email: json['Recevier_Email'],
      Price: json['Price'],
      Weight: json['Weight'],
      Date: json['Date'],

    );
  }
}