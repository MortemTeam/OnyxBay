
/*
 * Backpack
 */

/obj/item/weapon/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_backpacks.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_backpacks.dmi',
		)
	icon_state = "backpack"
	item_state = null
	//most backpacks use the default backpack state for inhand overlays
	item_state_slots = list(
		slot_l_hand_str = "backpack",
		slot_r_hand_str = "backpack",
		)
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_LARGE
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	use_sound = "searching_clothes"

/obj/item/weapon/storage/backpack/equipped()
	if(!has_extension(src, /datum/extension/appearance))
		set_extension(src, /datum/extension/appearance, /datum/extension/appearance/cardborg)
	..()

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	return ..()

/obj/item/weapon/storage/backpack/equipped(mob/user, slot)
	if (slot == slot_back && src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	..(user, slot)

/*
 * Backpack Types
 */

/obj/item/weapon/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = list(TECH_BLUESPACE = 4)
	icon_state = "holdingpack"
	max_w_class = ITEM_SIZE_GARGANTUAN
	max_storage_space = 56

/obj/item/weapon/storage/backpack/holding/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/storage/backpack/holding))
		investigate_log("has become a singularity. Caused by [user.key]", "singulo")
		to_chat(usr, "\red The Bluespace interfaces of the two devices catastrophically malfunction!")
		qdel(W)
		new /obj/singularity(src.loc, 300)
		log_and_message_admins("detonated a bag of holding", user, src.loc)
		qdel(src)
		return
	..()

/obj/item/weapon/storage/backpack/santabag
	name = "\improper Santa's gift bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space for Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = ITEM_SIZE_HUGE
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = 400 // can store a ton of shit!
	item_state_slots = null

/obj/item/weapon/storage/backpack/santabag/fake
	desc = "Space Santa uses this to deliver toys to all the nice children in space for Christmas! It would seem to be very large, but in real life there is no place for fairy tales."
	max_storage_space = DEFAULT_BACKPACK_STORAGE

/obj/item/weapon/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"

/obj/item/weapon/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "It's a backpack made by Honk! Co."
	icon_state = "clownpack"
	item_state_slots = null

/obj/item/weapon/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state_slots = null

/obj/item/weapon/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state_slots = null

/obj/item/weapon/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for officers."
	icon_state = "captainpack"
	item_state_slots = null

/obj/item/weapon/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of industrial life."
	icon_state = "engiepack"
	item_state_slots = null

/obj/item/weapon/storage/backpack/toxins
	name = "scientist backpack"
	desc = "It's a light backpack modeled for use in laboratories and other scientific institutions."
	icon_state = "toxpack"

/obj/item/weapon/storage/backpack/nanotrasen
	name = "\improper NanoTrasen backpack"
	desc = "It's a light backpack modeled for use in laboratories and other scientific institutions. The colors on it denote it as a NanoTrasen backpack."
	icon_state = "ntpack"

/obj/item/weapon/storage/backpack/hydroponics
	name = "herbalist's backpack"
	desc = "It's a green backpack with many pockets to store plants and tools in."
	icon_state = "hydpack"

/obj/item/weapon/storage/backpack/genetics
	name = "geneticist backpack"
	desc = "It's a backpack fitted with slots for diskettes and other workplace tools."
	icon_state = "genpack"

/obj/item/weapon/storage/backpack/virology
	name = "sterile backpack"
	desc = "It's a sterile backpack able to withstand different pathogens from entering its fabric."
	icon_state = "viropack"

/obj/item/weapon/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "It's an orange backpack which was designed to hold beakers, pill bottles and bottles."
	icon_state = "chempack"

/*
 * Duffle Types
 */

/obj/item/weapon/storage/backpack/dufflebag
	name = "dufflebag"
	desc = "A large dufflebag for holding extra things."
	icon_state = "duffle"
	item_state_slots = null
	w_class = ITEM_SIZE_HUGE
	max_storage_space = DEFAULT_BACKPACK_STORAGE + 10

/obj/item/weapon/storage/backpack/dufflebag/New()
	..()
	slowdown_per_slot[slot_back] = 1
	slowdown_per_slot[slot_r_hand] = 1
	slowdown_per_slot[slot_l_hand] = 1

/obj/item/weapon/storage/backpack/dufflebag/syndie
	name = "black dufflebag"
	desc = "A large dufflebag for holding extra tactical supplies."
	icon_state = "duffle_syndie"

/obj/item/weapon/storage/backpack/dufflebag/syndie/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra tactical medical supplies."
	icon_state = "duffle_syndiemed"

/obj/item/weapon/storage/backpack/dufflebag/syndie/ammo
	name = "ammunition dufflebag"
	desc = "A large dufflebag for holding extra weapons ammunition and supplies."
	icon_state = "duffle_syndieammo"

/obj/item/weapon/storage/backpack/dufflebag/captain
	name = "captain's dufflebag"
	desc = "A large dufflebag for holding extra captainly goods."
	icon_state = "duffle_captain"

/obj/item/weapon/storage/backpack/dufflebag/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra medical supplies."
	icon_state = "duffle_med"

/obj/item/weapon/storage/backpack/dufflebag/sec
	name = "security dufflebag"
	desc = "A large dufflebag for holding extra security supplies and ammunition."
	icon_state = "duffle_sec"

/obj/item/weapon/storage/backpack/dufflebag/eng
	name = "industrial dufflebag"
	desc = "A large dufflebag for holding extra tools and supplies."
	icon_state = "duffle_eng"

//FOR GLADIATORS

/obj/item/weapon/storage/backpack/dufflebag/red
	name = "red dufflebag"
	icon_state = "redteam"

/obj/item/weapon/storage/backpack/dufflebag/green
	name = "green dufflebag"
	icon_state = "greenteam"

/obj/item/weapon/storage/backpack/dufflebag/blue
	name = "blue dufflebag"
	icon_state = "blueteam"

/obj/item/weapon/storage/backpack/dufflebag/noteam
	name = "just dufflebag"

/*
 * Satchel Types
 */

/obj/item/weapon/storage/backpack/satchel
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/weapon/storage/backpack/satchel/grey
	name = "grey satchel"

/obj/item/weapon/storage/backpack/satchel/grey/withwallet
	startswith = list(/obj/item/weapon/storage/wallet/random)

/obj/item/weapon/storage/backpack/satchel/leather //brown, master type
	name = "brown leather satchel"
	desc = "A very fancy satchel made of some kind of leather."
	icon_state = "satchel"
	color = "#3d2711"

/obj/item/weapon/storage/backpack/satchel/leather/khaki
	name = "khaki leather satchel"
	color = "#baa481"

/obj/item/weapon/storage/backpack/satchel/leather/black
	name = "black leather satchel"
	color = "#212121"

/obj/item/weapon/storage/backpack/satchel/leather/navy
	name = "navy leather satchel"
	color = "#1c2133"

/obj/item/weapon/storage/backpack/satchel/leather/olive
	name = "olive leather satchel"
	color = "#544f3d"

/obj/item/weapon/storage/backpack/satchel/leather/reddish
	name = "auburn leather satchel"
	color = "#512828"

/obj/item/weapon/storage/backpack/satchel/pocketbook //black, master type
	name = "black pocketbook"
	desc = "A neat little folding clasp pocketbook with a shoulder sling."
	icon_state = "pocketbook"
	w_class = ITEM_SIZE_HUGE // to avoid recursive backpacks
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_LARGEBOX_STORAGE
	color = "#212121"

/obj/item/weapon/storage/backpack/satchel/pocketbook/brown
	name = "brown pocketbook"
	color = "#3d2711"

/obj/item/weapon/storage/backpack/satchel/pocketbook/reddish
	name = "auburn pocketbook"
	color = "#512828"

/obj/item/weapon/storage/backpack/satchel_eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"
	item_state_slots = list(
		slot_l_hand_str = "engiepack",
		slot_r_hand_str = "engiepack",
		)

/obj/item/weapon/storage/backpack/satchel_med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state_slots = list(
		slot_l_hand_str = "medicalpack",
		slot_r_hand_str = "medicalpack",
		)

/obj/item/weapon/storage/backpack/satchel_vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"

/obj/item/weapon/storage/backpack/satchel_chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"

/obj/item/weapon/storage/backpack/satchel_gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"

/obj/item/weapon/storage/backpack/satchel_tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"

/obj/item/weapon/storage/backpack/satchel_nt
	name = "\improper NanoTrasen satchel"
	desc = "Useful for holding research materials. The colors on it denote it as a NanoTrasen bag."
	icon_state = "satchel-nt"

/obj/item/weapon/storage/backpack/satchel_sec
	name = "security satchel"
	desc = "A robust satchel for security related needs."
	icon_state = "satchel-sec"
	item_state_slots = list(
		slot_l_hand_str = "securitypack",
		slot_r_hand_str = "securitypack",
		)

/obj/item/weapon/storage/backpack/satchel_hyd
	name = "hydroponics satchel"
	desc = "A green satchel for plant related work."
	icon_state = "satchel_hyd"

/obj/item/weapon/storage/backpack/satchel_cap
	name = "captain's satchel"
	desc = "An exclusive satchel for officers."
	icon_state = "satchel-cap"
	item_state_slots = list(
		slot_l_hand_str = "satchel-cap",
		slot_r_hand_str = "satchel-cap",
		)

//ERT backpacks.
/obj/item/weapon/storage/backpack/ert
	name = "emergency response team backpack"
	desc = "A spacious backpack with lots of pockets, used by members of the Emergency Response Team."
	icon_state = "ert_commander"
	item_state_slots = list(
		slot_l_hand_str = "securitypack",
		slot_r_hand_str = "securitypack",
		)

//Commander
/obj/item/weapon/storage/backpack/ert/commander
	name = "emergency response team commander backpack"
	desc = "A spacious backpack with lots of pockets, worn by the commander of an Emergency Response Team."

//Security
/obj/item/weapon/storage/backpack/ert/security
	name = "emergency response team security backpack"
	desc = "A spacious backpack with lots of pockets, worn by security members of an Emergency Response Team."
	icon_state = "ert_security"

//Engineering
/obj/item/weapon/storage/backpack/ert/engineer
	name = "emergency response team engineer backpack"
	desc = "A spacious backpack with lots of pockets, worn by engineering members of an Emergency Response Team."
	icon_state = "ert_engineering"

//Medical
/obj/item/weapon/storage/backpack/ert/medical
	name = "emergency response team medical backpack"
	desc = "A spacious backpack with lots of pockets, worn by medical members of an Emergency Response Team."
	icon_state = "ert_medical"

/*
 * Messenger Bags
 */

/obj/item/weapon/storage/backpack/messenger
	name = "messenger bag"
	desc = "A sturdy backpack worn over one shoulder."
	icon_state = "courierbag"

/obj/item/weapon/storage/backpack/messenger/chem
	name = "chemistry messenger bag"
	desc = "A serile backpack worn over one shoulder.  This one is in Chemsitry colors."
	icon_state = "courierbagchem"

/obj/item/weapon/storage/backpack/messenger/med
	name = "medical messenger bag"
	desc = "A sterile backpack worn over one shoulder used in medical departments."
	icon_state = "courierbagmed"

/obj/item/weapon/storage/backpack/messenger/viro
	name = "virology messenger bag"
	desc = "A sterile backpack worn over one shoulder.  This one is in Virology colors."
	icon_state = "courierbagviro"

/obj/item/weapon/storage/backpack/messenger/tox
	name = "research messenger bag"
	desc = "A backpack worn over one shoulder.  Useful for holding science materials."
	icon_state = "courierbagtox"

/obj/item/weapon/storage/backpack/messenger/nt
	name = "\improper NanoTrasen messenger bag"
	desc = "A backpack worn over one shoulder.  Useful for holding science materials. The colors on it denote it as a NanoTrasen bag."
	icon_state = "courierbagnt"

/obj/item/weapon/storage/backpack/messenger/com
	name = "captain's messenger bag"
	desc = "A special backpack worn over one shoulder.  This one is made specifically for officers."
	icon_state = "courierbagcom"

/obj/item/weapon/storage/backpack/messenger/engi
	name = "engineering messenger bag"
	desc = "A strong backpack worn over one shoulder. This one is designed for Industrial work."
	icon_state = "courierbagengi"

/obj/item/weapon/storage/backpack/messenger/hyd
	name = "hydroponics messenger bag"
	desc = "A backpack worn over one shoulder.  This one is designed for plant-related work."
	icon_state = "courierbaghyd"

/obj/item/weapon/storage/backpack/messenger/sec
	name = "security messenger bag"
	desc = "A tactical backpack worn over one shoulder. This one is in Security colors."
	icon_state = "courierbagsec"

//Smuggler's satchel
/obj/item/weapon/storage/backpack/satchel/flat
	name = "\improper Smuggler's satchel"
	desc = "A very slim satchel that can easily fit into tight spaces."
	icon_state = "satchel-flat"
	item_state = "satchel-norm"
	level = 1
	w_class = ITEM_SIZE_NORMAL //Can fit in backpacks itself.
	storage_slots = 5
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = 15
	cant_hold = list(/obj/item/weapon/storage/backpack/satchel/flat) //muh recursive backpacks
	startswith = list(
		/obj/item/stack/tile/floor,
		/obj/item/weapon/crowbar
		)

/obj/item/weapon/storage/backpack/satchel/flat/hide(i)
	set_invisibility(i ? 101 : 0)
	anchored = i ? TRUE : FALSE
	alpha = i ? 128 : initial(alpha)

/obj/item/weapon/storage/backpack/carppack
	name = "Space carp backpack"
	desc = "It's a backpack made of real space carp."
	icon_state = "carppack"

/obj/item/weapon/storage/backpack/messenger/shoulder_bag
	name = "shoulder bag"
	desc = "A complex backpack with multiple compartments."
	icon_state = "shoulder_bag"