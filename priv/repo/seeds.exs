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

Accounts.register_user(%{
  email: "guest@scouted.com",
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

Repo.insert!(%Player{
  id: 6,
  first_name: "Randy",
  last_name: "Arozarena",
  info: %{
    bats: "right",
    throws: "right",
    number: "56",
    height: "5.11",
    weight: "185",
    dob: "02/28/1995"
  }
})

Repo.insert!(%Player{
  id: 7,
  first_name: "Kevin",
  last_name: "Kiermaier",
  info: %{
    bats: "left",
    throws: "right",
    number: "39",
    height: "6.1",
    weight: "210",
    dob: "04/22/1990"
  }
})

Repo.insert!(%Player{
  id: 8,
  first_name: "Kevin",
  last_name: "Kiermaier",
  info: %{
    bats: "left",
    throws: "right",
    number: "39",
    height: "6.1",
    weight: "210",
    dob: "04/22/1990"
  }
})

Repo.insert!(%Player{
  id: 9,
  first_name: "Austin",
  last_name: "Meadows",
  info: %{
    bats: "left",
    throws: "left",
    number: "17",
    height: "6.3",
    weight: "225",
    dob: "05/03/1995"
  }
})

Repo.insert!(%Player{
  id: 10,
  first_name: "Brett",
  last_name: "Phillips",
  info: %{
    bats: "left",
    throws: "right",
    number: "35",
    height: "6.0",
    weight: "195",
    dob: "05/30/1994"
  }
})

Repo.insert!(%Player{
  id: 11,
  first_name: "Joey",
  last_name: "Wendle",
  info: %{
    bats: "left",
    throws: "right",
    number: "18",
    height: "6.1",
    weight: "195",
    dob: "04/26/1990"
  }
})

Repo.insert!(%Player{
  id: 12,
  first_name: "Taylor",
  last_name: "Walls",
  info: %{
    bats: "switch",
    throws: "right",
    number: "6",
    height: "5.10",
    weight: "185",
    dob: "07/10/1996"
  }
})

Repo.insert!(%Player{
  id: 13,
  first_name: "Mike",
  last_name: "Zunino",
  info: %{
    bats: "right",
    throws: "right",
    number: "10",
    height: "6.2",
    weight: "235",
    dob: "03/05/1991"
  }
})

Repo.insert!(%Player{
  id: 14,
  first_name: "Francisco",
  last_name: "Mejia",
  info: %{
    bats: "switch",
    throws: "right",
    number: "6",
    height: "5.8",
    weight: "188",
    dob: "10/27/1995"
  }
})

Repo.insert!(%Player{
  id: 15,
  first_name: "Shane",
  last_name: "McClanahan",
  info: %{
    bats: "left",
    throws: "left",
    number: "62",
    height: "6.1",
    weight: "200",
    dob: "04/28/1997"
  }
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 13,
  report_type: 1,
  grade: 60,
  position: :catcher,
  details: %Details{
    time_to_first: "4.8",
    summary:
      "Thick, stocky, good frame. Soft hands behind the plate, frames pitches well. Good communicator and game caller. Lined a shot over left-center. Needs to hit for more contact but his power will keep him in the lineup...",
    date_seen: "09/22/2019"
  },
  updated_at: ~N[2020-06-22 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 15,
  report_type: 0,
  grade: 70,
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
    summary:
      "LHP with high delivery and loose quick arm -- Explosive! Has recoil with small head bobble. FB has plus arm side run. SL can be a plus pitch with hard late tilt. Needs to repeat delivery better. Has good feel for CH. Maintains his arm speed. Plus sink. Needs to harness his stuff. Has to prove he can command the baseball. Command could prevent him from pitching deep into games. Plus make up and work habits.",
    fastball_min_velo: "93",
    fastball_max_velo: "99",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    date_seen: "06/20/2021"
  },
  updated_at: ~N[2021-06-21 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 15,
  report_type: 0,
  grade: 70,
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
    summary:
      "LHS thick frame that works off 3b side of rubber with a small pivot turn start. Aggressive style, with fast and up-tempo game. Fb topping out at 97-98 mph. slider/slurve hard down and accr zone was a solid 55 sometimes better K out pitch. Change was buried had splitter action. Has some real swing and miss stuff. Threw strikes with command of fb/SL. Good chance to be mid rotation starter or power LHR in back end of pen.",
    fastball_min_velo: "93",
    fastball_max_velo: "99",
    sinker_min_velo: "87",
    sinker_max_velo: "90",
    slider_min_velo: "84",
    slider_max_velo: "86",
    curveball_min_velo: "84",
    curveball_max_velo: "85",
    changeup_min_velo: "85",
    changeup_max_velo: "86",
    other_name: "slurve",
    other_min_velo: "84",
    other_max_velo: "87",
    date_seen: "06/20/2021"
  },
  updated_at: ~N[2021-06-14 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 12,
  report_type: 1,
  grade: 65,
  position: :short_stop,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Very solid middle infielder with defensive first style. Line drive put the ball in play switch hitter that gets on base. High energy type utility infielder that can switch it and play anywhere. Instant contibutor in every game. Team captain type player.",
    date_seen: "07/23/2019"
  },
  updated_at: ~N[2019-07-23 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 12,
  report_type: 1,
  grade: 55,
  position: :short_stop,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Sound defensively and can play multiple pos. Very similar set up from both sides of plate, but a bit more pop from Right side. Needs to get more agggressive at the plate... way too patient and always deep in counts. Lets too many fat pitches go by. Avg runner with very good instincts and a very polished defender.",
    date_seen: "08/17/2020"
  },
  updated_at: ~N[2020-08-23 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 8,
  report_type: 1,
  grade: 55,
  position: :center_field,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Elite Gold Glove defender in outfield - total package with speed, breaks, and arm. Can play a bit reckless and has trouble staying healthy with his style. Not much of a bat, bottom order hitter. Doesn't walk much and prone to K's. Streaky. 1st division regular!!",
    date_seen: "09/23/2019"
  },
  updated_at: ~N[2019-09-26 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 8,
  report_type: 1,
  grade: 55,
  position: :center_field,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "HIGH VALUE IN HIS DEFENSIVE ABILITY - ONE OF BEST CENTER FIELDERS IN GAME. YEARLY GOLD GLOVE CONTENDER. COVERS GROUND FAST, MANY SPECTACUAR CATCHES, THROWS WELL, TOUGH TO RUN ON.  STREAKY HITTER HAS BATTLED INJURIES AND NEVER GOT MUCH GOING - BETTER THAN HIS NUMBERS, SHOULD IMPROVE.",
    date_seen: "09/23/2019"
  },
  updated_at: ~N[2018-09-15 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 9,
  report_type: 1,
  grade: 55,
  position: :left_field,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Strong, athletic with deceptive running speed. Decent arm, improving. contact bat uses the field and decent off speed hitter. Needs to develop his power. Line drive hitter. Still has holes in his swing and doesn't lay off the high heat... must use his whole body to harness his power. Good reads in outfield with good jumps and routes, I think he should still be in CF???- still see him as a 55 grade, ML 1st division starter!!",
    date_seen: "04/23/2018"
  },
  updated_at: ~N[2018-04-26 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 9,
  report_type: 1,
  grade: 55,
  position: :left_field,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Abv avg ML hitter with loft to his swing & uses whole field. Has abv avg power and avg BB% showing some discipline. Strong left hander that hangs in well vs LHP! He's an avg runner, will take the extra base & can steal a base, 15 + a year. Have him as an avg fielder with fringy arm that has avg accuracy. Saw in LF & RF, like better in LF I believe he's going to be an OCCASIONAL ALL STAR",
    date_seen: "06/09/2019"
  },
  updated_at: ~N[2019-06-09 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 14,
  report_type: 1,
  grade: 50,
  position: :catcher,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Switch-hitting back-up/xtra C. Offensive oriented. Smaller, live body, w/some pop. Above average throwing. Long swing... Small target w/some agility. AA speed on basepaths but not a stolen base threat. Not always invested in blocking. Hands ok. Periods of drops/clanks. Game calling should improve with more experience ",
    date_seen: "06/17/2019"
  },
  updated_at: ~N[2019-06-17 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 14,
  report_type: 1,
  grade: 50,
  position: :catcher,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Small frame catcher with offense ahead of his glove!!- athletic, quick twitch guy. very quick bat/ also ability barrel baseballs- hard contact use field hacker appraoch- rough/crude with glove, P’s looked frustrated with some of his plays behind the plate - maybe needs to go to LF/let him slash and hit!!",
    date_seen: "06/12/2018"
  },
  updated_at: ~N[2018-06-12 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 11,
  report_type: 1,
  grade: 60,
  position: :second_base,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Grinder type, saw him at SS and 3rd base, probably best at 2nd. Nice range, not sure he has arm strength to make all plays at SS- has a good clock though and can fill in there- Sneaky pwr/pop- deceptive hustling runner above avg- more 2B's type bat, speed, range and nice tools to be an everyday guy!!",
    date_seen: "09/19/2019"
  },
  updated_at: ~N[2019-09-19 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 2,
  player_id: 11,
  report_type: 1,
  grade: 55,
  position: :second_base,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "'BASEBALL PLAYER' DOES A LOT OF THINGS WELL AND PLAYS GAME THE RIGHT WAY. HUSTLES ALL THE TIME, AGGRESSIVE ON BASES AND PESKY HITTER AND  GOOD SITUATIONAL HITTER. VERY SOUND AT 2B  ALSO PLAYED SOME 3B AND LF  DID OK THERE.   SOME EXTRA BASE POWER- GOES WELL WITH THE PITCH.",
    date_seen: "09/15/2018"
  },
  updated_at: ~N[2018-09-15 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 11,
  report_type: 1,
  grade: 55,
  position: :second_base,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "everyday ML 2B,  not flashy, just steady blue-collar baseball player. plays with old school mentality.  handsy hitter who works count and shows good discipline. has doubles power. solid defender, w/ 55ish range, hands and arm. good instincts in middle of field, seems to always be where ball is hit. keep the line moving type",
    date_seen: "08/25/2018"
  },
  updated_at: ~N[2018-08-25 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 10,
  report_type: 1,
  grade: 55,
  position: :right_field,
  details: %Details{
    time_to_first: "3.2",
    summary:
      "Plenty of tools needs to put them all together... Routes and jumps in CF/RF are AA with good closing speed and plus arm. Needs to adjust his approach at the plate and must use his bunt game an maximize his tools. Can play all 3 outfield spots and steal a base off the bench. Def was solid avg to plus. He needs to overhaul his swing this off-season. I still see him as an extra OF'er at this stage of development.",
    date_seen: "09/07/2019"
  },
  updated_at: ~N[2019-09-07 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 1,
  report_type: 0,
  grade: 70,
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
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
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
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
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
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
  position: :pitcher,
  details: %Details{
    pitcher_role: "Starter",
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
  position: :pitcher,
  details: %Details{
    pitcher_role: "Bulk",
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
  position: :right_field,
  details: %Details{
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
  position: :right_field,
  details: %Details{
    time_to_first: "4.8",
    summary:
      "Good young player, looks like he has fun every day. Fringy power -- more line drive hitter. Above avg runner that can swipe bags, get too greedy sometimes. Needs to hit better for his position and role.",
    date_seen: "09/22/2019"
  },
  updated_at: ~N[2019-09-22 14:53:27]
})

Repo.insert!(%ScoutingReport{
  user_id: 1,
  player_id: 4,
  report_type: 1,
  grade: 50,
  position: :center_field,
  details: %Details{
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
  position: :first_base,
  details: %Details{
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
  position: :designated_hitter,
  details: %Details{
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
  position: :designated_hitter,
  details: %Details{
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
  position: :center_field,
  details: %Details{
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
  position: :third_base,
  details: %Details{
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
  position: :third_base,
  details: %Details{
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
  position: :pitcher,
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
  position: :pitcher,
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
  position: :pitcher,
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
