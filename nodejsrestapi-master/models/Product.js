var db=require('../dbconnection');

var Product={

getAllProducts:function(callback){

return db.query("Select p.id as  id, p.name as name, pt.name as type, p.ptid as ptid from product p inner join prtype pt on pt.id=p.ptid",callback);

},
getProductById:function(id,callback){

    return db.query("SELECT s.id as id,s.name, p.price FROM store s left join prices p on p.stid = s.id and p.prid=?",[id],callback);
},
addProduct:function(Product,callback){
return db.query("call sp_setprod(?,?,0)",[Product.name,Product.ptid],callback);

},
deleteProduct:function(id,callback){
    return db.query("call sp_delpr(?)",[id],callback);
},
updateProduct:function(id,Product,callback){
    return  db.query("call sp_setprod(?,?,?)",[Product.name,Product.ptid,id],callback);
},
setPrice:function(id,Product,callback){
	return  db.query("call sp_setprice(?,?,?)",[id,Product.store,Product.price],callback);
}
};
module.exports=Product;