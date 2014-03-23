require "spec_helper"

describe Lactol::Server do
  let(:thor_class) do
    Class.new(Thor) do
      desc "my_sub_commnad", "my sub command"
      method_option :required_option, required: true
      method_option :optional_option
      def my_sub_command
        puts "executed"
        warn "warning"
      end
    end
  end

  it "is initiated by class inheriting Thor" do
    Lactol::Server.new(thor_class)
  end

  context "generates endpoint automatically" do
    include Capybara::DSL

    let(:app) { Lactol::Server.new(thor_class) }

    before(:each) do
      Capybara.configure do |config|
        config.app = app
      end

      visit "/my_sub_command"
    end

    context "whose title" do
      it "shows command name" do
        expect(page.title).to match(/my_sub_command - lactol/)
      end
    end

    context "whose mandatory params" do
      it "include options required" do
        expect(page.find("#mandatory_parameters")).to have_field("required_option")

        expect(page.find("#mandatory_parameters").find_field("required_option")[:required]).to be_true
      end
    end

    context "whose mandatory params" do
      it "include options without required" do
        page.find("#optional_parameters").should have_field("optional_option")
        expect(page.find("#optional_parameters").find_field("optional_option")[:required]).to be_false
      end
    end

    context "has execute button" do
      it "shows option passed" do
        fill_in "required_option", with: "hoge"
        find("#execute").click

        expect(find("li[name=required_option]")).to have_content("required_option: hoge")
      end

      it "shows stdout" do
        fill_in "required_option", with: "hoge"
        find("#execute").click

        expect(find("#result")).to have_content("executed")
      end

      it "shows stderr" do
        fill_in "required_option", with: "hoge"
        find("#execute").click

        expect(find("#error")).to have_content("warning")
      end
    end
  end
end
