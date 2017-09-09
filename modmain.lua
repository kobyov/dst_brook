PrefabFiles = {
	"brook",
    "swordcane",
    "violin",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/brook.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/brook.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/brook.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/brook.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/brook_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/brook_silho.xml" ),

    Asset( "IMAGE", "bigportraits/brook.tex" ),
    Asset( "ATLAS", "bigportraits/brook.xml" ),
	
	Asset( "IMAGE", "images/map_icons/brook.tex" ),
	Asset( "ATLAS", "images/map_icons/brook.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_brook.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_brook.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_brook.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_brook.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RecipeTabs = GLOBAL.RECIPETABS
local Tech = GLOBAL.TECH
local TUNING = GLOBAL.TUNING

STRINGS.NAMES.SWORDCANE = "Humming Sword"
STRINGS.NAMES.VIOLIN = "Brook's Violin"

-- The character select screen lines
STRINGS.CHARACTER_TITLES.brook = "The Gentleman Skeleton"
STRINGS.CHARACTER_NAMES.brook = "Brook"
STRINGS.CHARACTER_DESCRIPTIONS.brook = "*Skeleton\n*Musician\n*Coward"
STRINGS.CHARACTER_QUOTES.brook = "\"Yohohoho!\""

-- Custom speech strings
STRINGS.CHARACTERS.BROOK = require "speech_brook"

-- The character's name as appears in-game 
STRINGS.NAMES.BROOK = "Brook"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BROOK = 
{
	GENERIC = "It's Brook!",
	ATTACKER = "That Brook looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Brook, friend of ghosts.",
	GHOST = "Brook needs a heart; then again he always does.",
}


AddMinimapAtlas("images/map_icons/brook.xml")

-- Pull in config data
TUNING.BROOK = {}
TUNING.BROOK["health"] = GetModConfigData("BrookHealth")
TUNING.BROOK["hunger"] = GetModConfigData("BrookHunger")
TUNING.BROOK["sanity"] = GetModConfigData("BrookSanity")
TUNING.BROOK["damage"] = GetModConfigData("BrookDamage")
TUNING.BROOK["coldresist"] = GetModConfigData("BrookHypoIns")
TUNING.BROOK["heatresist"] = GetModConfigData("BrookHyperIns")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("brook", "MALE")

-- Crafting Recipies
AddRecipe("violin", {Ingredient("silk", 4),Ingredient("livinglog", 1)}, RecipeTabs.MAGIC, Tech.NONE, nil, nil, nil, nil, "deadbones", "images/inventoryimages/violin.xml", "violin.tex")
STRINGS.RECIPE_DESC.VIOLIN = "Yo-hohoho, Yo-hohoho"

AddRecipe("swordcane", {Ingredient("thulecite", 2),Ingredient("livinglog", 1),Ingredient("ice", 20)}, RecipeTabs.WAR, Tech.NONE, nil, nil, nil, nil, "deadbones", "images/inventoryimages/swordcane.xml", "swordcane.tex")
STRINGS.RECIPE_DESC.SWORDCANE = "Harness the icy winds of death"
