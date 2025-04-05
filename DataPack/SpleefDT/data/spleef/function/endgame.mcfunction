# Fichier s'executant en FIN DE JEU


# TP joueur lobby
    execute in overworld run tp @a[tag=Joueur] 64.0 -31 154.5 -180 0
    gamemode adventure @a[gamemode=spectator,tag=Joueur]
    tellraw @a ["",{"text":"Spleef","color":"gold"},{"text":" >","color":"black"},{"text":" Téléportation au lobby...","color":"aqua"}]
    tag @a[tag=Joueur] remove Joueur