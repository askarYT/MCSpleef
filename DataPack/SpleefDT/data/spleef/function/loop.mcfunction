# Fonction de loop activé après start.mcfunction


# Timer de pré-lancement | Message
    execute if score spleefprestart Time matches 3 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Lancement dans 3..","color":"aqua"}]
    execute if score spleefprestart Time matches 2 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Lancement dans 2..","color":"aqua"}]
    execute if score spleefprestart Time matches 1 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Lancement dans 1..","color":"aqua"}]
    execute if score spleefprestart Time matches 0 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Démarrage en cours...","color":"aqua"}]

    # Timer
    execute unless score spleefprestart Time matches ..-1 run scoreboard players remove spleefprestart Time 1

# Préparation du jeu
    # Set Timer lancement + randomize position joueurs
    execute if score spleefprestart Time matches -1 unless score spleefstart bool matches 1 run scoreboard players set spleefstart Time 5
    execute if score spleefprestart Time matches -1 unless score spleefstart bool matches 1 store success score spleefstart bool in minecraft:spleef2 run spreadplayers 11.5 76.5 8 30 under -32 false @a[tag=Joueur]
    # Retrait des mouvements aux joueurs
    execute if score spleefstart Time matches 5 as @a[tag=Joueur] run attribute @s generic.movement_speed base set 0
    execute if score spleefstart Time matches 5 as @a[tag=Joueur] run attribute @s generic.jump_strength base set 0

# Timer de lancement | Message
    execute if score spleefstart Time matches 5 run title @a actionbar {"text":"5","color":"green"}
    execute if score spleefstart Time matches 5 as @a at @s run playsound entity.arrow.hit_player ambient @s ~ ~ ~ .8 1.10
    execute if score spleefstart Time matches 4 run title @a actionbar {"text":"4","color":"green"}
    execute if score spleefstart Time matches 4 as @a at @s run playsound entity.arrow.hit_player ambient @s ~ ~ ~ .8 1.15
    execute if score spleefstart Time matches 3 run title @a actionbar {"text":"3","color":"green"}
    execute if score spleefstart Time matches 3 as @a at @s run playsound entity.arrow.hit_player ambient @s ~ ~ ~ .8 1.20
    execute if score spleefstart Time matches 2 run title @a actionbar {"text":"2","color":"green"}
    execute if score spleefstart Time matches 2 as @a at @s run playsound entity.arrow.hit_player ambient @s ~ ~ ~ .8 1.25
    execute if score spleefstart Time matches 1 run title @a actionbar {"text":"1","color":"green"}
    execute if score spleefstart Time matches 1 as @a at @s run playsound entity.arrow.hit_player ambient @s ~ ~ ~ .8 1.30
    execute if score spleefstart Time matches 0 run title @a actionbar {"text":"Go !","color":"green"}
    execute if score spleefstart Time matches 0 as @a at @s run playsound entity.player.levelup ambient @s ~ ~ ~ .8 1.15

    # Remise des mouvements aux joueurs
    execute if score spleefstart Time matches 0 as @a[tag=Joueur] run attribute @s generic.movement_speed base set 0.10000000149011612
    execute if score spleefstart Time matches 0 as @a[tag=Joueur] run attribute @s generic.jump_strength base set 0.41999998688697815

    # Lock spleef:loop.mcfunction 1s --> 1t
    execute if score spleefstart Time matches 0 run scoreboard players set spleefstartlock bool 1

    # Activation death match
    execute if score spleefstart Time matches 0 in spleef2 run schedule function spleef:deathmatch 180s

    # Timer
    execute unless score spleefstart Time matches ..-1 run scoreboard players remove spleefstart Time 1

# Finalists detection
    # Stockage value |Final Value| en détectant les joueurs non-spectateur
    execute store result score Final Value if entity @a[tag=Joueur,gamemode=!spectator]
    # 3ème
    execute if score Final Value matches 3 in minecraft:spleef2 as @a[tag=Joueur,gamemode=!spectator,scores={Life=1}] at @s if block ~ ~-2 ~ lava run tag @s add 3
    execute if score Final Value matches 3 in minecraft:spleef2 as @a[tag=Joueur,gamemode=!spectator,scores={Life=1}] at @s if block ~ ~ ~ lava run tag @s add 3
    # 2ème
    execute if score Final Value matches 2 in minecraft:spleef2 as @a[tag=Joueur,gamemode=!spectator,scores={Life=1}] at @s if block ~ ~-2 ~ lava run tag @s add 2
    execute if score Final Value matches 2 in minecraft:spleef2 as @a[tag=Joueur,gamemode=!spectator,scores={Life=1}] at @s if block ~ ~ ~ lava run tag @s add 2
    # 1er
    execute if score Final Value matches 1 in minecraft:spleef2 as @a[tag=Joueur,gamemode=!spectator,limit=1] run tag @s add 1

# Gestion joueurs
    # Item replace snowball + shovel
        execute if score spleefstartlock bool matches 1 run execute as @a[tag=Joueur] run item replace entity @s hotbar.0 with snowball[can_break={predicates:[{blocks:"snow_block"},{blocks:"#concrete_powder"},{blocks:"tripwire"}]},custom_name='{"color":"aqua","italic":false,"text":"Boule de neige"}',lore=['"Attaque lance neige !"'],custom_data={spleef:1b},enchantments={levels:{"minecraft:knockback":3,"minecraft:punch":10,"minecraft:binding_curse":1}},attribute_modifiers={modifiers:[{id:"armor",type:"generic.attack_damage",amount:.01,operation:"add_value",slot:"mainhand"}],show_in_tooltip:false}] 16
        execute if score spleefstartlock bool matches 1 run execute as @a[tag=Joueur] run item replace entity @s hotbar.1 with iron_shovel[can_break={predicates:[{blocks:"snow_block"},{blocks:"#concrete_powder"},{blocks:"tripwire"}]},custom_name='{"color":"gold","italic":false,"text":"Sainte pouelle !"}',lore=['"Permet d\'éradiquer"','"toute sorte d\'ennemis"','"ou juste creuser leur tombes !"'],unbreakable={},custom_data={spleef:1b},enchantments={levels:{"minecraft:efficiency":5},show_in_tooltip:false},attribute_modifiers={modifiers:[],show_in_tooltip:false}] 1
    # Vie joueurs
        # Gestion perte vie
        execute as @a[tag=Joueur] at @s if block ~ ~-2 ~ lava unless score @s Life matches ..0 run scoreboard players remove @s Life 1
        execute as @a[tag=Joueur] at @s if block ~ ~-2 ~ lava unless score @s Life matches ..0 run damage @s 2
        execute as @a[tag=Joueur] at @s if block ~ ~ ~ lava unless score @s Life matches ..0 run scoreboard players remove @s Life 1
        execute as @a[tag=Joueur] at @s if block ~ ~ ~ lava unless score @s Life matches ..0 run damage @s 2
        # Gestion mort
        execute as @a[tag=Joueur] at @s if block ~ ~-2 ~ lava if score @s Life matches 0 run gamemode spectator @s
        execute as @a[tag=Joueur] at @s if block ~ ~ ~ lava if score @s Life matches 0 run gamemode spectator @s
        # ReTP sur map
        execute as @a[tag=Joueur] at @s if block ~ ~-2 ~ lava in minecraft:spleef2 run spreadplayers 11.5 76.5 8 30 under -32 false @s
        execute as @a[tag=Joueur] at @s if block ~ ~ ~ lava in minecraft:spleef2 run spreadplayers 11.5 76.5 8 30 under -32 false @s

# Clear spleef items
    execute in minecraft:spleef2 as @e[type=item,nbt={Item:{components:{"minecraft:custom_data":{spleef:1b}}}}] run kill @s

# Kill falling blocks
    execute in spleef2 as @e[type=falling_block] at @s if block ~ ~-2 ~ lava run kill @s
    execute in spleef2 as @e[type=falling_block] at @s if block ~ ~-1 ~ lava run kill @s

# Loop
    # Loop timer pré-lancement + lancement
    execute in minecraft:spleef2 unless score spleefstartlock bool matches 1 run schedule function spleef:loop 1s
    # Loop mj en cours
    execute in minecraft:spleef2 if score spleefstartlock bool matches 1 run schedule function spleef:loop 1t

# Fin de jeu
    execute if score Final Value matches 1 run tellraw @a ["",{"text":"Fin de jeu !","bold":true,"underlined":true,"color":"gold"},{"text":"\n\n\u226b Victoire de "},{"selector":"@a[tag=1,limit=1]"},{"text":" ! \u226a\n\n"},{"text":"Scores :","bold":true,"underlined":true,"color":"aqua"},{"text":"\n\n"},{"text":"1er : ","color":"green"},{"selector":"@a[tag=1,limit=1]","color":"green"},{"text":" 30","color":"yellow"},{"text":"\uE000"},{"text":"\n"},{"text":"2ème : ","color":"blue"},{"selector":"@a[tag=2]","color":"blue"},{"text":" 15","color":"yellow"},{"text":"\uE000"},{"text":"\n"},{"text":"3ème : ","color":"red"},{"selector":"@a[tag=3]","color":"red"},{"text":" 10","color":"yellow"},{"text":"\uE000"}]
    execute if score Final Value matches 1 in minecraft:spleef2 run schedule function spleef:endgame 5s
    execute if score Final Value matches 1 in minecraft:spleef2 run function spleef:restart