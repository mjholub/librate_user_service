defmodule LibrateUserServiceTest do
  use ExUnit.Case
  doctest LibrateUserService

  test "greets the world" do
    assert LibrateUserService.hello() == :world
  end
end
