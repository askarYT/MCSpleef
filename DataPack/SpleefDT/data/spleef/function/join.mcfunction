# Fonction de join lobby après file d'attente


#
    execute unless score SpleefWaiting bool matches 1 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" En attente de 2 joueurs supplémentaire !","color":"aqua"}]
    execute unless score SpleefWaiting bool matches 1 run gamemode adventure @a[tag=SpleefJoin]
    execute unless score SpleefWaiting bool matches 1 store success score SpleefWaiting bool in spleef2 as @a[tag=SpleefJoin] run tp @s 0.5 0 0.5 0 3

    execute if score SpleefJoin Value matches 4 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Lancement dans 15s !","color":"aqua"}]

    execute if score SpleefJoin Value matches 4 run schedule function spleef:start 15s
    execute unless score SpleefJoin Value matches 4 run schedule function spleef:join 10t