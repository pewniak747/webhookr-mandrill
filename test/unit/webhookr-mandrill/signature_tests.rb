require 'test_helper'

describe Webhookr::Mandrill::Signature do

  describe "#valid?" do

    before do
      @request = OpenStruct.new(
        :url => "http://example.com",
        :params => {'c' => 'd', 'a' => 'b'},
        :headers => { 'X-Mandrill-Signature' => "GZj1Db6JpZztD/8DcthPnT8iI7w=" }
      )
      @key = "abcdef"
      @subject = Webhookr::Mandrill::Signature.new(@request, @key)
    end

    it "should return true for valid signature" do
      assert(@subject.valid?)
    end

    it "should return false for invalid signature" do
      @request.headers['X-Mandrill-Signature'] = 'wat'
      assert(!@subject.valid?)
    end

  end

end
