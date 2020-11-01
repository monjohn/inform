# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Inform.Repo.insert!(%Inform.SomeSchema{})

alias Inform.Accounts

[
  %{
    first_name: "Monte",
    last_name: "Johnston",
    region: :triangle,
    phone: "9193331749"
  },
  %{first_name: "Bob", last_name: "Jones", region: "east", phone: "number"},
  %{first_name: "Artimus", last_name: "Fowle", region: "east", phone: "number"},
  %{first_name: "Oswald", last_name: "Jessup", region: "west", phone: "number"},
  %{
    first_name: "Kari",
    last_name: "Johnston",
    region: "triad",
    phone: "2524025050"
  }
]
|> Enum.each(&Accounts.create_user/1)

#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
