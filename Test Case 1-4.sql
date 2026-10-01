-- Test Case 1: Data Quality Check (ตรวจสอบว่ามี Email ผู้ใช้คนไหนรูปแบบไม่ถูกต้อง)
SELECT UserID, Username, Email 
FROM Users 
WHERE Email NOT LIKE '%@%.%';

-- Test Case 2: Business Logic / Edge Case (ตรวจสอบสินค้าที่สต็อกเป็น 0 หรือเหลือน้อยกว่าปกติ)
SELECT ProductID, ProductName, StockQuantity 
FROM Products 
WHERE StockQuantity <= 0;

-- Test Case 3: Data Integrity Check (ตรวจสอบว่ามี Order ไหนอ้างอิง UserID ที่ไม่มีจริงในระบบ)
SELECT o.OrderID, o.UserID, o.TotalAmount 
FROM Orders o
LEFT JOIN Users u ON o.UserID = u.UserID
WHERE u.UserID IS NULL;

-- Test Case 4: Business Logic Verification (คำนวณยอดเงินรวม)
SELECT 
    o.OrderID,
    o.TotalAmount AS ReportedTotal,
    p.Price AS ItemPrice,
    (o.TotalAmount - p.Price) AS Discrepancy
FROM Orders o
JOIN Products p ON o.OrderID = p.ProductID
WHERE o.TotalAmount != p.Price;