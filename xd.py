
valor_numero = int(input("Asere, ¿cuánto le metiste a cada número?: "))  
cantidad_jugadas = int(input("¿Cuántas jugaditas te tiraste hoy, socio?: ")) 
total_numeros = int(input("¿Cuántos números salieron en la bolita hoy?: "))  

paga_fijo = input("¿Pagan a 85 por cada peso, o no? (si/no): ")
if paga_fijo.lower() == "si":
    premio_acierto = 85 * valor_numero
else:
    pago_por_peso = int(input("¿A cómo está el pago por peso hoy, asere?: "))
    premio_acierto = pago_por_peso * valor_numero

veces_ganadas = int(input("¿Y cuántas veces te coronaste hoy, campeón?: "))

gasto_por_jugada = total_numeros * valor_numero
gasto_total = gasto_por_jugada * cantidad_jugadas
ganancia_total = veces_ganadas * premio_acierto
ganancia_neta = ganancia_total - gasto_total

print("Se te fue este billete en el juego: ", gasto_total, "💸")
print("Pero mira lo que entró por los aciertos: ", ganancia_total, "🤑")

if ganancia_neta >= 0:
    print("¡Epa! ¡Tremenda ganancia neta hoy!: ", ganancia_neta, "🎉 ¡Te coronaste, socio!")
else:
    print("¡Ay, mi madre! Perdiste: ", abs(ganancia_neta), "😭 ¡Pa' la próxima será!")
    