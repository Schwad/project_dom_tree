require 'dom_reader'

describe DOMReader do
  let(:reader){ DOMReader.new }

  describe '#build_tree' do
    describe 'edits file into string correctly' do
      before { reader.build_tree("lib/spaces.html") }
      it "deletes '<!DOCTYPE HTML>' from the start of the file" do
        expect(reader.doc_string =~ /<!DOCTYPE HTML>/).to be_nil
      end
      it "deletes line breaks and following spaces" do
        expect(reader.doc_string =~ /\n\s*/).to be_nil
      end
    end
    describe 'creates a root node' do
    end
    describe 'adds one node to its parent node' do
    end
    describe 'adds multiple nodes to their parent node' do
    end
  end

  describe 'nodes' do
    it 'has a name'
    it 'has class information'
    it 'has id information'
    it 'has a parent node'
    it 'has child nodes'
    it 'contains text'
  end
end