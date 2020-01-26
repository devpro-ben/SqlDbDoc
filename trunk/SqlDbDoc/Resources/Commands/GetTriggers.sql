SELECT tr.name
FROM sys.triggers tr
WHERE tr.parent_id = @parent_object_id
ORDER BY tr.name
