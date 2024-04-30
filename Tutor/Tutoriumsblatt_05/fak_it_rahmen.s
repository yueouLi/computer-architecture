###########################################################
# Fakultaetsfunktion iterativ (Eingabe fuer n<17)
#
# int fak(int n) {
#     if(n < 0)
#         return -1;
#     int result = 1;
#     while(result > 0) {
#         result = result * n;
#         n = n - 1;
#     }
#     return result;
# }
###########################################################

.data
eingabe:	.asciiz 	"Geben Sie eine Zahl ein: "
.text
main:	li	$v0, 4
	la	$a0, eingabe 	# Ausgabe String
	syscall
	li 	$v0, 5		# Zahl einlesen
	syscall
	move 	$t0, $v0		# Eingabe in $t0 laden

###########################################################
# Begin der Funktion
###########################################################
	
	
	

while:	
	
		
	
	
###########################################################
output:	li	$v0, 1		# Zahl ausgeben
	move 	$a0, $t1
	syscall
	
exit:	li $v0, 10		# Beenden
	syscall

negarg:	li $t1, -1		# Ergebnis fuer negative Eingabe
	j output

###########################################################
# Ende der Funktion
###########################################################
	
