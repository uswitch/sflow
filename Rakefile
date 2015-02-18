#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/sflow'
  t.test_files = FileList['test/lib/sflow/*_test.rb']
  t.verbose = true
end

def self.cmd(com)
  IO.popen(com) { |io| while (line = io.gets) do puts line end }
  end

  def self.directory
    @@directory ||= File.expand_path File.dirname(__FILE__)
  end


  namespace :package do
    desc "precise docker image"
    task :precise do
      cmd "docker build -t uswitch/deb-sflow-precise64 #{directory}/docker"
    end

    desc "Build deb"
    task :build => :precise do
      cmd "docker run -v #{directory}/:/data -t uswitch/deb-sflow-precise64"
    end
  end

  namespace :uswitch do
    desc "Upload"
    task :upload do
      Uswitchci::Deb::package_dir(directory)
    end
  end


  task :default => :test
