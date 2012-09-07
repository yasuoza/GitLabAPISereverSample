require File.expand_path('../../spec_helper', __FILE__)

# Target file
require "#{App.root}/server"

describe 'The HelloWorld App' do
  describe :not_found do
    subject { last_response }

    before(:all) do
      get '/hello_world'
    end

    its(:status) { should be 404}
    its(:body) { should eql "This is nowhere to be found" }
  end

  describe 'POST /gitlab' do
    subject { last_response }

    describe '/foobar' do
      before do
        post '/gitlab/foobar', {key: 'value', key2: 'value2'}
      end

      its(:body) { should eq "This is nowhere to be found" }
    end

    describe '/twtr' do
      context 'invalid IP ' do
        before do
          post '/gitlab/twtr', File.read(File.expand_path('../../params.json', __FILE__)), 'REMOTE_ADDR' => '255.255.255.255'
        end

        its(:status) { should eq 403 }
        its(:body) { should eq "Access forbidden" }
      end

      context 'valid IP' do
        before do
          post '/gitlab/twtr', File.read(File.expand_path('../../params.json', __FILE__)), 'REMOTE_ADDR' => '127.0.0.2'
        end

        its(:body) { should eq JSON.generate(message: 'Update status 4 times') }
      end
    end
  end
end
