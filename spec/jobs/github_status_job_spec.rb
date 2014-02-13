require 'spec_helper'

describe GithubStatusJob do
  let(:message) { '' }

  it "is a Sneakers::Worker" do
    expect(GithubStatusJob).to respond_to :from_queue
  end

  describe "Queue name" do
    subject { GithubStatusJob.queue_name }

    context "when Rails environment is test" do
      it { should == "github_status_test" }
    end
  end

  describe ".enqueue" do

    def enqueue
      GithubStatusJob.enqueue
    end

    it "sends a message to the queue" do
      expect(Sneakers).to receive(:publish).with(
        message,
        to_queue: :github_status
      )

      enqueue
    end
  end

  describe "#work" do
    let(:github_status_updater) { double(:github_status_updater) }
    let(:github_status_job) { GithubStatusJob.new }

    def work
      github_status_job.work message
    end

    before do
      GithubStatusUpdater.stub(:new) { github_status_updater }
      github_status_updater.stub(:grab_and_create)
      github_status_job.stub(:ack!)

      work
    end

    it "grabs the status from from Github and saves it" do
      expect(github_status_updater).to have_received(:grab_and_create)
    end

    it "acks the message" do
      expect(github_status_job).to have_received(:ack!)
    end
  end
end
