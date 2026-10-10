CREATE DATABASE superstore_analysis;
USE superstore_analysis;
SELECT COUNT(*) AS Total_Rows
FROM superstore;
select * from superstore;

ALTER TABLE superstore
RENAME COLUMN ï»¿Row_ID TO Row_ID;

SELECT Discount,Discount * 100 AS Discount_Percentage
FROM superstore
LIMIT 10;
-- =================================================================
                -- 1. OVERALL KPI
-- =================================================================
SELECT SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM superstore;
-- =================================================================
                -- 2️. Category Analysis
-- =================================================================
-- 1. Sales by Category

SELECT Category,ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 2. Profit by Category

SELECT Category, ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

-- 3. Sales by Sub-Category

SELECT Sub_Category,ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

-- =================================================================
                -- 3.Regional Analysis
-- =================================================================
-- 1. Sales by Region

SELECT Region,ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 2. Profit by Region 

SELECT Region, ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Region
ORDER BY Total_Profit DESC;

-- 3. State-wise Performance

SELECT State, ROUND(SUM(Sales), 2) AS Total_Sales,ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY State
ORDER BY Total_Profit DESC;
-- =================================================================
                -- 4.Customer Analysis
-- =================================================================
-- 1. Top 10 Customers by Sales

SELECT Customer_Name,ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- 2. Customer-wise Sales & Profit

SELECT Customer_Name, ROUND(SUM(Sales), 2) AS Total_Sales, ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;

-- =================================================================
                -- 5.Product Analysis
-- =================================================================
-- 1. Top 10 Products

SELECT Product_Name, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- 2. Bottom 10 Products

SELECT Product_Name, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Sales ASC
LIMIT 10;

-- 3. Most Profitable Products

SELECT Product_Name, ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- 4. Loss-Making Products

SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-- =================================================================
                -- 6.Shipping Analysis
-- =================================================================
-- 1. Sales by Ship Mode

SELECT
    Ship_Mode,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;

-- 2. Average Shipping Days

SELECT
    Ship_Mode,
    ROUND(AVG(Shipping_Days), 2) AS Average_Shipping_Days
FROM superstore
GROUP BY Ship_Mode
ORDER BY Average_Shipping_Days;
-- =================================================================
                -- 7.Payment Analysis
-- =================================================================


SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;
-- =================================================================
                -- 8.Discount vs Profit Analysis
-- =================================================================
SELECT 
	Discount,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Profit), 2) AS Average_Profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- =================================================================
                -- 9.Discount Vs Profit Margin
-- =================================================================

SELECT Discount,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Discount
ORDER BY Discount;