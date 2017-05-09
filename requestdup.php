<?php
define('db_host','localhost');
define('db_user' ,'balaji');
define('db_pass', 'spiderman');
define('db_name','copper');


$link = mysql_connect(db_host, db_user, db_pass) or die('unable to connect'.mysql_error());
$db_selected=mysql_select_db(db_name,$link) or die('cant use'.db_name.':'.mysql_error());



$value=$_POST['request_id'];
$value1=$_POST['name'];
$value2=$_POST['area'];
$value3=$_POST['phone_number'];
$value5=$_POST['description'];
echo"  <center>Registered successfully <br>  YOUR ID is $value </center><br><br>";

$sql="insert into request(`REQUEST_ID`,`NAME`,`AREA`,`PHONE_NUMBER`,`DESCRIPTION`) values ('$value','$value1','$value2','$value3','$value5')";
if(!mysql_query($sql))
{echo "failure";
	die('error: '.mysql_error());
}
$TEMP=mysql_query("CALL priorityforrequest()");
$TEMP=mysql_query("CALL delreq()");

?>
<form name="backhome" action="requesthome.html" method="POST">
<center><input type="submit" value="Back"></center><br>
</form>
