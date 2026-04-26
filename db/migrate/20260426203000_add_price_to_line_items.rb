class AddPriceToLineItems < ActiveRecord::Migration[8.0]
  def up
    add_column :line_items, :price, :decimal, precision: 8, scale: 2

    execute <<~SQL.squish
      UPDATE line_items
      SET price = products.price
      FROM products
      WHERE line_items.product_id = products.id
    SQL

    change_column_null :line_items, :price, false
  end

  def down
    remove_column :line_items, :price
  end
end
