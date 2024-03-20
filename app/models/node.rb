# frozen_string_literal: true

class Node < ApplicationRecord
  has_many :children,
           class_name: 'Node',
           foreign_key: 'parent_id',
           dependent: :restrict_with_exception,
           inverse_of: :parent

  belongs_to :parent, class_name: 'Node', optional: true

  has_many :birds, dependent: :restrict_with_exception

  def all_children
    query = <<-SQL
      WITH RECURSIVE CTE (id, parent_id) AS (
        SELECT id, parent_id
        FROM nodes
        WHERE parent_id = #{id}
        UNION ALL
        SELECT n.id, n.parent_id
        FROM nodes n
        INNER JOIN CTE ON n.parent_id = CTE.id
      )
      SELECT * FROM CTE;
    SQL

    children_ids = ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.sanitize_sql(query)
    ).to_a.map(&:first).map(&:last)

    Node.where(id: children_ids)
  end
end
