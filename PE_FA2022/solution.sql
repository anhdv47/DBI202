-- question 2
SELECT
  si.StockItemID
 ,si.StockItemName
 ,si.SupplierID
 ,si.Color
FROM StockItems si
WHERE si.Color = 'Blue'
-- question 3
SELECT
  st.SupplierTransactionID
 ,s.SupplierID
 ,s.SupplierName
 ,st.TransactionDate
 ,st.TransactionAmount
FROM SupplierTransactions st
JOIN Suppliers s
  ON s.SupplierID = st.SupplierID8
WHERE st.TransactionDate >= '2013-02-01'
AND st.TransactionDate <= '2013-02-15'
-- question 4
SELECT
  si.StockItemID
 ,si.StockItemName
 ,s.SupplierID
 ,s.SupplierName
 ,si.OuterPackageID
 ,pt.PackageTypeName
  AS OuterOackageTypeName
 ,si.UnitPrice
FROM StockItems si
JOIN Suppliers s
  ON si.SupplierID = s.SupplierID
JOIN PackageTypes pt
  ON si.OuterPackageID = pt.PackageTypeID
WHERE si.StockItemID >= 135
ORDER BY OuterOackageTypeName ASC, si.StockItemName ASC

-- question 5
SELECT
  s.SupplierID
 ,s.SupplierName
 ,COUNT(po.SupplierID) AS NumberOfPurchaseOrders
FROM Suppliers s
LEFT JOIN PurchaseOrders po
  ON s.SupplierID = po.SupplierID
GROUP BY s.SupplierID
        ,s.SupplierName
ORDER BY NumberOfPurchaseOrders DESC

-- question 6
SELECT TOP 1
  si.UnitPackageID
 ,pt.PackageTypeName AS UnitPackageTypeName
 ,COUNT(si.UnitPackageID) AS NumberOfStockItems
FROM PackageTypes pt
JOIN StockItems si
  ON pt.PackageTypeID = si.UnitPackageID
GROUP BY si.UnitPackageID
        ,pt.PackageTypeName
HAVING COUNT(si.UnitPackageID) = (SELECT TOP 1
    COUNT(si.UnitPackageID) AS NumberOfStockItems
  FROM PackageTypes pt
  JOIN StockItems si
    ON pt.PackageTypeID = si.UnitPackageID
  GROUP BY si.UnitPackageID
          ,pt.PackageTypeName
  ORDER BY NumberOfStockItems ASC)
ORDER BY NumberOfStockItems ASC

-- question 7

SELECT
  rs2.PackageTypeID
 ,rs2.PackageTypeName
 ,rs1.NumberOfStockItems_UnitPackage
 ,rs2.NumberOfStockItems_OuterPackage
FROM (SELECT
    pt.PackageTypeID
   ,COUNT(si.UnitPackageID) AS NumberOfStockItems_UnitPackage
  FROM PackageTypes pt
  LEFT JOIN StockItems si
    ON pt.PackageTypeID = si.UnitPackageID
  WHERE pt.PackageTypeName IN ('Each', 'Carton', 'Packet', 'Pair', 'Bag', 'Box')
  GROUP BY pt.PackageTypeID) rs1
JOIN (SELECT
    pt.PackageTypeID
   ,pt.PackageTypeName
   ,COUNT(si.QuantityPerOuter) AS NumberOfStockItems_OuterPackage
  FROM PackageTypes pt
  LEFT JOIN StockItems si
    ON pt.PackageTypeID = si.OuterPackageID
  WHERE pt.PackageTypeName IN ('Each', 'Carton', 'Packet', 'Pair', 'Bag', 'Box')
  GROUP BY pt.PackageTypeID
          ,pt.PackageTypeName) rs2
  ON rs1.PackageTypeID = rs2.PackageTypeID
ORDER BY rs2.NumberOfStockItems_OuterPackage DESC, rs2.PackageTypeName

-- question 8
CREATE PROCEDURE Proc4 @stockItemID INT, @OrderYear INT, @numberOfPurchaseOrders INT OUTPUT
AS
  SELECT
    @numberOfPurchaseOrders = COUNT(po.PurchaseOrderID)
  FROM PurchaseOrders po
  JOIN PurchaseOrderLines pol
    ON po.PurchaseOrderID = pol.PurchaseOrderID
  WHERE pol.StockItemID = @stockItemID
  AND YEAR(po.OrderDate) = @OrderYear
GO

DECLARE @x INT
EXEC Proc4 95
          ,2013
          ,@x OUTPUT
SELECT
  @x AS NumberOfPurchaseOrders
-- question 9
DROP TRIGGER Tr4
CREATE TRIGGER Tr4
ON StockItems AFTER INSERT
AS
BEGIN
  SELECT
    i.StockItemID
   ,i.StockItemName
   ,i.OuterPackageID
   ,pt.PackageTypeName AS OuterPackageTypeName
   ,i.UnitPrice
   ,i.TaxRate
  FROM INSERTED i
  LEFT JOIN PackageTypes pt
    ON pt.PackageTypeID = i.OuterPackageID
END

INSERT into StockItems (StockItemID, StockItemName, UnitPackageID, OuterPackageID, QuantityPerOuter, IsChillerStock, TaxRate, UnitPrice, TypicalWeightPerUnit, Color)
  VALUES (308, N'T-shirt Red bull', 7, 6, 1, 0, 0.15, 10.5, 0.4, 4);

select * FROM StockItems si WHERE si.StockItemID = 308

-- question 10 
delete FROM PackageTypes WHERE PackageTypeID not IN (select si.OuterPackageID FROM StockItems si
JOIN PackageTypes pt ON si.OuterPackageID = pt.PackageTypeID
group BY si.OuterPackageID
UNION
select si.UnitPackageID FROM StockItems si
JOIN PackageTypes pt ON si.UnitPackageID = pt.PackageTypeID
GROUP BY si.UnitPackageID)