var db=require('../dbconnection');

var Prtype={

getAllPrtypes:function(callback){

return db.query("Select * from prtype",callback);

},
getPrtypeById:function(id,callback){

    return db.query("select * from prtype where Id=?",[id],callback);
},
addPrtype:function(Prtype,callback){
return db.query("Insert into prtype(name) values(?)",[Prtype.name],callback);
},
deletePrtype:function(id,callback){
    return db.query("delete from prtype where Id=?",[id],callback);
},
updatePrtype:function(id,Prtype,callback){
    return  db.query("update prtype set name=? where id=?",[Prtype.name,id],callback);
},
deleteAll:function(item,callback){

var delarr=[];
   for(i=0;i<item.length;i++){

       delarr[i]=item[i].Id;
   }
   return db.query("delete from prtype where Id in (?)",[delarr],callback);
}
};
module.exports=Prtype;