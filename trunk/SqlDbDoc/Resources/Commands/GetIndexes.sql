SELECT i.name
	,CASE 
		WHEN i.type = 0
			THEN 'Heap'
		WHEN i.type = 1
			THEN 'Clustered'
		ELSE 'Nonclustered'
		END AS type
	,col_name(i.object_id, c.column_id) as columnName
FROM sys.indexes i
INNER JOIN sys.index_columns c ON i.index_id = c.index_id
	AND c.object_id = i.object_id
WHERE i.object_id=@parent_object_id
ORDER BY i.name, c.column_id
