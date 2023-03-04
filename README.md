# README

* Some notes

Keep sqlite for this little project.

Using rspec for test.

When a slot is empty i consider this like missed data and don't update.

Csv example is find on spec/fixture/csv

All test was made with rspec

* Setup

`bundle exec rails db:create`

`bundle exec rails db:migrate`

Some example of testing:

```
file = File.open("spec/fixture/csv/building/basic_building.csv")
Building.import(file)
```