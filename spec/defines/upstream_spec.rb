require 'spec_helper'

describe 'nginx::upstream' do
  let(:title) { 'foo' }

  it { is_expected.to compile }
  it { is_expected.to contain_nginx__upstream('foo') }
end
