/datum/firemode/electrode
	name = "electrode"
	settings = list(projectile_type=/obj/item/projectile/energy/electrode)

/datum/firemode/stun
	name = "stun"
	settings = list(projectile_type=/obj/item/projectile/beam/stun)

/datum/firemode/shock
	name = "shock"
	settings = list(projectile_type=/obj/item/projectile/beam/stun/shock)

/datum/firemode/stun_heavy
	name = "heavy stun"
	settings = list(projectile_type=/obj/item/projectile/beam/stun/heavy)

/datum/firemode/shock_heavy
	name = "heavy shock"
	settings = list(projectile_type=/obj/item/projectile/beam/stun/shock/heavy)

/obj/item/weapon/gun/energy/taser
	name = "Mk30 NL"
	desc = "The NT Mk30 NL is a small, low capacity gun used for non-lethal takedowns. Produced by NT, it's actually a licensed version of a W-T design. It can switch between high and low intensity stun shots."
	icon_state = "taser"
	item_state = null	//so the human update icon uses the icon_state instead.
	max_shots = 5
	projectile_type = /obj/item/projectile/beam/stun
	combustion = 0
	force = 8.5
	mod_weight = 0.7
	mod_reach = 0.5
	mod_handy = 1.0

	firemodes = list(/datum/firemode/stun, /datum/firemode/shock)

/obj/item/weapon/gun/energy/taser/carbine
	name = "Mk44 NL"
	desc = "The NT Mk44 NL is a high capacity gun used for non-lethal takedowns. It can switch between high and low intensity stun shots."
	icon_state = "tasercarbine"
	w_class = ITEM_SIZE_LARGE
	slot_flags = SLOT_BELT|SLOT_BACK
	one_hand_penalty = 3
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	force = 12.5
	mod_weight = 1.0
	mod_reach = 0.8
	mod_handy = 1.0
	max_shots = 12
	accuracy = 1
	projectile_type = /obj/item/projectile/beam/stun/heavy
	wielded_item_state = "tasercarbine-wielded"

	firemodes = list(/datum/firemode/stun_heavy, /datum/firemode/shock_heavy)

/obj/item/weapon/gun/energy/taser/mounted
	name = "mounted taser gun"
	desc = "Modified NT Mk30 NL, designed to be mounted on cyborgs and other battle machinery. It can switch between high and low intensity stun beams, and concentrated stun spheres."
	icon_state = "btaser"
	self_recharge = 1
	use_external_power = 1
	projectile_type = /obj/item/projectile/energy/electrode

	firemodes = list(/datum/firemode/electrode, /datum/firemode/stun, /datum/firemode/shock)

/obj/item/weapon/gun/energy/taser/mounted/cyborg
	name = "taser gun"
	max_shots = 6
	fire_delay = 15
	recharge_time = 10 //Time it takes for shots to recharge (in ticks)


/obj/item/weapon/gun/energy/stunrevolver
	name = "stun revolver"
	desc = "A LAEP20 Zeus. Designed by Lawson Arms and produced under the wing of the FTU, several TSCs have been trying to get a hold of the blueprints for half a decade."
	icon_state = "stunrevolver"
	item_state = "stunrevolver"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 2)
	projectile_type = /obj/item/projectile/energy/electrode
	max_shots = 6
	combustion = 0

/obj/item/weapon/gun/energy/stunrevolver/rifle
	name = "stun rifle"
	desc = "A LAEP38 Thor, a vastly oversized variant of the LAEP20 Zeus. Fires overcharged electrodes to take down hostile armored targets without harming them too much."
	icon_state = "stunrifle"
	item_state = "stunrifle"
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK
	one_hand_penalty = 6
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	force = 10
	max_shots = 10
	accuracy = 1
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	wielded_item_state = "stunrifle-wielded"

/obj/item/weapon/gun/energy/crossbow
	name = "mini energy-crossbow"
	desc = "A crossbow that doesn't seem to have space for bolts."
	icon_state = "crossbow"
	w_class = ITEM_SIZE_NORMAL
	item_state = "crossbow"
	origin_tech = list(TECH_COMBAT = 2, TECH_MAGNET = 2, TECH_ILLEGAL = 5)
	matter = list(MATERIAL_STEEL = 2000)
	slot_flags = SLOT_BELT
	silenced = 1
	fire_sound = 'sound/effects/weapons/gun/fire_dart1.ogg'
	projectile_type = /obj/item/projectile/energy/bolt
	max_shots = 8
	self_recharge = 1
	charge_meter = 0
	combustion = 0

/obj/item/weapon/gun/energy/crossbow/ninja
	name = "energy dart thrower"
	projectile_type = /obj/item/projectile/energy/dart
	max_shots = 5

/obj/item/weapon/gun/energy/crossbow/largecrossbow
	name = "energy crossbow"
	desc = "A weapon favored by syndicate infiltration teams."
	w_class = ITEM_SIZE_LARGE
	force = 10
	one_hand_penalty = 1
	matter = list(MATERIAL_STEEL = 200000)
	projectile_type = /obj/item/projectile/energy/bolt/large

/obj/item/weapon/gun/energy/plasmastun
	name = "plasma pulse projector"
	desc = "The Mars Military Industries MA21 Selkie is a weapon that uses a laser pulse to ionise the local atmosphere, creating a disorienting pulse of plasma and deafening shockwave as the wave expands."
	icon_state = "plasma_stun"
	item_state = "plasma_stun"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_POWER = 3)
	fire_delay = 20
	max_shots = 4
	projectile_type = /obj/item/projectile/energy/plasmastun
	combustion = 0

/obj/item/weapon/gun/energy/classictaser
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon_state = "taser"
	item_state = null
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 2)
	projectile_type = /obj/item/projectile/energy/electrode/stunsphere
	max_shots = 5
	combustion = 0
	force = 8.5
	mod_weight = 0.7
	mod_reach = 0.5
	mod_handy = 1.0
