<!DOCTYPE html>
<html>
    <head>
        <title>ADD Record Order/Product</title>
        <meta charset="UTF-8">
    </head>

    <body>
        <h1>Trying to add record to Order/Product</h1>

        <?php

            include("db_connect.php");

            $productID=$_POST["productID"];
            $orderID=$_POST["orderID"];
            $quantityOrdered=$_POST["quantityOrdered"];
            
        ?>
            
        <?php
            $sql = "INSERT INTO Order_Product (product_id, order_id, quantity_ordered) VALUES (:productID,:orderID,:quantityOrdered)";
            $stmt = $db->prepare($sql);

            // Bind parameters
            $stmt->bindValue(':productID', $productID);
            $stmt->bindValue(':orderID', $orderID);
            $stmt->bindValue(':quantityOrdered', $quantityOrdered);
            
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