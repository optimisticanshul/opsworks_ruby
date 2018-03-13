# frozen_string_literal: true

require 'spec_helper'

describe Drivers::Source::Factory do
  it 'raises error when unknown engine is present' do
    expect do
      described_class.build(dummy_context(node), aws_opsworks_app(app_source: nil))
    end.to raise_error StandardError, 'There is no supported Source driver for given configuration.'
  end

  it 'returns a Git class' do
    source = described_class.build(dummy_context(node), aws_opsworks_app)
    expect(source).to be_instance_of(Drivers::Source::Git)
  end
end
