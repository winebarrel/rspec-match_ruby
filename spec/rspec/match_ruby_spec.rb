RSpec.describe 'match_ruby' do
  let(:expected) do
    <<-EOS
      create_table :products, id: true, force: :cascade do |t|
        t.string :name, null: false, limit: 4
        t.text :description

        t.timestamps
      end
    EOS
  end

  context 'when match' do
    specify do
      expect(<<-EOS).to match_ruby expected
        create_table :products, force: :cascade, id: true do |t|
          t.string :name, limit: 4, null: false
          t.text :description
          # Comment
          t.timestamps
        end
      EOS
    end
  end

  context 'when not match' do
    specify do
      expect(<<-EOS).to_not match_ruby expected
        create_table :products, force: :cascade, id: true do |t|
          t.string :name, limit: 4, null: true
          t.text :description
          # Comment
          t.timestamps
        end
      EOS
    end
  end
end
