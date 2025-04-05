# Fonction de réinitialisation du jeu manuelle/auto fin de jeu


# Stop des loop
    execute in spleef2 run schedule clear spleef:loop
    execute in spleef2 run schedule clear spleef:deathmatch

# Retrait des sb non nécessaire
    scoreboard objectives remove Life

# Reset sb
    scoreboard players set spleefprestart Time 5

    scoreboard players reset spleefstart
    scoreboard players reset spleefstartlock
    scoreboard players reset spleefdeathmatch

    scoreboard players reset SpleefFull Value

# Gestion joueurs
    # Reset attributes
    execute as @a[tag=Joueur] run attribute @s minecraft:generic.max_health base set 20
    execute as @a[tag=Joueur] run attribute @s generic.movement_speed base set 0.10000000149011612
    execute as @a[tag=Joueur] run attribute @s generic.jump_strength base set 0.41999998688697815
    # Clear inv & effects
    clear @a[tag=Joueur] *[custom_data={spleef:1b}]
    effect give @a instant_health 3 3 true

# Reset finalists tags
    tag @a remove 3
    tag @a remove 2
    tag @a remove 1

# Sécurité falling blocks & markers death's match
    execute in spleef2 run kill @e[type=falling_block]
    execute in spleef2 run kill @e[type=marker,tag=Spleef]

# Réinitialisation de map
    # Set redstone block sous minecraft:structure_block avec schématic savegardé de la map
    execute in minecraft:spleef2 run setblock -32 -63 33 redstone_block
    execute in minecraft:spleef2 run setblock 15 -62 33 redstone_block
    execute in minecraft:spleef2 run setblock -32 -62 80 redstone_block
    execute in minecraft:spleef2 run setblock 54 -62 80 redstone_block