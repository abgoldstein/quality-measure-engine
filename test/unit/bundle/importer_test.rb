require 'test_helper'

class ImporterTest < MiniTest::Unit::TestCase
  def setup
    @importer = QME::Bundle::Importer.new
    @importer.import(File.new('test/fixtures/bundles/just_measure_0002.zip'), true)
  end

  def test_import
    
  end
end