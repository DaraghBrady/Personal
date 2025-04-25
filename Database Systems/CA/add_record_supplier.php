<!DOCTYPE html>
<html>
    <head>
        <title>ADD Record Supplier</title>
        <meta charset="UTF-8">
    </head>

    <body>
        <h1>Trying to add record to Suppliers</h1>

        <?php

            include("db_connect.php");

            $supplierID=$_POST["supplierID"];
            $supplierName=$_POST["supplierName"];
            $supplierAddress=$_POST["supplierAddress"];
            $supplierTelephoneNumber=$_POST["supplierTelephoneNumber"];


        ?>
            
        <?php
            $sql = "INSERT INTO Suppliers (supplier_id, supplier_name, supplier_telephone_number, supplier_address) VALUES (:supplierID, :supplierName, :supplierTelephoneNumber, :supplierAddress)";
            $stmt = $db->prepare($sql);

            // Bind parameters
            $stmt->bindValue(':supplierID', $supplierID);
            $stmt->bindValue(':supplierName', $supplierName);
            $stmt->bindValue(':supplierTelephoneNumber', $supplierTelephoneNumber);
            $stmt->bindValue(':supplierAddress', $supplierAddress);

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