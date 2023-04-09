class PizzaIngredientsFactory
  def create_dough
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end

  def create_sauce
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end

  def create_cheese
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end

  def create_veggies
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end

  def create_pepperoni
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end
end

class NYPizzaIngredientsFactory < PizzaIngredientsFactory
  def create_dough
    "Thin crust dough"
  end

  def create_sauce
    "Marinara sauce"
  end

  def create_cheese
    "Reggiano cheese"
  end

  def create_veggies
    "Garlic, onions, mushrooms, peppers"
  end

  def create_pepperoni
    "Sliced pepperoni"
  end
end

class ChicagoPizzaIngredientsFactory < PizzaIngredientsFactory
  def create_dough
    "Thick crust dough"
  end

  def create_sauce
    "Plum tomato sauce"
  end

  def create_cheese
    "Mozzarella cheese"
  end

  def create_veggies
    "Spinach, onions, mushrooms"
  end

  def create_pepperoni
    "Crumbled sausage"
  end
end

# Define the interface for pizza types
class Pizza
  attr_accessor :name, :dough, :sauce, :cheese, :veggies, :pepperoni

  def prepare
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end

  def bake
    puts "Baking for 25 minutes at 350 degrees"
  end

  def cut
    puts "Cutting the pizza into diagonal slices"
  end

  def box
    puts "Placing the pizza in the official pizza box"
  end
end

# Define the concrete implementation for New York-style cheese pizza
class NYStyleCheesePizza < Pizza
  def initialize(ingredients_factory)
    @name = "New York-style cheese pizza"
    @ingredients_factory = ingredients_factory
  end

  def prepare
    @dough = @ingredients_factory.create_dough
    @sauce = @ingredients_factory.create_sauce
    @cheese = @ingredients_factory.create_cheese
    @veggies = @ingredients_factory.create_veggies
    @pepperoni = @ingredients_factory.create_pepperoni
  end
end

# Define the concrete implementation for Chicago-style cheese pizza
class ChicagoStyleCheesePizza < Pizza
  def initialize(ingredients_factory)
    @name = "Chicago-style cheese pizza"
    @ingredients_factory = ingredients_factory
  end

  def prepare
    @dough = @ingredients_factory.create_dough
    @sauce = @ingredients_factory.create_sauce
    @cheese = @ingredients_factory.create_cheese
    @veggies = @ingredients_factory.create_veggies
    @pepperoni = @ingredients_factory.create_pepperoni
  end

  def cut
    puts "Cutting the pizza into square slices"
  end
end

# Define the pizza store
class PizzaStore
  def initialize(ingredients_factory)
    @ingredients_factory = ingredients_factory
  end

  def order_pizza(type)
    pizza = create_pizza(type)
    pizza.prepare
    puts "Ordered a #{pizza.name} with:"
    puts " - Dough: #{pizza.dough}"
    puts " - Sauce: #{pizza.sauce}"
    puts " - Cheese: #{pizza.cheese}"
    puts " - Veggies: #{pizza.veggies}"
    puts " - Pepperoni: #{pizza.pepperoni}"
    pizza.bake
    pizza.cut
    pizza.box
    return pizza
  end

  def create_pizza(type)
    raise NotImplementedError, "#{self.class} has not implemented method '#{method}'"
  end
end

#Define the New York-style pizza store
class NYPizzaStore < PizzaStore
  def create_pizza(type)
    if type == "cheese"
      return NYStyleCheesePizza.new(@ingredients_factory)
    else
      raise ArgumentError, "Invalid pizza type '#{type}'"
    end
  end
end


class ChicagoPizzaStore < PizzaStore
  def create_pizza(type)
    if type == "cheese"
      return ChicagoStyleCheesePizza.new(@ingredients_factory)
    else
      raise ArgumentError, "Invalid pizza type '#{type}'"
    end
  end
end

ny_store = NYPizzaStore.new(NYPizzaIngredientsFactory.new)
ny_cheese_pizza = ny_store.order_pizza("cheese")


chicago_store = ChicagoPizzaStore.new(ChicagoPizzaIngredientsFactory.new)
chicago_cheese_pizza = chicago_store.order_pizza("cheese")