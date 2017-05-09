<?php
//Step1
 $db = mysqli_connect('localhost','balaji','spiderman','copper')
 or die('Error connecting to MySQL server.');
?>

<html>
 <head><title>COMPLAINT FORM</title>

 <meta charset="utf-8" />

 <link rel="stylesheet" href="style.css" type="text/css" media="all" />
 </head>
 <body>


   <h2>COMPLAINT FORM</h2>

   <form class="form" action="insert.php" method="GET">

     <p class="name">
       <input type="text" name="name" id="name" placeholder="John Doe" />
       <label for="name">Name</label>
     </p>

     <p class="email">
       <input type="text" name="email" id="email" placeholder="mail@example.com" />
       <label for="email">Email</label>
     </p>

     <p class="web">
       <input type="text" name="web" id="web" placeholder="www.example.com" />
       <label for="web">Website</label>
     </p>

     <p class="text">
       <textarea name="text" placeholder="Write something to us" /></textarea>
     </p>

     <p class="submit">
       <input type="submit" value="Send" />
     </p>
   </form>

   </body>
   </html>
