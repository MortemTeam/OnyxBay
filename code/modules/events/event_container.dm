#define ASSIGNMENT_ANY "Any"
#define ASSIGNMENT_AI "AI"
#define ASSIGNMENT_CYBORG "Cyborg"
#define ASSIGNMENT_ENGINEER "Engineer"
#define ASSIGNMENT_GARDENER "Gardener"
#define ASSIGNMENT_JANITOR "Janitor"
#define ASSIGNMENT_MEDICAL "Medical"
#define ASSIGNMENT_SCIENTIST "Scientist"
#define ASSIGNMENT_SECURITY "Security"

var/global/list/severity_to_string = list(
	EVENT_LEVEL_MUNDANE = "Mundane",
	EVENT_LEVEL_MODERATE = "Moderate",
	EVENT_LEVEL_MAJOR = "Major",
	EVENT_LEVEL_ARENA = "Arena",
)

/datum/event_container
	var/severity = -1
	var/delayed = 0
	var/delay_modifier = 1
	var/next_event_time = 0
	var/list/available_events
	var/list/last_event_time = list()
	var/datum/event_meta/next_event = null

	var/last_world_time = 0

/datum/event_container/proc/process()
	if(!next_event_time)
		set_event_delay()

	if(delayed || !config.allow_random_events)
		next_event_time += (world.time - last_world_time)
	else if(world.time > next_event_time)
		start_event()

	last_world_time = world.time

/datum/event_container/proc/start_event()
	if(!next_event)	// If non-one has explicitly set an event, randomly pick one
		next_event = acquire_event()

	// Has an event been acquired?
	if(next_event)
		// Set when the event of this type was last fired, and prepare the next event start
		last_event_time[next_event] = world.time
		set_event_delay()
		next_event.enabled = !next_event.one_shot	// This event will no longer be available in the random rotation if one shot

		new next_event.event_type(next_event)	// Events are added and removed from the processing queue in their New/kill procs

		log_debug("Starting event '[next_event.name]' of severity [severity_to_string[severity]].")
		next_event = null						// When set to null, a random event will be selected next time
	else
		// If not, wait for one minute, instead of one tick, before checking again.
		next_event_time += (60 * 10)


/datum/event_container/proc/acquire_event()
	if(available_events.len == 0)
		return
	var/active_with_role = number_active_with_role()

	var/list/possible_events = list()
	for(var/datum/event_meta/EM in available_events)
		var/event_weight = get_weight(EM, active_with_role)
		if(event_weight)
			possible_events[EM] = event_weight

	if(possible_events.len == 0)
		return null

	// Select an event and remove it from the pool of available events
	var/picked_event = pickweight(possible_events)
	return picked_event

/datum/event_container/proc/get_weight(datum/event_meta/EM, list/active_with_role)
	if(!EM.enabled)
		return 0

	var/weight = EM.get_weight(active_with_role)
	var/last_time = last_event_time[EM]
	if(last_time)
		var/time_passed = world.time - last_time
		var/weight_modifier = max(0, round((config.expected_round_length - time_passed) / 300))
		weight = weight - weight_modifier

	return weight

/datum/event_container/proc/set_event_delay()
	next_event_time = world.time + 600
	log_debug("Next event of severity [severity_to_string[severity]] in [(next_event_time - world.time)/600] minutes.")

/datum/event_container/proc/SelectEvent()
	var/datum/event_meta/EM = input("Select an event to queue up.", "Event Selection", null) as null|anything in available_events
	if(!EM)
		return
	if(next_event)
		available_events += next_event
	available_events -= EM
	next_event = EM
	return EM

/datum/event_container/mundane
	severity = EVENT_LEVEL_MUNDANE
	available_events = list(
		// Severity level, event name, even type, base weight, role weights, one shot, min weight, max weight. Last two only used if set and non-zero
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Nothing",			/datum/event/nothing,			100),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",		/datum/event/apc_damage,		20, 	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",/datum/event/brand_intelligence,10, 	list(ASSIGNMENT_JANITOR = 10),	1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",		/datum/event/camera_damage,		25, 	list(ASSIGNMENT_ENGINEER = 15)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",		/datum/event/economic_event,	300),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lost Carp",			/datum/event/carp_migration, 	20, 	list(ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",		/datum/event/money_hacker, 		0, 		list(ASSIGNMENT_ANY = 4), 1, 10, 25),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",		/datum/event/money_lotto, 		0, 		list(ASSIGNMENT_ANY = 1), 1, 5, 15),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Mundane News", 		/datum/event/mundane_news, 		300),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",	/datum/event/shipping_error	, 	30, 	list(ASSIGNMENT_ANY = 2), 0),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MUNDANE, "Space Dust",		/datum/event/dust	, 			30, 	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Sensor Suit Jamming",/datum/event/sensor_suit_jamming,50,	list(ASSIGNMENT_MEDICAL = 20, ASSIGNMENT_AI = 20), 1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",		/datum/event/trivial_news, 		300),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",/datum/event/infestation, 		100,	list(ASSIGNMENT_JANITOR = 100)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Wallrot",			/datum/event/wallrot, 			0,		list(ASSIGNMENT_ENGINEER = 35, ASSIGNMENT_GARDENER = 55)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MUNDANE, "Electrical Storm",	/datum/event/electrical_storm, 	20,		list(ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_JANITOR = 100)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Cold Outbreak",/datum/event/space_cold,		100,	list(ASSIGNMENT_MEDICAL = 20)),
	)

/datum/event_container/moderate
	severity = EVENT_LEVEL_MODERATE
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",					/datum/event/nothing,					1030),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 			/datum/event/spontaneous_appendicitis, 	0,		list(ASSIGNMENT_MEDICAL = 15), 1),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Carp School",				/datum/event/carp_migration,			100, 	list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_SECURITY = 20), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",	/datum/event/communications_blackout,	100,	list(ASSIGNMENT_AI = 100, ASSIGNMENT_ENGINEER = 20)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			10,		list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_JANITOR = 5)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Failure",			/datum/event/gravity,	 				75,		list(ASSIGNMENT_ENGINEER = 25)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",				/datum/event/grid_check, 				200,	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Ion Storm",				/datum/event/ionstorm, 					0,		list(ASSIGNMENT_AI = 50, ASSIGNMENT_CYBORG = 50, ASSIGNMENT_ENGINEER = 15, ASSIGNMENT_SCIENTIST = 5)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Meteor Shower",			/datum/event/meteor_wave,				0,		list(ASSIGNMENT_ENGINEER = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Prison Break",				/datum/event/prison_break,				0,		list(ASSIGNMENT_SECURITY = 10)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Radiation Storm",			/datum/event/radiation_storm, 			0,		list(ASSIGNMENT_MEDICAL = 40), 1),
		new /datum/event_meta/extended_penalty(EVENT_LEVEL_MODERATE, "Random Antagonist",/datum/event/random_antag,		2.5,	list(ASSIGNMENT_SECURITY = 1), 1, 0, 5),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Rogue Drones",				/datum/event/rogue_drone, 				20,		list(ASSIGNMENT_SECURITY = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Sensor Suit Jamming",		/datum/event/sensor_suit_jamming,		10,		list(ASSIGNMENT_MEDICAL = 20, ASSIGNMENT_AI = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Solar Storm",				/datum/event/solar_storm, 				10,		list(ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MODERATE, "Space Dust",				/datum/event/dust	, 					30, 	list(ASSIGNMENT_ENGINEER = 10)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virology Breach",			/datum/event/prison_break/virology,		0,		list(ASSIGNMENT_MEDICAL = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Xenobiology Breach",		/datum/event/prison_break/xenobiology,	0,		list(ASSIGNMENT_SCIENCE = 20)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Viral Infection",/datum/event/virus_minor,		0,	list(ASSIGNMENT_MEDICAL = 40)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wormholes",				 /datum/event/wormholes, 				10)
	)

/datum/event_container/major
	severity = EVENT_LEVEL_MAJOR
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",				/datum/event/nothing,			1320),
		// TODO [V] Return this back when lighting problem will be fixed
		// new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blob",				/datum/event/blob, 				0,	list(ASSIGNMENT_ENGINEER = 40), 1),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MAJOR, "Carp Migration",		/datum/event/carp_migration,	0,	list(ASSIGNMENT_SECURITY =  5), 1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Containment Breach",	/datum/event/prison_break/station,0,list(ASSIGNMENT_ANY = 5)),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MAJOR, "Meteor Wave",			/datum/event/meteor_wave,		0,	list(ASSIGNMENT_ENGINEER = 10),	1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Space Vines",			/datum/event/spacevine, 		0,	list(ASSIGNMENT_ENGINEER = 25), 1),
		new /datum/event_meta/no_overmap(EVENT_LEVEL_MAJOR, "Electrical Storm",	/datum/event/electrical_storm, 	0,	list(ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_JANITOR = 5)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Plague Infection",/datum/event/virus_major,		0,	list(ASSIGNMENT_MEDICAL = 35)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blob Outbreak", /datum/event/blob, 0, list(ASSIGNMENT_ANY = 1), is_one_shot = TRUE)
	)

/datum/event_container/arena
	severity = EVENT_LEVEL_ARENA
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_ARENA, "Supply drop",	/datum/event/supply_drop,	100),
	)

#undef ASSIGNMENT_ANY
#undef ASSIGNMENT_AI
#undef ASSIGNMENT_CYBORG
#undef ASSIGNMENT_ENGINEER
#undef ASSIGNMENT_GARDENER
#undef ASSIGNMENT_JANITOR
#undef ASSIGNMENT_MEDICAL
#undef ASSIGNMENT_SCIENTIST
#undef ASSIGNMENT_SECURITY
