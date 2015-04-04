require 'spec_helper'
describe 'briancainnet' do

  context 'with defaults for all parameters' do
    it { should contain_class('briancainnet') }
  end
end
