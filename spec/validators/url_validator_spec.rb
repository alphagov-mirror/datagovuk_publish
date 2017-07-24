require 'rails_helper'
require 'active_model'
require './lib/validators/url_validator'

RSpec.describe UrlValidator do
  subject do
    Class.new do
      include ActiveModel::Validations
      validates_with UrlValidator
      attr_accessor :url
    end.new
  end


  describe 'Url Validator' do
    describe 'Creates validation errors when' do

      before(:each) do
        allow_any_instance_of(UrlValidator).to receive(:validDomain?).and_call_original
        allow_any_instance_of(UrlValidator).to receive(:validPath?).and_call_original
      end

      EXPECTED_ERROR_MESSAGE = 'Please enter a valid url'

      it 'the field is an empty string' do
        subject.url = ''
        subject.validate
        expect(subject.errors[:url]).to include EXPECTED_ERROR_MESSAGE
      end

      it 'the url does not exist' do
        subject.validate
        expect(subject.errors[:url]).to include EXPECTED_ERROR_MESSAGE
      end

      it 'the url does not start with \'http\' or \'https\'' do
        subject.url = 'google.com'
        subject.validate
        expect(subject.errors[:url]).to include EXPECTED_ERROR_MESSAGE
      end

      it 'the host does not exist' do

        subject.url = 'http://thisHostDoesNotExist.com/data'
        subject.validate
        expect(subject.errors[:url]).to include EXPECTED_ERROR_MESSAGE
      end

      it 'the url path does not exist' do
        # allow_any_instance_of(UrlValidator).to receive(:validPath?).and_return(false)

        subject.url = 'http://codurance.com/doesNotExist'
        subject.validate
        expect(subject.errors[:url]).to include EXPECTED_ERROR_MESSAGE
      end
    end

    describe 'Does not create validation error' do
      it 'if url is valid' do
        subject.url = 'http://www.bbc.co.uk/news'
        subject.validate
        expect(subject.errors[:url]).to be_empty
      end
    end
  end
end