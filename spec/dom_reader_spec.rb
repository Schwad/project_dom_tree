require 'dom_reader'

describe DOMReader do
  let(:reader){ DOMReader.new }
  describe 'build_tree' do
    it 'creates a tree object' do
      expect(reader.build_tree("lib/test.html")).to be_a_kind_of Tree
    end
  end
end