

<html>
<body><center>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');

$query = "SELECT * FROM police_station";
mysqli_query($db, $query) or die('Error querying database.');

$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

echo "<h1><center>DETAILS</CENTER></H1>";

echo " <TABLE width='400' border=1 align=center color=800000>

<TR>

<TH width='5' bgColor=#89EFFE align=middle><pre>STATION NAME</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>PHONE NUMBER</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>ADDRESS</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>STATION AREA</TH>
</TR>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo "<tr>
<td>".$row['STATION_NAME']."</td>
<td>".$row['PHONE_NUMBER']."</td>
<td>".$row['ADDRESS']."</td>
<td>".$row['STATION_AREA']."</td>
</tr>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

while($row=mysqli_fetch_array($result))
{
echo " <tr>
<td>".$row['STATION_NAME']."</td>
<td>".$row['PHONE_NUMBER']."</td>
<td>".$row['ADDRESS']."</td>
<td>".$row['STATION_AREA']."</td>
</tr>";


}
echo" </Table><br><br><br>";





 ?><center><form action="areas.php"><input type="submit" style="color:black " value="VIEW ALL AREAS" /></form><br><br><p>
</center>
 </body>
 </html>
