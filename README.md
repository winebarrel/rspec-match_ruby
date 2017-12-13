# rspec-match_fuzzy

It is Ruby code matcher.

[![Build Status](https://travis-ci.org/winebarrel/rspec-match_ruby.svg?branch=master)](https://travis-ci.org/winebarrel/rspec-match_ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-match_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-match_ruby

## Usage

```ruby
require 'rspec/match_ruby'

RSpec.describe do
  specify do
    code1 = <<-EOS
      create_table :products, id: true, force: :cascade do |t|
        t.string :name, null: false, limit: 4
        t.text :description

        t.timestamps
      end
    EOS

    code2 = <<-EOS
      create_table :products, force: :cascade, id: true do |t|
        t.string :name, limit: 4, null: true
        t.text :description
        # Comment
        t.timestamps
      end
    EOS

    expect(code1).to match_ruby code2
    #=> Failure/Error: expect(code1).to match_ruby code2
    #     expected: "create_table :products, force: :cascade, id: true do |t|\nt.string :name, limit: 4, null: true\nt.text :description\n# Comment\nt.timestamps\nend"
    #          got: "create_table :products, id: true, force: :cascade do |t|\nt.string :name, null: false, limit: 4\nt.text :description\nt.timestamps\nend"
    #     Diff:
    #     @@ -1,7 +1,6 @@
    #     -create_table :products, force: :cascade, id: true do |t|
    #     -t.string :name, limit: 4, null: true
    #     +create_table :products, id: true, force: :cascade do |t|
    #     +t.string :name, null: false, limit: 4
    #      t.text :description
    #     -# Comment
    #      t.timestamps
    #      end
    #     @@ -14,7 +14,7 @@
    #         [:sym, :name],
    #         [:hash,
    #          [:pair, [:sym, :limit], [:int, 4]],
    #     -    [:pair, [:sym, :null], [:true]]]],
    #     +    [:pair, [:sym, :null], [:false]]]],
    #        [:send, [:lvar, :t], :text, [:sym, :description]],
    #        [:send, [:lvar, :t], :timestamps]]]
  end
end
```
