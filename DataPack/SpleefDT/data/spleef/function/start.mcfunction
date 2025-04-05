# Fonction de lancement Spleef


# Ajout des SB nécessaire
    scoreboard objectives add Life dummy
    scoreboard objectives setdisplay list Life

# Gestion joueurs
    # Ajout/retrait tags joueurs
    tag @a[tag=SpleefJoin] add Joueur
    tag @a[tag=SpleefJoin] remove SpleefJoin
    # Ajout vie joueurs
    scoreboard players set @a[tag=Joueur] Life 3
    # Modification attributes
    execute as @a[tag=Joueur] run attribute @s minecraft:generic.max_health base set 6
    execute as @a[tag=Joueur] run attribute @s generic.knockback_resistance base set 0
    execute as @a[tag=Joueur] run attribute @s generic.attack_knockback base set 0
    execute as @a[tag=Joueur] run attribute @s generic.attack_damage base set 0

# Désactivation spam joueurs manquant start forcé
    execute in overworld run schedule clear spleef:join

# Activation loop mj
    execute in minecraft:spleef2 run function spleef:loop

# Message d'annonce au lancement
    tellraw @a ["",{"text":" \u0020 \u0020 \u0020 \u0020 \u0020 \u0020 | ","color":"gold"},{"text":"Spleef","bold":true,"underlined":true,"color":"gold"},{"text":" |","color":"gold"},{"text":"\nMap sélectionnée : "},{"text":"Village Rovaniemi","color":"green"},{"text":"\n\n \u0020"},{"text":"Début dans 5s...","italic":true,"color":"gray"}]

# Suppression file d'attente
    scoreboard players reset SpleefJoin
    scoreboard players set SpleefJoin Value 0
    scoreboard players reset SpleefJoinWaiting
    scoreboard players reset SpleefWaiting bool
    scoreboard players set SpleefFull Value 1