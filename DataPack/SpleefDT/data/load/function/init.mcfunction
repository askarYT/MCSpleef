# Fonction LOAD du jeu


# Message si DataPack chargé avec succès !
    tellraw @a [{"text": "Datapack \"Mini-Games 708CN\" rechargé !","color": "green"}]

# Vérification des Markers

# Initialisation des scoreboards
    scoreboard objectives add Time dummy
    scoreboard objectives add Value dummy
    scoreboard objectives add bool dummy
    scoreboard objectives add Roll dummy
    scoreboard objectives add Disconnection minecraft.custom:minecraft.leave_game

    # Initialisation des valeurs sb
        scoreboard players set tntrunprestart Time 5

    # Reset scoreboards

# Reset functions
    function tntrun:restart