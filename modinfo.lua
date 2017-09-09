-- This information tells other players more about the mod
name = "Brook"
description = "Dead Bones Brook from One Piece"
author = "kobyov and Dani the Marble"
version = "1.2.0"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true

-- Not compatible with Don't Starve
dont_starve_compatible = false
reign_of_giants_compatible = false

-- Character mods need this set to true
all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {
    "Brook",
    "One Piece",
}

--configuration_options = {}
configuration_options =
{
	{
        name = "BrookHealth",
        label = "Health",
        options =
        {
		    {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "70", data = 70},
            {description = "80", data = 80},
            {description = "90", data = 90},
            {description = "100", data = 100},
            {description = "110", data = 110},
            {description = "120", data = 120},
            {description = "130", data = 130},
            {description = "140", data = 140},
            {description = "150 (default)", data = 150},
            {description = "160", data = 160},
            {description = "170", data = 170},
            {description = "180", data = 180},
            {description = "190", data = 190},
            {description = "200", data = 200},
       },
        default = 150,
    },
    {
        name = "BrookSanity",
        label = "Sanity",
        options =
        {
		    {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "70", data = 70},
            {description = "80", data = 80},
            {description = "90", data = 90},
            {description = "100", data = 100},
            {description = "110", data = 110},
            {description = "120", data = 120},
            {description = "130 (default)", data = 130},
            {description = "140", data = 140},
            {description = "150", data = 150},
            {description = "160", data = 160},
            {description = "170", data = 170},
            {description = "180", data = 180},
            {description = "190", data = 190},
            {description = "200", data = 200},
            },
        default = 130,
    },
	{
        name = "BrookHunger",
        label = "Hunger",
        options =
        {
		    {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "70", data = 70},
            {description = "80", data = 80},
            {description = "90", data = 90},
            {description = "100", data = 100},
            {description = "110", data = 110},
            {description = "120", data = 120},
            {description = "130", data = 130},
            {description = "140", data = 140},
            {description = "150", data = 150},
            {description = "160", data = 160},
            {description = "170 (default)", data = 170},
            {description = "180", data = 180},
            {description = "190", data = 190},
            {description = "200", data = 200},
       },
        default = 170,
    },
	{
        name = "BrookDamage",
        label = "Damage",
        options =
        {
            {description = "0.75 (wes)", data = 0.75},
            {description = "1.0 (default)", data = 1.0},
            {description = "1.25 (wigfrid)", data = 1.25},
       },
        default = 1.0,
    },
}
