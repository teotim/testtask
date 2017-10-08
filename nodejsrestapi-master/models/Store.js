var db=require('../dbconnection');

var Store={

getAllStores:function(callback){

return db.query("Select * from store",callback);

},
getStoreById:function(id,callback){

    return db.query("select * from store where Id=?",[id],callback);
},
addStore:function(Store,callback){
return db.query("Insert into store(name,city) values(?,?)",[Store.name,Store.city],callback);
},
deleteStore:function(id,callback){
    return db.query("delete from store where Id=?",[id],callback);
},
updateStore:function(id,Store,callback){
    return  db.query("update store set name=?,city=? where id=?",[Store.name,Store.city,id],callback);
},
deleteAll:function(item,callback){

var delarr=[];
   for(i=0;i<item.length;i++){

       delarr[i]=item[i].Id;
   }
   return db.query("delete from store where Id in (?)",[delarr],callback);
}
};
module.exports=Store;