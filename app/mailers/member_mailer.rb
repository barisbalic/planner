class MemberMailer < ActionMailer::Base
  include EmailHeaderHelper

  def welcome(member)
    if member.student?
      welcome_student(member)
    elsif member.coach?
      welcome_coach(member)
    end
  end

  def welcome_for_subscription(subscription)
    member = subscription.member
    if subscription.student?
      welcome_student(member)
      member.received_student_welcome_email = true
    elsif subscription.coach?
      welcome_coach(member)
      member.received_coach_welcome_email = true
    end
    member.save
  end

  def welcome_student(member)
    @member = member
    subject = "How Codebar works"

    mail(mail_args(member, subject)) do |format|
      format.html { render 'welcome_student' }
    end.deliver
  end

  def welcome_coach(member)
    @member = member
    subject = "How Codebar works"

    mail(mail_args(member, subject)) do |format|
      format.html { render 'welcome_coach' }
    end.deliver
  end
end
