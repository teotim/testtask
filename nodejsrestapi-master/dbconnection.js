var mysql=require('mysql');
var connection=mysql.createPool({

host:'85.17.194.186',
user:'admin_test',
password:'5c09IKbTEl',
database:'admin_nodetest'


});
module.exports=connection;