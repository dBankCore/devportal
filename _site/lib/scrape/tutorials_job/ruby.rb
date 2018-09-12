require 'git'

module Scrape
  module TutorialsJob
    class Ruby < Base
      def initialize(options = {})
        options[:tutorial_github_url] = 'https://github.com/dpays/developer-docs-tutorials-rb.git'
        options[:tutorial_github_name] ||= 'devportal-tutorials-rb'
        options[:tutorial_url] = 'https://github.com/dpays/developer-docs-tutorials-rb'
        options[:dest_tutorials_path] ||= '_tutorials-ruby'
        
        super
      end
    end
  end
end
