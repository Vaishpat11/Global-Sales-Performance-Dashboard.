
DATA CLEANING AND INTEGRATION FOR GLOBAL SALES PERFORMANCE DASHBOARD


Step 1: Clean the dataset
SELECT *
INTO cleaned_sales
FROM global_superstore
WHERE Sales IS NOT NULL AND Profit IS NOT NULL;


Step 2: Summarize total sales and profit by region
SELECT Region,
       ROUND(SUM(Sales), 2) AS Total_Sales,
       ROUND(SUM(Profit), 2) AS Total_Profit
INTO regional_performance
FROM cleaned_sales
GROUP BY Region;


Step 3: Analyze discount impact by country
SELECT Country,
       ROUND(AVG(Discount), 3) AS Avg_Discount,
       ROUND(SUM(Profit), 2) AS Total_Profit
INTO discount_impact
FROM cleaned_sales
GROUP BY Country;


Step 4: Integrate data for Power BI analysis
SELECT c.*,
       r.Total_Sales,
       r.Total_Profit AS Regional_Profit,
       d.Avg_Discount
INTO final_sales_data
FROM cleaned_sales c
JOIN regional_performance r ON c.Region = r.Region
JOIN discount_impact d ON c.Country = d.Country;
