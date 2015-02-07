require 'tree'

describe Tree do
  let(:tree) { Tree.new("lib/test.html")}
  describe 'edits file into string correctly' do
    it "deletes '<!DOCTYPE HTML>' from the start of the file" do
      expect(tree.doc_string =~ /<!DOCTYPE HTML>/).to be_nil
    end
    it "deletes line breaks and following spaces" do
      expect(tree.doc_string =~ /\n\s*/).to be_nil
    end
  end
  describe 'root node' do
    it 'is a tag' do
      expect(tree.root).to be_a_kind_of Tag
    end
    it 'should be named \'html\'' do
      expect(tree.root.name).to eq 'html'
    end
    it 'contains text' do
      expect(tree.root.text).to be_a_kind_of String
    end
  end

  describe 'adds one node to its parent node' do
  end
  describe 'adds multiple nodes to their parent node' do
  end


  describe 'tags' do
    before {reader.build_tree("lib/tagged.html")}
    it 'has a name'
    it 'has class information'
    it 'has id information'
    it 'has a parent node'
    it 'has child nodes'
    it 'contains text'
  end
end