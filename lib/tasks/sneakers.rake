require 'sneakers/tasks'

namespace :sneakers do

  desc "Initialize workers and run Sneakers"
  task init_and_run: :environment do
    workers = Dir[Rails.root.join("app", "jobs", "*.rb")].inject([]) do |acc, job_file|
      file_name = File.basename(job_file, ".rb")
      acc << file_name.classify
    end

    ENV["WORKERS"] = workers.join(",")
    Rake::Task["sneakers:run"].invoke
  end
end
