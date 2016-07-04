require 'spec_helper'
require "logstash/filters/example"

describe LogStash::Filters::Example do
  describe "Split structured Syslog " do
    let(:config) do <<-CONFIG
      filter {
        splitsyslog {
        }
      }
    CONFIG
    end

    sample("message" => "Example, keyis=valueis name=splitlog") do
      expect(subject).to include("message")
      expect(subject['message']).to eq('Example, keyis=valueis name=splitlog')
    end
  end
end
