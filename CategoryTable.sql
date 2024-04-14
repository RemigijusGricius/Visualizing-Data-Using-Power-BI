SELECT
  SalesOrderDetail.SalesOrderID AS SalesOrderID,
  Category.Name AS CategoryName,
  Subcategory.Name AS SubCategoryName,
  SalesOrderDetail.LineTotal AS OrderTotalByCategory,
  Product.Size AS ProductSize,
  Product.Color AS ProductColor
FROM
  `adwentureworks_db.salesorderdetail` AS SalesOrderDetail
JOIN
  `adwentureworks_db.specialofferproduct` AS SpecialOffer
ON
  SalesOrderDetail.ProductID = SpecialOffer.ProductID
  AND SalesOrderDetail.SpecialOfferID = SpecialOffer.SpecialOfferID
JOIN
  `adwentureworks_db.product` AS Product
ON
  SpecialOffer.ProductID = Product.ProductID
JOIN
  `adwentureworks_db.productsubcategory` AS Subcategory
ON
  Product.ProductSubcategoryID = Subcategory.ProductSubcategoryID
JOIN
  `adwentureworks_db.productcategory` AS Category
ON
  Subcategory.ProductCategoryID = Category.ProductCategoryID
