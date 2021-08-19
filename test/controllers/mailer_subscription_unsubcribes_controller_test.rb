require "test_helper"

class MailerSubscriptionUnsubcribesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create" do
    assert_difference("MailerSubscription.count", 1) do
      post mailer_subscription_unsubcribes_path, params: { user: @user.to_global_id, mailer: "MarketingMailer" }
    end

    assert_not MailerSubscription.last.subscribed?
    assert_match "You've successfully unsubscribed from this email.", @response.body
  end

  test "should handle bad token" do
    post mailer_subscription_unsubcribes_path, params: { user: "a bad token", mailer: "MarketingMailer" }
    assert_match "There was an error", @response.body
  end
end
