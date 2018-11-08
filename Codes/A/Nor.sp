* NOR


***** Library *****
.prot
.inc '45nm.pm'
.unprot

***** Params *****
.param  +VDD = 1V
+GND = 0V
+Lmin=45n
+B = 2
+Wp = 6
+Wn = 1

***** Temperature *****
.temp	25

***** Sources *****
*V      N+  N-  Pulse   V1  V2  TD  TR  TF  PW  PER
Vsply	1	0	DC	VDD
VinA    A	0	DC  GND
VinB    B	0	DC  GND
VinC	C	0	Pulse  0   VDD 5n  1ps 1ps 50ps    100ps

***** NOR GATE *****
*M   	ND		NG 		NS		NB		Model name		W
Mp1		2	  	C   	1	    1		pmos	l='Lmin'	w='Lmin*B*Wp'
Mp2     3  		B   	2     	2   	pmos	l='Lmin'    w='Lmin*B*Wp'
Mp3     out  	A   	3     	3   	pmos	l='Lmin'    w='Lmin*B*Wp'

Mn1	    out	   	A   	0  		0     	nmos	l='Lmin'	w='Lmin*B*Wn'
Mn2     out    	B       0    	0     	nmos    l='Lmin'    w='Lmin*B*Wn'
Mn3     out    	C       0    	0     	nmos    l='Lmin'    w='Lmin*B*Wn'

***** Capacitance *****
*C1		out		0	0ff

***** Type of Analysis *****

***** Transient analysis:
.tran	0.1ns     200ns   1ns

***** Power :
*.meas		tran	AVGpower avg	Power	from=0		to=6u
.meas tran AVGpower avg  Power

***** Maximum operating frequency :
.MEASURE maxF param = '1 /(t_rise + t_fall)'

***** Propagation Delay :
.MEASURE TRAN tpHL
+ trig V(C) val = 'VDD/2'  rise = 1
+ targ V(out) val = 'VDD/2'  fall = 1

.MEASURE TRAN tpLH
+ trig V(C) val = 'VDD/2'  fall = 1
+ targ V(out) val = 'VDD/2'  rise = 1

.measure tran   tpd   PARAM = ('(tpLH+tpHL)/2')

***** Transition Time :
.MEASURE TRAN t_rise
+ trig V(out) val = '0.1*VDD'  rise = 1
+ targ V(out) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(out) val = '0.9*VDD'  fall = 1
+ targ V(out) val = '0.1*VDD'  fall = 1

.op
.end
