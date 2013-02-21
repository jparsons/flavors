require 'spec_helper'
require 'flavors'

describe Flavors::Preferences do
  before do
    User.class_eval do
      preference :notification, :default => true
    end

    Post.class_eval do
      preference :sticky, :default => false
    end
  end

  subject { User.create }

  it "should have a default value" do
    subject.notification.should == true
  end

  it "should update preference" do
    subject.notification = false
    subject.notification.should == false
  end

  it "should scope preferences for different classes" do
    expect {
      subject.sticky
    }.to raise_error NoMethodError
  end

  it "should scope default value for different classes" do
    Post.class_eval do
      preference :notification, :default => false
    end

    subject.notification.should be_true
  end

  it "should return if nil if no default value defined" do
    User.class_eval do
      preference :foo
    end

    subject.foo.should be_nil
  end
end
