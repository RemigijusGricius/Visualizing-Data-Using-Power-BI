SELECT
  DISTINCT SalesOrderID,
  SUM (LineTotal) AS TotalSales
FROM
  `adwentureworks_db.salesorderdetail`
GROUP BY
  SalesOrderID
