require 'spec_helper'

describe 'nginx' do
  it { is_expected.to compile }
  it { is_expected.to contain_class('nginx') }

  context 'with content and config nginx class should not compile' do
    let(:params) {
      {:config  => 'something',
       :content => 'something'
      }
    }

    it { is_expected.not_to  compile }
  end

  context 'with config nginx class should compile' do
    let(:params) { {:config => '/etc/nginx/nginx.conf'}}

    it { is_expected.to compile }
  end

  context 'with content nginx class should compile' do
    let(:params) { {:content => 'lol'}}

    it { is_expected.to compile }
  end

  context 'with content => "This is a test"' do
    let(:params) { {:content => 'This is a test'} }

    it do
      is_expected.to contain_file('/etc/nginx/nginx.conf') \
        .with_content(/^This is a test$/)
    end
  end

  context 'with no content and no config' do
    it do
      is_expected.to contain_file('/etc/nginx/nginx.conf') \
        .with_content(/worker_processes 2/)
    end
  end

end
