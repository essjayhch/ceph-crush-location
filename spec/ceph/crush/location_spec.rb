require 'spec_helper'

describe Ceph::Crush::Location do
  it 'has a version number' do
    expect(Ceph::Crush::Location::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
