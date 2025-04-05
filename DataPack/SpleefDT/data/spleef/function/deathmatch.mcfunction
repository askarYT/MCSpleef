# Fonction du match à mort si des survivants toujours présents après X minutes (voir loop.mcfunction)


# Message annonce
    execute unless score spleefdeathmatch bool matches 1 run tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Deathmatch en cours!","color":"aqua"}]

# Apparition de markers
    execute in spleef2 run summon minecraft:marker ~ ~ ~ {Tags:["Spleef"]}
    execute in spleef2 run spreadplayers 11.5 76.5 1 30 under -32 false @e[type=minecraft:marker,tag=Spleef]
    execute at @e[tag=Spleef,type=marker] if block ~ ~-1 ~ snow_block run summon falling_block ~ ~-1 ~ {BlockState:{Name:"minecraft:snow_block"},Time:1,Tags:["SpleefBlock"]}
    execute at @e[tag=Spleef,type=marker] if block ~ ~-1 ~ snow_block run setblock ~ ~-1 ~ air

# Loop
    execute store success score spleefdeathmatch bool in spleef2 run schedule function spleef:deathmatch 3s