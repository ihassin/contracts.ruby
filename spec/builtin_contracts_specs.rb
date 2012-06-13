require 'lib/contracts'
require 'fixtures/fixtures'

include Contracts


describe "Contracts:" do
  before :all do
    @o = Object.new
  end

  describe "Num:" do
    it "should pass for Fixnums" do
      expect { @o.double(2) }.to_not raise_error
    end

    it "should pass for Floats" do
      expect { @o.double(2.2) }.to_not raise_error
    end

    it "should fail for Strings" do
      expect { @o.double("bad") }.to raise_error
    end
  end

  describe "Pos:" do
    it "should pass for positive numbers" do
      expect { @o.pos_test(1) }.to_not raise_error
    end

    it "should fail for negative numbers" do
      expect { @o.pos_test(-1) }.to raise_error
    end
  end

  describe "Neg:" do
    it "should pass for negative numbers" do
      expect { @o.neg_test(-1) }.to_not raise_error
    end

    it "should fail for positive numbers" do
      expect { @o.neg_test(1) }.to raise_error
    end
  end

  describe "Any:" do
    it "should pass for numbers" do
      expect { @o.show(1) }.to_not raise_error
    end
    it "should pass for strings" do
      expect { @o.show("bad") }.to_not raise_error
    end
    it "should pass for procs" do
      expect { @o.show(lambda {}) }.to_not raise_error
    end
    it "should pass for nil" do
      expect { @o.show(nil) }.to_not raise_error
    end
  end

  describe "None:" do
    it "should fail for numbers" do
      expect { @o.fail_all(1) }.to raise_error
    end
    it "should fail for strings" do
      expect { @o.fail_all("bad") }.to raise_error
    end
    it "should fail for procs" do
      expect { @o.fail_all(lambda {}) }.to raise_error
    end
    it "should fail for nil" do
      expect { @o.fail_all(nil) }.to raise_error
    end
  end

  describe "Or:" do
    it "should pass for nums" do
      expect { @o.num_or_string(1) }.to_not raise_error
    end

    it "should pass for strings" do
      expect { @o.num_or_string("bad") }.to_not raise_error
    end

    it "should fail for nil" do
      expect { @o.num_or_string(nil) }.to raise_error
    end    
  end

  describe "Xor:" do
    it "should pass for an object with a method :good" do
      expect { @o.xor_test(A.new) }.to_not raise_error
    end

    it "should pass for an object with a method :bad" do
      expect { @o.xor_test(B.new) }.to_not raise_error
    end

    it "should fail for an object with neither method" do
      expect { @o.xor_test(1) }.to raise_error
    end

    it "should fail for an object with both methods :good and :bad" do
      expect { @o.xor_test(C.new) }.to raise_error
    end
  end

  describe "And:" do
    it "should pass for an object of class A that has a method :good" do
      expect { @o.and_test(A.new) }.to_not raise_error
    end

    it "should fail for an object that has a method :good but isn't of class A" do
      expect { @o.and_test(C.new) }.to raise_error
    end
  end

  describe "RespondTo:" do
    it "should pass for an object that responds to :good" do
      expect { @o.responds_test(A.new) }.to_not raise_error
    end

    it "should fail for an object that doesn't respond to :good" do
      expect { @o.responds_test(B.new) }.to raise_error
    end
  end

  describe "Send:" do
    it "should pass for an object that returns true for method :good" do
      expect { @o.send_test(A.new) }.to_not raise_error
    end

    it "should fail for an object that returns false for method :good" do
      expect { @o.send_test(C.new) }.to raise_error
    end
  end

  describe "IsA:" do
    it "should pass for an object that is an A" do
      expect { @o.isa_test(A.new) }.to_not raise_error
    end

    it "should fail for an object that is not an A" do
      expect { @o.isa_test(B.new) }.to raise_error
    end    
  end

  describe "Not:" do
    it "should pass for an argument that isn't nil" do
      expect { @o.not_nil(1) }.to_not raise_error
    end

    it "should fail for nil" do
      expect { @o.not_nil(nil) }.to raise_error
    end
  end

  describe "ArrayOf:" do
    it "should pass for an array of nums" do
      expect { @o.product([1, 2, 3]) }.to_not raise_error
    end

    it "should fail for an array with one non-num" do
      expect { @o.product([1, 2, 3, "bad"]) }.to raise_error
    end
  end
end
