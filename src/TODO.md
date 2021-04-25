# TODO
* Sette opp måling med overhead. Dette er for mye jobb?
* Sette opp måling med latency. FOKUSER PÅ DENNE
* Skrive om de over i implementation


* Legge inn ny parameter slik at vi kan kontrollere hvor ofte vi henter hos local!
  * Test med x/1, x/10, x/100, x/1000, x/10000
    * plot på graf
  * Bestemme individuelt for hver node?
* Du må også finne nye limitations for fps, for nå er det kun latency som er limit.
* i tabellene som ikke har latency, legg til
* BRUK planet-ubc SOM FAR NODE!!



Far node skal aldri ha noen begrensning, for den har "unlimited resources"
Near node må ha begrensning. Ca 3 ganger så rask som Local node.








<PARTIAL>

<Tables>
30
100
300
850
2700
6450
Node 0 used time: 28:080959
Node 1 used time: 85:965113
Node 2 used time: 1131:236624

30
100
300
500
400
100
Node 0 used time: 16:103004
Node 1 used time: 12:681106
Node 2 used time: 16:993748


30
100
300
5000
4000
1000
Node 0 used time: 166:281206
Node 1 used time: 128:856170
Node 2 used time: 175:632728


30
100
300
4550
4525
925
Node 0 used time: 151:278174
Node 1 used time: 149:830576
Node 2 used time: 162:984251
</Tables>


<Graph>
</Graph>

</PARTIAL>


<FULL>
30
100
300
1
2800
7200
Node 0 used time: 0:005073
Node 1 used time: 92:868255
Node 2 used time: 1304:794047


30
100
300
1
7200
2800
Node 0 used time: 0:006099
Node 1 used time: 318:797756
Node 2 used time: 523:593764


30
100
300
1
8500
1500
Node 0 used time: 0:005088
Node 1 used time: 279:252045
Node 2 used time: 267:905037


<GRAPH>
ta litt mindre skala på hvor ofte den må hente?
f.eks hver 1, 5, 10, 20, 40, 80, 160


Vi har skalert ned til 1000 iterations, for det er ca her det har noe å si uansett
KUN for graph


</GRAPH>




</FULL>

30
100
99999
1000
1000
1000
Node 0 used time: 33:099611
Node 1 used time: 9:220540
Node 2 used time: 1:989418
howOften=160



Node 0 used time: 33:114364
Node 1 used time: 9:221349
Node 2 used time: 3:125086
Howoften=80


Node 0 used time: 33:107885
Node 1 used time: 9:310457
Node 2 used time: 5:391211
Howoften=40


Node 0 used time: 33:122778
Node 1 used time: 9:314111
Node 2 used time: 9:562315
Howoften=20



Node 0 used time: 33:096598
Node 1 used time: 9:482919
Node 2 used time: 18:405816
howoften=10


Node 0 used time: 33:113485
Node 1 used time: 9:796369
Node 2 used time: 36:792202
howoften=5



Node 0 used time: 33:096121
Node 1 used time: 32:157960
Node 2 used time: 185:126334
howoften=1















50
100
300
1
3600
1400
Node 0 used time: 0:004832
Node 1 used time: 115:613208
Node 2 used time: 114:700564




50
100
300
1
7200
2800
Node 0 used time: 0:004865
Node 1 used time: 239:505060
Node 2 used time: 237:952149


15
50
100
1000
1000
1000
Node 0 used time: 66:141298
Node 1 used time: 32:918010
Node 2 used time: 8:925375


Samme som over, men med latency henting hver 10ende istedet
Node 0 used time: 66:144879
Node 1 used time: 19:261727
Node 2 used time: 11:989737



