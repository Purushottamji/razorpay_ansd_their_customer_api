class CustomerApiModel {
  int? count;
  String? entity;
  List<ItemsData>? items;

  CustomerApiModel(this.entity,this.count,this.items);
  static CustomerApiModel fromJson(Map<String,dynamic> json){
    var list=json['items'] as List;
    List<ItemsData> itemsData=list.map((e) => ItemsData.fromJson(e),).toList();
    return CustomerApiModel(json['entity'], json['count'], itemsData);
  }
}

class ItemsData{
  String? id;
  String? entity;
  String? name;
  String? email;
  String? contact;
  String? gstin;
  int? createdAt;
  
  ItemsData(this.id,this.entity,this.name,this.contact,this.email,this.gstin,this.createdAt);
  static ItemsData fromJson(Map<String,dynamic> json){
    return ItemsData(json['id'], json['entity'], json['name'], json['contact'], json['email'], json['gstin'], json['created_at']);
  }
}