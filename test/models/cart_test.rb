require "test_helper"

class CartTest < ActiveSupport::TestCase
  test "add unique products to cart" do
    cart = Cart.create!
    cart.add_product(products(:pragprog)).save!
    cart.add_product(products(:two)).save!

    assert_equal 2, cart.line_items.size
    assert_equal [ products(:pragprog).id, products(:two).id ].sort,
                 cart.line_items.pluck(:product_id).sort
  end

  test "add duplicate product to cart" do
    cart = Cart.create!
    line_item = cart.add_product(products(:pragprog))
    line_item.save!

    line_item = cart.add_product(products(:pragprog))
    line_item.save!

    assert_equal 1, cart.line_items.size
    assert_equal 2, cart.line_items.first.quantity
  end
end
