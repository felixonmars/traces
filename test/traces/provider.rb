# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2021-2022, by Samuel Williams.

unless ENV['TRACES_BACKEND']
	abort "No backend specified, tests will fail!"
end

require 'traces/provider'

describe Traces::Provider do
	let(:my_class) {Class.new}
	
	it "can yield span" do
		Traces::Provider(my_class) do
			def make_span
				trace('test.span') do |span|
					return span
				end
			end
		end
		
		span = my_class.new.make_span
		span["key"] = "value"
	end

	it "can get current trace context" do
		Traces::Provider(my_class) do
			def span
				trace('test.span') do |span|
					return trace_context
				end
			end
		end
		
		trace_context = my_class.new.span
	end
end
