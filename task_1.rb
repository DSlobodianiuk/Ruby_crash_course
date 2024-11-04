require 'date'

class Person 
  @@students = []
  attr_accessor :surname, :name, :date_of_birth

  def initialize(surname,name,date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)
    self.validation
    self.uniqueness(surname,name,date_of_birth)
    @@students << self
  end

  def validation
    raise ArgumentError.new(
      "Expected date of birth should be less than #{Date.today}, got #{date_of_birth}"
    ) if date_of_birth > Date.today
  end

  def uniqueness(surname,name,date_of_birth)
    raise ArgumentError.new(
      "Expected unique person"
    ) if @@students.any? {|student| student.surname == surname &&
    student.name == name && student.date_of_birth == Date.parse(date_of_birth)} == true
  end 

  def calculate_age
    @age = ((Date.today - date_of_birth)/365.25).to_i
  end

  def add_student(surname, name, date_of_birth)
    person = Person.new(surname, name, date_of_birth)
  end

  def remove_student(surname,name,date_of_birth)
    @@students.delete_if{|student| student.surname == surname &&
     student.name == name && student.date_of_birth == Date.parse(date_of_birth)} 
  end

  def get_students_by_age(age)
    @@students.select{|student| student.calculate_age == age}
  end

  def get_students_by_name(name)
    @@students.select{|student| student.name == name}
  end 

end