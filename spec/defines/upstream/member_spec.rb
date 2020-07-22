require 'spec_helper'

describe 'nginx::upstream::member' do
  upstream_name = 'upstream_test'
  upstream_member_name = 'upstream_member_1'
  upstream_conf_file = "/etc/nginx/upstreams.d/#{upstream_name}/1_#{upstream_member_name}.conf"

  let(:pre_condition) do
    'nginx::upstream {"' + upstream_name + '": }'
  end

  let(:title) { upstream_member_name }

  let(:params) do 
    {
      'upstream' => upstream_name
    }
  end

  it { is_expected.to compile }
  it { is_expected.to contain_nginx__upstream__member(upstream_member_name) }

  context "without weight, max_fails, fail_timeout set" do
    let(:params) do
      {
        'upstream' => upstream_name
      }
    end

    it do
      is_expected.to contain_file(upstream_conf_file) \
        .with_content(/server/)
      is_expected.to contain_file(upstream_conf_file) \
        .without_content(/max_fails=/)
    end
  end

  context "with weight, max_fails, fail_timeout set" do
    let(:params) do
      {
        'upstream'     => upstream_name,
        'weight'       => 100,
        'max_fails'    => 0,
        'fail_timeout' => 10,
      }
    end

    it do
      is_expected.to contain_file(upstream_conf_file) \
        .with_content(/weight=/)
      is_expected.to contain_file(upstream_conf_file) \
        .with_content(/max_fails=/)
      is_expected.to contain_file(upstream_conf_file) \
        .with_content(/fail_timeout=/)
    end
  end
end
