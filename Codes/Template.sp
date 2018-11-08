* Digital Electronics, Template code********

.prot
.inc '32nm_bulk.pm'
.unprot

.param	Lmin=32n
+VDD=	1.1V
+cl =	20ff

.global	VDD
.temp	25

*********************Source Voltages**************
V	vdd	0	DC	VDD
VIN1	in1		0	pulse	0	1	0n	50n		50n		500n	1.1u

******************Transistor Level Implementation****************
M1 	n1 		in1 		0 	0 	nmos		w='8*Lmin'	L=Lmin 
***************Cap****************************************************
CL		out		0	cl     				  ** Capacitance of output node
*************Type of Analysis********
.tran	0.1ns	6u  

.DC	VIN1	0	1.1	0.01

*******************Measurements*************************************

.measure	tran	avg_current	avg	i(V)	from=0	to	6u

.meas		tran	AVGpower avg	Power	from=0		to=6u

.MEASURE TRAN tpHL
+ trig V(in1) val = 'VDD/2'  rise = 1
+ targ V(out) val = 'VDD/2'  fall = 1

.MEASURE TRAN tpLH
+ trig V(in1) val = 'VDD/2'  fall = 1
+ targ V(out) val = 'VDD/2'  rise = 1

.measure tran	tpd		PARAM = ('(tpLH+tpHL)/2')

.MEASURE TRAN t_rise
+ trig V(out) val = '0.1*VDD'  rise = 1
+ targ V(out) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = '0.9*VDD'  fall = 1
+ targ V(out) val = '0.1*VDD'  fall = 1

.end
