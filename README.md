# Ecommerce-database-testing-SQL
โปรเจกต์ทดสอบฐานข้อมูล E-Commerce โดยการเขียน SQL Verification Queries เพื่อตรวจจับข้อผิดพลาด และทำรายงาน Bug Report

# 🛒 โปรเจกต์ทดสอบฐานข้อมูล E-Commerce (Database Testing & Verification)

![SQL Server](https://img.shields.io/badge/Database-MS%20SQL%20Server-blue)
![SSMS](https://img.shields.io/badge/Tool-SSMS-orange)
![Google Sheets](https://img.shields.io/badge/Reporting-Google%20Sheets-green)
![Role](https://img.shields.io/badge/Role-Software%20Tester%20%2F%20QA-brightgreen)

## ภาพรวมโปรเจกต์ (Overview)
โปรเจกต์จำลองการทดสอบฐานข้อมูล (Database Testing) สำหรับระบบ E-Commerce โดยเน้นการออกแบบโครงสร้างตาราง (Database Schema) การเตรียมข้อมูลจำลอง (Mock Data) และการเขียน **SQL Queries** เพื่อตรวจจับข้อผิดพลาดของข้อมูล (Data Quality, Data Integrity, Edge Cases และ Business Logic Validation)[cite: 1, 2, 3, 4, 5, 6]

## เครื่องมือและเทคโนโลยีที่ใช้ (Tools & Technologies)
* **ระบบจัดการฐานข้อมูล (DBMS):** Microsoft SQL Server[cite: 1]
* **เครื่องมือจัดการ (GUI Tool):** SQL Server Management Studio (SSMS)[cite: 1]
* **การทำรายงานและเอกสาร (Reporting):** Google Sheets[cite: 7]
* **คำสั่ง SQL ที่ใช้:** `JOIN` (LEFT/INNER), `WHERE`, `LIKE`, `IS NULL`, การคำนวณเปรียบเทียบข้อมูล

## โครงสร้างฐานข้อมูล (Database Schema)
ฐานข้อมูลจำลองประกอบด้วย 3 ตารางหลัก:
1. **`Users`**: เก็บข้อมูลผู้ใช้งาน (`UserID`, `Username`, `Email`, `CreatedDate`)[cite: 2]
2. **`Products`**: เก็บข้อมูลรายการสินค้า (`ProductID`, `ProductName`, `Price`, `StockQuantity`)[cite: 2]
3. **`Orders`**: เก็บข้อมูลคำสั่งซื้อ (`OrderID`, `UserID`, `OrderDate`, `TotalAmount`)[cite: 2]

## เคสการทดสอบและ SQL สคริปต์ (Test Scenarios & SQL Queries)
## 1. Data Quality Check: ตรวจสอบรูปแบบ Email ผู้ใช้งาน
 **วัตถุประสงค์:** ตรวจสอบว่ามีข้อมูลผู้ใช้งานที่บันทึกรูปแบบ Email ไม่ถูกต้องตามมาตรฐานหรือไม่
 
```sql
SELECT UserID, Username, Email 
FROM Users 
WHERE Email NOT LIKE '%@%.%';
```

## 2. Business Logic Check: ตรวจสอบสินค้าที่สต็อกหมด
**วัตถุประสงค์: ตรวจสอบรายการสินค้าที่มีจำนวนสต็อกเป็น 0 เพื่อยืนยันการเปลี่ยนสถานะเป็น Out of Stock[cite: 6]**

```sql
SELECT ProductID, ProductName, StockQuantity 
FROM Products 
WHERE StockQuantity <= 0;
```

## 3. Data Integrity Check: ตรวจสอบคำสั่งซื้อกำพ้อง (Orphan Records)
**วัตถุประสงค์: ตรวจสอบว่ามีรายการ Orders ใดบ้างที่อ้างอิงถึง UserID ที่ไม่มีตัวตนจริงในระบบ[cite: 6]**

```sql
SELECT o.OrderID, o.UserID, o.TotalAmount 
FROM Orders o
LEFT JOIN Users u ON o.UserID = u.UserID
WHERE u.UserID IS NULL;
```

## 4. Business Logic Check: ตรวจสอบยอดรวมคำสั่งซื้อ
**วัตถุประสงค์: ตรวจสอบความถูกต้องของการคำนวณยอดเงินรวม (TotalAmount) เทียบกับราคาสินค้าจริง**

```sql
SELECT 
    o.OrderID,
    o.TotalAmount AS ReportedTotal,
    p.Price AS ItemPrice,
    (o.TotalAmount - p.Price) AS Discrepancy
FROM Orders o
JOIN Products p ON o.OrderID = p.ProductID
WHERE o.TotalAmount != p.Price;
```
## ลิงก์รายงานฉบับเต็ม (Live Reports)
## รายงาน Bug Report และ Schema บน Google Sheets: ดูรายงานฉบับเต็ม https://docs.google.com/spreadsheets/d/1S7haySpTXqFFp9vpX3vkCCKobKwrUlyJBQG-tR_dGwg/edit?usp=sharing
