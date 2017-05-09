<?php
define('db_host','localhost');
define('db_user' ,'balaji');
define('db_pass', 'spiderman');
define('db_name','copper');


$link = mysql_connect(db_host, db_user, db_pass) or die('unable to connect'.mysql_error());
$db_selected=mysql_select_db(db_name,$link) or die('cant use'.db_name.':'.mysql_error());


$value=$_POST['issue_id'];
$value1=$_POST['name'];
$value2=$_POST['area'];
$value3=$_POST['phone_number'];

echo"  <center>Registered successfully <br>  YOUR ID is $value </center><br><br>";

$sql="insert into traffic_issue(`ISSUE_ID`,`NAME`,`AREA`,`PHONE_NUMBER`) values ('$value','$value1','$value2','$value3')";
$TEMP=mysql_query("CALL deltraf()");
if(!mysql_query($sql))
{
	die('error: '.mysql_error());
}

$TEMP=mysql_query("CALL deltraf()");
?>
<form name="backhome" action="traffichome.html" method="POST">
<center><input type="submit" value="Back"></center><br>
</form>
