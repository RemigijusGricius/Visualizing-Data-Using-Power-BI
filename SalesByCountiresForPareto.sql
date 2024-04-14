WITH
  UpdatedSales AS (
  SELECT
    DISTINCT SalesOrderID,
    SUM(LineTotal) AS TotalSales
  FROM
    `adwentureworks_db.salesorderdetail`
  GROUP BY
    SalesOrderID ),
  TerritorySales AS (
  SELECT
    Territory.TerritoryID AS TerritoryID,
    CONCAT(Territory.CountryRegionCode, ' ', Territory.Name) AS TerritoryName,
    SUM(UpdatedSales.TotalSales) AS Locationrevenue
  FROM
    `adwentureworks_db.salesorderheader` AS SalesOrderHeader
  JOIN
    `adwentureworks_db.salesterritory` AS Territory
  ON
    SalesOrderHeader.TerritoryID = Territory.TerritoryID
  JOIN
    UpdatedSales
  ON
    SalesOrderHeader.SalesOrderID = UpdatedSales.SalesOrderID
  GROUP BY
    Territory.CountryRegionCode,
    Territory.Name,
    Territory.TerritoryID ),
  TotalRevenue AS (
  SELECT
    SUM(Locationrevenue) AS TotalSales
  FROM
    TerritorySales )
SELECT
  TerritorySales.TerritoryID,
  TerritoryName,
  Locationrevenue,
  RANK() OVER (ORDER BY Locationrevenue DESC) AS Ranking,
  SUM(Locationrevenue) OVER (ORDER BY Locationrevenue DESC) AS Cumulative,
  TotalRevenue.TotalSales AS Total_sales,
  SUM(Locationrevenue) OVER (ORDER BY Locationrevenue DESC) / TotalRevenue.TotalSales * 100 AS Cumulative_Percent
FROM
  TerritorySales
CROSS JOIN
  TotalRevenue
ORDER BY
  Locationrevenue DESC;
