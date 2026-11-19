let
    // Change this path to the extracted CSV file on your computer.
    Source = Csv.Document(File.Contents("C:\PowerBI\Sample - Superstore_Practice.csv"), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders,{
        {"Row ID", Int64.Type}, {"Order ID", type text}, {"Order Date", type date}, {"Ship Date", type date},
        {"Ship Mode", type text}, {"Customer ID", type text}, {"Customer Name", type text}, {"Segment", type text},
        {"Country", type text}, {"City", type text}, {"State", type text}, {"Postal Code", type text},
        {"Region", type text}, {"Product ID", type text}, {"Category", type text}, {"Sub-Category", type text},
        {"Product Name", type text}, {"Sales", Currency.Type}, {"Quantity", Int64.Type},
        {"Discount", Percentage.Type}, {"Profit", Currency.Type}
    }, "en-US"),
    TrimText = Table.TransformColumns(ChangedTypes,{
        {"Order ID", Text.Trim, type text}, {"Ship Mode", Text.Trim, type text},
        {"Segment", Text.Trim, type text}, {"Region", Text.Trim, type text},
        {"Category", Text.Trim, type text}, {"Sub-Category", Text.Trim, type text}
    }),
    RemoveBlankOrderIDs = Table.SelectRows(TrimText, each [Order ID] <> null and [Order ID] <> ""),
    RemoveNullCriticalRows = Table.SelectRows(RemoveBlankOrderIDs, each [Order Date] <> null and [Sales] <> null and [Profit] <> null),
    RemoveDuplicateRows = Table.Distinct(RemoveNullCriticalRows, {"Row ID"}),
    FilterSegments = Table.SelectRows(RemoveDuplicateRows, each [Segment] = "Consumer" or [Segment] = "Corporate"),
    SplitOrderID = Table.SplitColumn(FilterSegments, "Order ID", Splitter.SplitTextByDelimiter("-", QuoteStyle.Csv), {"Order Country Code", "Order Year Code", "Order Number"}),
    ChangedSplitTypes = Table.TransformColumnTypes(SplitOrderID,{{"Order Country Code", type text},{"Order Year Code", Int64.Type},{"Order Number", type text}}),
    RemovedUnneededColumns = Table.RemoveColumns(ChangedSplitTypes, {"Row ID","Country","Postal Code"}),
    RenamedColumns = Table.RenameColumns(RemovedUnneededColumns,{{"Sub-Category","Sub Category"},{"Order Country Code","Order Prefix"}}),
    AddedOrderYear = Table.AddColumn(RenamedColumns, "Order Year", each Date.Year([Order Date]), Int64.Type),
    AddedOrderMonth = Table.AddColumn(AddedOrderYear, "Order Month", each Date.ToText([Order Date], "MMM"), type text),
    AddedYearMonth = Table.AddColumn(AddedOrderMonth, "Year Month", each Date.ToText([Order Date], "yyyy-MM"), type text),
    ReorderedColumns = Table.ReorderColumns(AddedYearMonth,{"Order ID","Order Prefix","Order Year Code","Order Number","Order Date","Order Year","Order Month","Year Month","Ship Date","Ship Mode","Customer ID","Customer Name","Segment","City","State","Region","Product ID","Category","Sub Category","Product Name","Sales","Quantity","Discount","Profit"})
in
    ReorderedColumns
