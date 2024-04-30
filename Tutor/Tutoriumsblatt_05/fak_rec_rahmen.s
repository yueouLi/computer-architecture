############################################################
# Fakultaetsfunktion rekursiv (Eingabe fuer n<17)
#  
# int fak(int n) {
#     if(n < 0)
#         return -1;
#     if(n == 0)
#         return 1;
#     else
#         return n * fak(n-1);
# }
###########################################################

.data
eingabe:	.asciiz	"Geben Sie eine Zahl ein: "
.text
main:   li      $v0, 4
        la      $a0, eingabe    # Ausgabe String
        syscall
        li      $v0, 5          # Zahl einlesen
        syscall
        move    $t0, $v0        # Eingabe in $t0 laden

###########################################################
# Begin der Funktion
###########################################################

        				# Eingabe > 0?
        				
        				# Parameter setzen

	# Alle verwendeten a-, v- und t- Register sichern
	# hier: a0, t0; v0 hier nicht, da steht das Ergebnis
	# des Aufrufs drin
        sub 	$sp, $sp, 8	# Caller-Prolog
	sw	$t0, 8($sp)	
	sw	$a0, 4($sp)	
	jal	fak   		# Prozeduraufruf

	# gesicherte Register wiederherstellen
	lw	$t0, 8($sp)
	lw	$a0, 4($sp)
	addi	$sp, $sp, 8	# Stackpointer 2 x mal pop
	move	$t1, $v0	

output:	li	$v0, 1	
	move 	$a0, $t1
	syscall
	
end:	li 	$v0, 10
	syscall

negarg: li 	$t1, -1
	j 	output

fak:	sub 	$sp,  $sp, 8	# Prolog Callee: Stackframe erstellen
	sw  	$fp,  8($sp)	
	sw  	$ra,  4($sp)
	addi 	$fp, $sp, 8	# Framepointer setzen
				
				# if (n == 0) then return 1
				
	li 	$v0, 1
	j 	epilog 		# Fertig. Epilog ausfuehren und nach Hause

next:				# n merken
				
				# Parameter fuer Aufruf setzen (n-1)
				
				
	# Aufruf fak 
	# Sichern der verwendeten Caller-Saved-Register: $t, $a, $v
	# hier: $t2, $a0
	
	sub 	$sp, $sp, 8	# Caller-Prolog (rek. Aufruf)
	sw	$a0, 8($sp)
	sw  	$t2, 4($sp)
	jal 	fak
	lw 	$t2, 4($sp)	# Caller-Epilog: Register
        lw	$a0, 8($sp)	# wiederherstellen
	addi 	$sp, $sp, 8	
	
				# n * fak(n-1) und zurueck
				
	mflo 	$v0		# Ergebnis der Mult aus $lo holen 
				# und in $v0 ablegen
epilog:	lw 	$fp, 8($sp)   	# wiederherstellen und zurueck
	lw 	$ra, 4($sp)	
	addi 	$sp, $sp, 8
	jr 	$ra
