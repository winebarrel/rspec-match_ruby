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
  end
end
