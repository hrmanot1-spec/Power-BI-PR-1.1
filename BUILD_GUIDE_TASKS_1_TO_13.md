# Exact Assignment Build Guide — Tasks 1–13

> **Important data note:** The supplied CSV is a schema-complete synthetic practice dataset with 9,994 rows. Your assignment names the Kaggle Sample Superstore dataset. For a strict submission, replace the practice CSV with the official Kaggle file `vivek468/superstore-dataset-final` before building/refreshing. Keep the same 21 column names. The transformation script is designed for that 21-column schema.

## Task 1 — Connect to Data Source
1. Open Power BI Desktop → Home → Get Data → Text/CSV.
2. Select `data/Sample - Superstore_Practice.csv` (or the official Kaggle CSV).
3. Preview the data in Navigator and choose Transform Data.

## Task 2 — Explore Power Query Editor
1. Identify Queries pane (left), Data Preview (centre), Query Settings / Applied Steps (right).
2. View → enable Column Quality, Column Distribution and Column Profile.
3. Click a column and inspect the profiling summary; set profiling to entire dataset.

## Task 3 — Table Transformations
Use `power_query/Superstore_Cleaning.m` in Advanced Editor (change the file path first). Applied steps include: Source, Promoted Headers, Changed Types, Trim Text, Remove Blank Order IDs, Remove Null Critical Rows, Remove Duplicate Rows, Filter Segments, Split Order ID, Changed Split Types, Removed Unneeded Columns, Renamed Columns, Added Order Year, Added Order Month, Added Year Month, Reordered Columns.
- Segment filter: retain Consumer and Corporate; remove Home Office.
- Split Order ID by `-` into Order Prefix, Order Year Code and Order Number.
- Remove Row ID, Country and Postal Code.
- Close & Apply.

## Task 4 — Explore Fields Pane
In Report view, expand the Sales table. Identify fields and numeric fields. Drag Sales onto the canvas once to see Power BI's default visual, then delete it.

## Task 5 — Explore Visualizations Pane
Inspect Card, Clustered bar chart, Table, Slicer and other icons. Click an empty canvas, add a Card, then remove it.

## Task 6 — Create KPI Cards
Create exactly four Card visuals and place them in one horizontal row at the top:
1. Total Sales → `Sales[Sales]` aggregation Sum.
2. Total Profit → `Sales[Profit]` aggregation Sum.
3. Total Quantity → `Sales[Quantity]` aggregation Sum.
4. Average Discount → `Sales[Discount]` aggregation Average.
Formatting: label 10 pt; value 26–28 pt bold; Sales/Profit currency; Quantity whole number; Discount percentage with 1 decimal.

## Task 7 — Create Bar Charts
- Chart 1: Clustered bar chart; Y-axis Category; X-axis Sales (Sum); title `Total Sales by Product Category`.
- Chart 2: Clustered bar chart; Y-axis Region; X-axis Profit (Sum); title `Total Profit by Region`.
Turn Data labels ON and sort descending by the measure.

## Task 8 — Format Visuals
- Titles: meaningful, 12–14 pt, charcoal.
- Palette: primary Red `#C00000`; secondary Charcoal `#4A4A4A`.
- Data labels: 10 pt; Sales/Profit display units Auto (K/M).
- KPI values: 26–28 pt, bold, charcoal.
- Add a subtitle to at least one visual, e.g. `FY2014–FY2017 | Consumer & Corporate`.
- Remove unnecessary gridlines, especially vertical gridlines on bar charts.

## Task 9 — Add Slicers
Add two slicer visuals below the title/header: Region and Category. Set each to Dropdown or List. Test selecting a Region and then a Category; all relevant visuals should respond.

## Task 10 — Configure Filter Panel
- Page-level filter: Ship Mode → select Standard Class and Second Class only.
- Visual-level filter on a bar chart: Sub Category → Basic filtering → Top N → Top 5 by Sales → Apply filter.
- Test the filters together with both slicers and verify there is no conflict.

## Task 11 — Report Page Formatting
- Format page → Canvas settings → 16:9 (1280 × 720).
- Canvas background: light grey `#F5F5F5`.
- View → Snap to grid ON; Gridlines ON.
- Align visuals and use consistent margins/gaps.
- Add Page 2 named `Order Details`; add a Table visual with Order ID, Order Date, Ship Mode, Customer Name, Segment, Region, Category, Sub Category, Product Name, Sales, Quantity, Discount and Profit. Use consistent styling.

## Task 12 — Apply Built-in Theme
Use View → Themes → choose a built-in professional theme (e.g. Executive / accessible built-in choice in your Desktop version). Do not import the supplied JSON if the assessor specifically requires a built-in theme. Ensure the theme is visibly applied across both pages.

## Task 13 — Configure Visual Interactions (Cross-filtering)
On Page 1:
1. Select `Total Sales by Product Category` bar chart.
2. Format → Edit interactions.
3. On `Total Profit by Region`, select the Filter (funnel) interaction.
4. On all four KPI cards, select Highlight (or Filter if Highlight is unavailable for that visual).
5. Select `Total Profit by Region` and set its interaction with the Sales by Category chart to Filter.
6. Select each slicer and verify it filters both charts and all KPI cards.
7. Test by clicking Technology in the category chart and verify Region profit and KPI values update. Clear the selection.
8. Confirm at least three visual pairs have intentional interactions. Exit Edit interactions.

## Suggested page layout
Page 1: title/header; four KPI cards in a row; Region and Category slicers; two bar charts; optional subtitle. Page 2: consistent title/header and detailed order table.
