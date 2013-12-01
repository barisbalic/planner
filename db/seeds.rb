if Rails.env.development?
  puts "in here"

  Fabricate(:student_role)
  Fabricate(:coach_role)

  sessions = 10.times.map { |n| Fabricate(:sessions, date_and_time: DateTime.now+14.days-n.weeks) }

  courses = 5.times { |n| Fabricate(:course, date_and_time: DateTime.now+14.days-n.weeks) }

  coaches = 20.times.map { |n| Fabricate(:coach) }

  40.times do |n|
    coach = coaches.sample
    Fabricate(:attended_session_invitation, role: "Coach", member: coach, sessions: sessions.sample )  rescue "Coach already attended"
  end

end