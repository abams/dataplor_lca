WITH RECURSIVE CTE (id, parent_id) AS (
  SELECT id, parent_id
  FROM nodes
  WHERE parent_id = PARENTID
  UNION ALL
  SELECT n.id, n.parent_id
  FROM nodes n
  INNER JOIN CTE ON n.parent_id = CTE.id
)
SELECT * FROM CTE;
