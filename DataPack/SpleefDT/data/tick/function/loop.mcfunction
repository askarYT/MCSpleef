# Fonction TICK du jeu


# Détection présence file d'attente
    # Spleef
    execute store result score SpleefJoin Value if entity @a[tag=SpleefJoin]

# Mise à jour des panneau join lobby
    # Spleef
    execute in overworld at @e[tag=SpleefSign,type=marker] if block ~ ~ ~ air run setblock ~ ~ ~ oak_wall_sign[facing=west]
    execute in overworld at @e[tag=SpleefSign,type=marker] run data merge block ~ ~ ~ {front_text:{messages:['{"text":"Lobby1","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function main:spleef-join"}}','[{"score":{"name":"SpleefJoin","objective":"Value"}},"/",{"score":{"name":"SpleefMaxPlayers","objective":"Value"}}]','{"text":""}','{"text":""}']}}

# Détection de deconnection
    execute as @a[tag=SpleefJoin,scores={Disconnection=1..}] run tag @s remove SpleefJoin
    execute as @a[tag=Joueur,scores={Disconnection=1..}] run tag @s remove Joueur
    execute as @a[scores={Disconnection=1..}] run tp @s 64.0 -31 154.5 -180 0
    execute as @a[scores={Disconnection=1..}] run scoreboard players reset @s Disconnection

execute at @e[tag=SignMarkers] run particle flame ~ ~ ~ 0 0 0 0.1 0