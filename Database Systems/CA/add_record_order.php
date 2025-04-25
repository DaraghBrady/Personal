<!DOCTYPE html>
<html>
    <head>
        <title>ADD Record Orders</title>
        <meta charset="UTF-8">
    </head>

    <body>
        <h1>Trying to add record to Orders</h1>

        <?php

            include("db_connect.php");

            $orderDate=$_POST["orderDate"];
            $orderID=$_POST["orderID"];
            $customerID=$_POST["customerID"];

        ?>
            
        <?php
            $sql = "INSERT INTO Orders (order_date, order_id, customer_id) VALUES (:orderDate, :orderID, :customerID)";
            $stmt = $db->prepare($sql);

            // Bind parameters
            $stmt->bindValue(':orderDate', $orderDate);
            $stmt->bindValue(':orderID', $orderID);
            $stmt->bindValue(':customerID', $customerID);
            
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