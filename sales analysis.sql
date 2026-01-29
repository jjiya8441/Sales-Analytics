select * from samplesuperstore;

-- What are the total sales, total profit, and overall profit margin?--
select region, Sum(sales) as total_Sales, sum(profit) as total_profit, round(sum(profit)/sum(sales)*100,2) as profit_margin
from samplesuperstore
group by region
order by profit_margin ASC;

-- Which regions generate the highest sales and profit? --


-- Which regions generate the highest sales and profit?--
SELECT
    Region,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM samplesuperstore
GROUP BY Region
ORDER BY
    total_sales DESC,
    total_profit DESC;
    
-- Which regions have high sales but low profit margins?--
SELECT
    Region,
   Round(SUM(Sales),2) AS total_sales,
    Round(SUM(Profit),2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin
FROM samplesuperstore
GROUP BY Region
ORDER BY
    total_sales DESC,
    profit_margin ASC;

-- Which product categories and sub-categories are most profitable?--

SELECT
    Category,
    `Sub-Category`,
 Round(SUM(Sales),2) AS total_sales,
    Round(SUM(Profit),2) AS total_profit
FROM samplesuperstore
GROUP BY
    Category,
    `Sub-Category`
ORDER BY
    total_profit DESC;
    
-- Which products contribute the most to total revenue? (Top 10)--
SELECT
    Product_Name,
    SUM(Sales) AS total_revenue
FROM samplesuperstore
GROUP BY Product_Name
ORDER BY total_revenue DESC
LIMIT 10;

-- Which products generate high sales but low or negative profit?--
SELECT
    Product_Name,
Round(SUM(Sales),2) AS total_sales,
    Round(SUM(Profit),2) AS total_profit
FROM samplesuperstore
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY total_sales DESC;



-- What is the profit margin by category and region?--
SELECT
    Region,
    Category,
    Round(SUM(Sales),2) AS total_sales,
    Round(SUM(Profit),2) AS total_profit,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2) AS profit_margin
FROM samplesuperstore
GROUP BY Region, Category
ORDER BY profit_margin DESC;

-- How does discounting impact profit margins?--
SELECT 
    Discount,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin
FROM samplesuperstore
GROUP BY Discount
ORDER BY Discount;

-- What is the average discount offered by category?--
SELECT 
    Category,
    ROUND(AVG(Discount), 2) AS Avg_Discount
FROM samplesuperstore
GROUP BY Category
ORDER BY Avg_Discount DESC;

-- Who are the top customers by revenue and by profit?--
SELECT 
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM samplesuperstore
GROUP BY Customer_Name
ORDER BY total_sales DESC;

-- What is the average order value (AOV)?--
SELECT 
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS avg_order_value
FROM samplesuperstore;

-- Which products should be reviewed or discontinued?--
SELECT 
    Product_Name,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_pct
FROM samplesuperstore
GROUP BY Product_Name
HAVING 
    SUM(Profit) < 0
    AND SUM(Sales) < (
        SELECT AVG(product_sales)
        FROM (
            SELECT SUM(Sales) AS product_sales
            FROM samplesuperstore
            GROUP BY Product_Name
        ) avg_sales
    )
ORDER BY total_profit ASC;





