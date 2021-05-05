# frozen_string_literal: true
require 'rspec'
require "faraday"


RSpec.describe CocRb do
  it "has a version number" do
    expect(CocRb::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
