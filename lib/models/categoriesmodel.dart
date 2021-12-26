class CategoriesModel {
  late bool status ;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String,dynamic> json){

    status=json['status'];
    data=CategoriesDataModel.formJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data=[] ;

  CategoriesDataModel.formJson(Map<String,dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });

  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }

}