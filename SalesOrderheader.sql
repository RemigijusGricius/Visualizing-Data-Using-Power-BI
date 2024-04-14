SELECT
  SalesOrderID,
  CustomerID,
  OrderDate,
  LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
  DATE_DIFF(LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate), OrderDate, DAY) AS daysbetweenorders,
  TotalDue,
  SalesOrdersHeader.TerritoryID,
  SalesPersonID,
  province.stateprovincecode AS ship_province,
  province.CountryRegionCode AS country_code,
  province.name AS country_state_name
FROM
  `adwentureworks_db.salesorderheader` AS SalesOrdersHeader
JOIN
  `tc-da-1.adwentureworks_db.address` AS Address
ON
  SalesOrdersHeader.ShipToAddressID = Address.AddressID
JOIN
  `tc-da-1.adwentureworks_db.stateprovince` AS province
ON
  Address.StateProvinceID = province.StateProvinceID
ORDER BY
  CustomerID,
  OrderDate;
