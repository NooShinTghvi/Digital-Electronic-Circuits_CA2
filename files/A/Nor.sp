* OR
***** Library ***** .inc '32nm_bulk.pm'
.prot
.inc '45nm.pm'
.unprot

***** Params *****
.param  Lmin=45n
+VDD = 1V
+GND = 0V

*.global	VDD
.temp	25

***** Sources *****
*V      N+  N-  Pulse   V1  V2  TD  TR  TF  PW  PER
Vsply	1	0	DC	VDD
VinA    A	0	DC  VDD
*Pulse	0    VDD  5n  1ps  1ps 50ps    100ps
VinB    B	0	DC  VDD
*Pulse	0    VDD  5n  1ps  1ps 50ps    100ps
VinC	C	0	DC  VDD
*Pulse	0    Vdd  5n  1ps  1ps 50ps    100ps

***** NOR GATE *****
*M   	ND		NG 		NS		NB		Model name		W
Mp1		2	  	C   	1	    1		pmos	l='Lmin'	w='12*Lmin'
Mp2     3  		B   	2     	2   	pmos	l='Lmin'    w='12*Lmin'
Mp3     out  	A   	3     	3   	pmos	l='Lmin'    w='12*Lmin'

Mn1	    out	   	A   	0  		0     	nmos	l='Lmin'	w='2*Lmin'
Mn2     out    	B       0    	0     	nmos    l='Lmin'    w='2*Lmin'
Mn3     out    	C       0    	0     	nmos    l='Lmin'    w='2*Lmin'

***** Capacitance *****
C1		out		0	0ff
***** Type of Analysis *****
.tran	0.1ns     200ns   1ns

* Calculation of average power over a given time period :
*.meas		tran	AVGpower avg	Power	from=0		to=6u

.MEASURE TRAN tpHL
+ trig V(1) val = 'VDD/2'  rise = 1
+ targ V(out) val = 'VDD/2'  fall = 1

.MEASURE TRAN tpLH
+ trig V(1) val = 'VDD/2'  fall = 1
+ targ V(out) val = 'VDD/2'  rise = 1

*.measure tran	tpd		PARAM = ('(tpLH+tpHL)/2')

.MEASURE TRAN t_rise
+ trig V(out) val = '0.1*VDD'  rise = 1
+ targ V(out) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = '0.9*VDD'  fall = 1
+ targ V(out) val = '0.1*VDD'  fall = 1

.op
.end
