SELECT f.name
	,COL_NAME(fc.parent_object_id, fc.parent_column_id) AS columnName
	,object_name(fc.referenced_object_id) AS referenceObjectName
	,COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS referenceColumnName
FROM sys.foreign_keys f
INNER JOIN sys.foreign_key_columns fc ON f.object_id = fc.constraint_object_id
WHERE f.parent_object_id = @parent_object_id
ORDER BY f.name
