# Fonction de join Spleef


# Détection et ajout/retrait du tag SpleefJoin
    execute unless score SpleefFull Value matches 1 store success score SpleefJoin bool run tag @s add SpleefJoin
    execute unless score SpleefFull Value matches 1 unless score SpleefJoin bool matches 1 run tag @s remove SpleefJoin

    # |Message| Join file d'attente
        execute unless score SpleefFull Value matches 1 if score SpleefJoin bool matches 1 run me a rejoint le lobby Spleef !

    # |Message| Leave file d'attente
        execute unless score SpleefFull Value matches 1 unless score SpleefJoin bool matches 1 run me a quitté le lobby Spleef !

    # Reset bool verificator
        scoreboard players reset SpleefJoin bool

# Détection présence file d'attente
    execute unless score SpleefFull Value matches 1 store result score SpleefJoin Value if entity @a[tag=SpleefJoin]

# |Fast join| Join si lobby créé et TP world après lancement file d'attente si +2 joueurs
    execute unless score SpleefFull Value matches 1 if score SpleefWaiting bool matches 1 in spleef2 run tp @s 0.5 0 0.5 0 3

# Activation lancement si Joueurs >= 2
    # Schedule
    execute unless score SpleefFull Value matches 1 store success score SpleefJoinWaiting bool if score SpleefJoin Value matches 2 run schedule function spleef:join 5s
    # Annonce
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1 if score SpleefJoin Value matches 2 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" La file d'attente a été lancée ! Rejoindez-tous le Spleef.","color":"aqua"}]

# Reset lancement SI leave penant lancement
    # Cancel schedule if enable
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1 if score SpleefJoin Value matches 1 run schedule clear spleef:join
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1 if score SpleefJoin Value matches 1 run schedule clear spleef:start
    # TP
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1 if score SpleefJoin Value matches 1 as @a[tag=SpleefJoin,nbt={Dimension:"minecraft:spleef2"}] in overworld run tp @s 64.0 -31 154.5 -180 0
    # Annonce
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1 if score SpleefJoin Value matches 1 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" La file d'attente a été annulée ! Retour au hub...","color":"aqua"}]
    # Clear waiting & Fast join
    execute unless score SpleefFull Value matches 1 if score SpleefJoinWaiting bool matches 1.. if score SpleefJoin Value matches 1 run scoreboard players reset SpleefJoinWaiting bool
    execute if score SpleefJoin Value matches 1 run scoreboard players reset SpleefWaiting bool
