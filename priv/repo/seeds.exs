# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EatOut.Repo.insert!(%EatOut.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# for TESTING

alias EatOut.Repo
alias EatOut.Users.User

Repo.insert!(%User{email: "le.b@husky.neu.edu", name: "Binh", pw_hash: "12345"})
Repo.insert!(%User{email: "test@example.com", name: "Test Subject 1", pw_hash: "12345"})
