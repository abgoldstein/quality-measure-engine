require 'test_helper'

class BundleTest < MiniTest::Unit::TestCase
  include QME::DatabaseAccess

  def setup
    @db = get_db()
  end

  def test_drop_collections
    default_collections = ["bundles", "records", "measures", "selected_measures", "patient_cache", "query_cache", "system.js"]
    default_collections.each {|collection| @db[collection].insert(nil) }

    pre_drop_collections = @db.collections
    QME::Bundle.drop_collections(@db)
    post_drop_collections = @db.collections

    assert_equal pre_drop_collections.size - 7, post_drop_collections.size
  end

  def test_save_system_js_fn
    name = "returnTwo"
    js_fn = "function() { return 2; }"
    save_system_js_fn(@db, name, js_function)

    stored_function = @db["system.js"].find({"_id" => name}).first
    assert_equal stored_function._id, name

    # TODO make JS actually execute
    return_value = Moped.magically_execute(stored_function.value)
    assert_equal return_value, 2
  end

  def test_entry_key
    path = "/boo/urns.html"
    assert_equal entry_key(path, ".html"), "urns"
  end
end