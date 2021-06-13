# # Script for populating the database. You can run it as:
# #
# #     mix run priv/repo/seeds.exs
# #
# # Inside the script, you can read and write to any of your
# # repositories directly:
# #
# #     Scouted.Repo.insert!(%Scouted.SomeSchema{})
# #
# # We recommend using the bang functions (`insert!`, `update!`
# # and so on) as they will fail if something goes wrong.

alias Scouted.Accounts
alias Scouted.Player
alias Scouted.Details
alias Scouted.Reports.ScoutingReport
alias Scouted.Repo

Accounts.register_user(%{
  email: "scout@scouted.com",
  password: "password"
})

Accounts.register_user(%{
  email: "otherscout@scouted.com",
  password: "password"
})

Repo.insert!(%Player{
  id: 1,
  first_name: "Tyler",
  last_name: "Glasnow",
  info: %{
    bats: "left",
    throws: "right",
    number: "20",
    height: "6.8",
    weight: "225",
    dob: "08/23/1993"
  }
})

Repo.insert!(%Player{
  id: 2,
  first_name: "Ji-Man",
  last_name: "Choi",
  info: %{
    bats: "left",
    throws: "right",
    number: "26",
    height: "6.1",
    weight: "260",
    dob: "05/19/1991"
  }
})

Repo.insert!(%Player{
  id: 3,
  first_name: "Yandy",
  last_name: "Diaz",
  info: %{
    bats: "right",
    throws: "right",
    number: "2",
    height: "6.2",
    weight: "225",
    dob: "08/08/1991"
  }
})

Repo.insert!(%Player{
  id: 4,
  first_name: "Manuel",
  last_name: "Margot",
  info: %{
    bats: "right",
    throws: "right",
    number: "13",
    height: "5.11",
    weight: "180",
    dob: "09/28/1994"
  }
})

Repo.insert!(%Player{
  id: 5,
  first_name: "Luis",
  last_name: "Patiño",
  info: %{
    bats: "right",
    throws: "right",
    number: "61",
    height: "6.1",
    weight: "192",
    dob: "10/26/1999"
  }
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 1,
  report_type: 0,
  grade: 70,
  details: %Details{
    pitcher_role: "Starter",
    position: "P",
    summary:
      "Tall and lanky RHP, fast delivery that he rushes too often. High pitch count often, might be better out of 'pen. Fringy with high ceiling potential. Plus fastball, minus command! Stuff is good enough to have success. I like this kid, must see in person...",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "09/20/2019"
  },
  updated_at: ~N[2019-09-21 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 1,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    position: "P",
    summary:
      "Tall slim pitcher could be injury prone thru season. Good fastball/offspeed combo. Lacks consistency with rushed delivery... Falls off the mound too much. Needs to attack hitters more and trust his stuff. Not sure his role in ML, 'pen or #3... Overmatches competition at his level but needs to develop more maturity. Competitive, shows promise.",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "08/12/2019"
  },
  updated_at: ~N[2019-08-12 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 1,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    position: "P",
    summary:
      "GOOD PITCHER WHO UNDERSTANDS THE GAME. LANKY DELIVERY CAN RESULT IN POOR COMMAND BUT HE CAN REALLY SLING IT! NEEDS TO GET ON SAME PAGE WITH CATCHER, SHAKES HIM OFF TOO MUCH. LOVE HIS FASTBALL BUT HE OVERTHROWS IT TOO MUCH... OFFSPEED NEEDS WORK.",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "05/17/2019"
  },
  updated_at: ~N[2019-05-18 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 1,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    position: "P",
    summary:
      "Not sure what went wrong today but he did not have it. Maybe hangover?? Got behind in count too much and fastball got hammered when hitters where expecting it. Must learn to REPEAT DELIVERY better. Looks like a solid #3...",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "08/12/2018"
  },
  updated_at: ~N[2018-08-12 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 1,
  report_type: 0,
  grade: 50,
  details: %Details{
    pitcher_role: "Bulk",
    position: "P",
    summary:
      "Power arm in bullpen -- middle reliever. Could be closer if he learns to improve his command... Could be #3 starter on playoff team. High upside. Needs innings, Needs more time to develop.",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "08/16/2019"
  },
  updated_at: ~N[2019-08-16 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 4,
  report_type: 1,
  grade: 50,
  details: %Details{
    position: "CF",
    time_to_first: "4.9",
    summary:
      "2ND DIV REGULAR... COULD BE UTILITY FOR CONTENDING TEAM-  STRONG STIFF SWING- GOOD DAY IN OUTFIELD, TRACKS BALLS WELL, GOOD FIRST STEP. FREE SWINGER GETS HIMSELF OUT TOO OFTEN. CUT BACK ON STRIKEOUTS AND HE CAN BE A SOLID REGULAR",
    date_seen: "07/13/2018"
  },
  updated_at: ~N[2018-07-13 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 4,
  report_type: 1,
  grade: 50,
  details: %Details{
    position: "CF",
    time_to_first: "4.8",
    summary:
      "Good young player, looks like he has fun every day. Fringy power -- more line drive hitter. Above avg runner that can swipe bags, get too greedy sometimes. Needs to hit better for his position and role."
  },
  updated_at: ~N[2019-09-22 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 4,
  report_type: 1,
  grade: 50,
  details: %Details{
    position: "CF",
    time_to_first: "4.7",
    summary:
      "Athletic outfielder with above avg defense. Inconsistent... growing pains! Not a great day at the plate, inconsistent contact, stiff swing. Chases bad pitches. Decent upside for second division regular...",
    date_seen: "09/28/2019"
  },
  updated_at: ~N[2019-09-28 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 2,
  report_type: 1,
  grade: 40,
  details: %Details{
    position: "1B",
    time_to_first: "5.3",
    summary:
      "Big strong and thick body 1st baseman- more athletic though than he 1st appears. Nice hands, good instincts in field but very limited mobility. Only see realistic DH or platoon 1B. Good left hand bat off bench.",
    date_seen: "07/24/2019"
  },
  updated_at: ~N[2019-07-24 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 2,
  report_type: 1,
  grade: 40,
  details: %Details{
    position: "DH",
    time_to_first: "5.0",
    summary:
      "Soft body, LHH that is only interested in jacking and hitting HRs, he pulls off and leaks on most swings, poor balance, he was mostly pull and hit most balls in the air, I DNS 1 ground ball. He did an adequate job at first, not really tested. He ran OK for a big, corner guy. He seemed to be relaxed and had fun, into the game when  on the bench, but he was focused, agg and intense in the batters box. He didn't get me excited, he did hit 1 long HR to RF, he could be a pot platoon 1B, or more likely a LH bat off the bench or DH, with an occ game at 1B. He seemed to have some issues getting overpowered by power arms.",
    date_seen: "09/12/2019"
  },
  updated_at: ~N[2019-09-12 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 2,
  report_type: 1,
  grade: 50,
  details: %Details{
    position: "DH",
    time_to_first: "5.3",
    summary:
      "ONLY SAW DH.  SHORT QUICK SWING  STAYS ON TOP WELL. STRONG AS OX. DRIVES BALL TO ALL FIELDS WITH SOME HR POWER.  A.L PLAYER AS ONLY DH'D",
    date_seen: "06/12/2018"
  },
  updated_at: ~N[2018-06-12 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 4,
  report_type: 1,
  grade: 50,
  details: %Details{
    position: "CF",
    time_to_first: "4.8",
    summary:
      "2ND DIV REGULAR  POSSIBLE UTILITY OF GOOD TEAM-  STRONG SWING BUT STIFF- HAS LIFE IN BAT  NOT VERY PATIENT AND SWINGS HARD  FREE SWINGER  GETS HIMSELF OUT OFTEN EARLY IN COUNT.  PLAYED WELL IN CF.",
    date_seen: "06/15/2015"
  },
  updated_at: ~N[2015-06-15 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 3,
  report_type: 1,
  grade: 40,
  details: %Details{
    position: "3B",
    time_to_first: "4.9",
    summary:
      "Corner inf with oppo field appraoch- can sting baseball - but not power hitter. Line drive power too much top swing. Good hands, limited range, casual player, not best of hustlers!!- see him as org depth bat",
    date_seen: "07/05/2019"
  },
  updated_at: ~N[2019-07-05 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 3,
  report_type: 1,
  grade: 40,
  details: %Details{
    position: "3B",
    time_to_first: "4.7",
    summary:
      "Physical, athletic player.  Average ML Defense at 3B but can move well with good strong arm. Looks like average bat speed, little stiff. Impatient at plate... Singles hitter but body might develop more power over time.  Runs well for size.  Plays with energy.",
    date_seen: "05/22/2018"
  },
  updated_at: ~N[2018-05-22 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 5,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    summary:
      "Big strong arm from young kid. Power pitcher approach... Fastball has rise and can hit high digits... touched 99. Aggressive, sometimes too aggressive. Needs to trust his stuff more and listen to catcher. Must mix in offspeed more.",
    fastball_min_velo: "90",
    fastball_max_velo: "99",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "77",
    curveball_max_velo: "79",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "09/18/2020"
  },
  updated_at: ~N[2020-09-18 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 5,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    summary:
      "A stud... High, high upside, kid can throw. Knows how to pitch, mixes all pitches well. Slider not his best pitch. Plus fastball, good changeup command. Athletic pitcher, quick pickoff...",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "07/13/2020"
  },
  updated_at: ~N[2020-07-13 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 5,
  report_type: 0,
  grade: 60,
  details: %Details{
    pitcher_role: "Starter",
    summary:
      "WOW GOOD STUFF HIGH ENERGY FUN TO WATCH. KID CAN THROW. SOLID OFFSPEED THAT COULD BE USED MORE OFTEN. GOOD INSTINCTS ON THE HILL, WORKS QUICK. ATTACKS HITTERS. MEAN. TENDENCY TO GIVE UP WHEN HE FALLS BEHIND IN COUNT. NEEDS TO TRUST HIS STUFF AND THROW IT WHEN IT COUNTS",
    fastball_min_velo: "89",
    fastball_max_velo: "94",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "05/10/2021"
  },
  updated_at: ~N[2021-05-10 14:53:27]
})

IO.puts("Seed file successfully imported...")
