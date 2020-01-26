SELECT c.name
	,col_name(parent_object_id, parent_column_id) AS columnName
	,c.definition
FROM sys.default_constraints c
WHERE c.parent_object_id = @parent_object_id
ORDER BY c.name
