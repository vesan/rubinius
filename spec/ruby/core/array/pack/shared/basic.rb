describe :array_pack_arguments, :shared => true do
  it "raises an ArgumentError if there are fewer elements than the format requires" do
    lambda { [].pack(pack_format(1)) }.should raise_error(ArgumentError)
  end
end

describe :array_pack_basic, :shared => true do
  before :each do
    @obj = ArraySpecs.universal_pack_object
  end

  it "calls #to_str to coerce the directives string" do
    d = mock("pack directive")
    d.should_receive(:to_str).and_return("x"+pack_format)
    [@obj, @obj].pack(d).should be_an_instance_of(String)
  end

  it "raises a TypeError when passed nil" do
    lambda { [@obj].pack(nil) }.should raise_error(TypeError)
  end

  it "raises a TypeError when passed an Integer" do
    lambda { [@obj].pack(1) }.should raise_error(TypeError)
  end

  it "taints the output string if the format string is tainted" do
    [@obj, @obj].pack("x"+pack_format.taint).tainted?.should be_true
  end
end

describe :array_pack_no_platform, :shared => true do
  it "raises ArgumentError when the format modifier is '_'" do
    lambda{ [1].pack(pack_format("_")) }.should raise_error(ArgumentError)
  end

  it "raises ArgumentError when the format modifier is '!'" do
    lambda{ [1].pack(pack_format("!")) }.should raise_error(ArgumentError)
  end
end
