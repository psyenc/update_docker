
precio_juego = 10 💰
juegos_diarios = 6 🎲
numeros_loteria = 31 🔢
premio_por_acierto = 850 🏆

ganados = int(input("¿Cuántas veces ganaste hoy, mi socio?: "))

gasto_por_juego = numeros_loteria * precio_juego
gasto_total = gasto_por_juego * juegos_diarios
ganancia_total = ganados * premio_por_acierto
ganancia_neta = ganancia_total - gasto_total

print("El billete que se fue en el juego: ", gasto_total, "💸")
print("Lo que entró por los aciertos: ", ganancia_total, "🤑")

if ganancia_neta >= 0:
    print("¡Tremenda ganancia neta del día!: ", ganancia_neta, "🎉")
else:
    print("¡Mala suerte! Pérdida: ", abs(ganancia_neta), "😭")
    