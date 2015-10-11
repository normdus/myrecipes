# =>By requiring this file, test_helper.rb the default
# =>configuration to run our tests is loaded. We will 
# =>include this with all the tests we write, 
# =>so any methods added to this file 
# =>are available to all your tests.

require 'test_helper'

#   The RecipeTest class defines a test case because
#   it inherits from ActiveSupport::TestCase. RecipeTest
#   thus has all the methods available 
#   from ActiveSupport::TestCase. 

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "chicken parm", summary: "this is the best chicken",
              description: "heat oil, add onions, add tomato")
  end

# =>Rails also adds a test method that takes a test 
# =>name and a block. It generates a normal 
# =>Minitest::Unit test with method names prefixed 
# =>with test_. So you don't have to worry about 
# =>naming the methods. example test:

  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
# =>(1)
  test "recipe should be valid" do
    assert @recipe.valid? # this is the actual test...
  end
  
# =>(2)
  test "name should be present" do
    @recipe.name = " "  
    assert_not @recipe.valid?  
  end
# =>(3)  
  test "name length should not be too long" do
    @recipe.name = "a" * 101  
    assert_not @recipe.valid?
  end
# =>(4)  
  test "name length should not be too short" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end
# =>(5)  
  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end
# =>(6) 
  test "summary should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
# =>(7)  
  test "summary should not be too short" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
# =>(8)    
  test "description must be present" do 
    @recipe.description = " "
    assert_not @recipe.valid?
  end
# =>(9)  
  test "description should not be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
# =>(10)  
  test "description should not be too short" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
end