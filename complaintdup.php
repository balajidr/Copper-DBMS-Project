
<?php
define('db_host','localhost');
define('db_user' ,'balaji');
define('db_pass', 'spiderman');
define('db_name','copper');



$link = mysql_connect(db_host, db_user, db_pass) or die('unable to connect'.mysql_error());
$db_selected=mysql_select_db(db_name,$link) or die('cant use'.db_name.':'.mysql_error());


$value=$_POST['complaint_id'];
$value1=$_POST['name'];
$value2=$_POST['area'];
$value3=$_POST['phone_number'];
$value5=$_POST['description'];
echo"  <center>Registered successfully <br>  YOUR ID is $value </center><br><br>";

$sql="insert into COMPLAINT(`COMPLAINT_ID`,`NAME`,`AREA`,`PHONE_NUMBER`,`DESCRIPTION`) values ('".$value."','".$value1."','".$value2."','".$value3."','".$value5."')";

if(!mysql_query($sql))
{
	die('error: '.mysql_error());
}
$TEMP=mysql_query("CALL priorityforcomplaint()");
$TEMP=mysql_query("CALL delcomp()");

?>
<form name="backhome" action="complainthome.html" method="POST">
<center><input type="submit" value="Back"></center><br>
</form>
