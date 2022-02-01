class HomeController < ApplicationController
  def show
    @people = Person.limit(3)
    @programs = Program.limit(3)
    @roles = Role.targetless.limit(3)
    breadcrumb
  end
end
