<!DOCTYPE html>
<html>
    <head>
        <title>ADD Record Customer</title>
        <meta charset="UTF-8">
    </head>

    <body>
        <h1>Trying to add record to Customers</h1>

        <?php

            include("db_connect.php");

            $customerID=$_POST["customerID"];
            $customerName=$_POST["customerName"];
            $customerAddress=$_POST["customerAddress"];
            $customerEmail=$_POST["customerEmail"];


        ?>
            
        <?php
            $sql = "INSERT INTO Customers (customer_id, customer_name, customer_email, customer_address) VALUES (:customerID, :customerName, :customerEmail, :customerAddress)";
            $stmt = $db->prepare($sql);

            // Bind parameters
            $stmt->bindValue(':customerID', $customerID);
            $stmt->bindValue(':customerName', $customerName);
            $stmt->bindValue(':customerEmail', $customerEmail);
            $stmt->bindValue(':customerAddress', $customerAddress);

            // Execute the statement
            $result = $stmt->execute();

            if ($result) {
                echo "Record added successfully";
            } else {
                echo "Error: Unable to add record";
            }
            $stmt->closeCursor();
        ?>







  

        <input type="button" onclick="window.location.href = 'index.html'" value="Home" />
    </body>
</html>