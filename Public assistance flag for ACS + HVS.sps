* Encoding: UTF-8.
*  ACS PUBLIC ASSIST FLAG.
weight off.
compute pubassist = 0.
if hins4 = 1 or pap > 0 or fs=1 pubassist = 1.
sort cases by serialno.
AGGREGATE
    /OUTFILE=*
    MODE=ADDVARIABLES
    OVERWRITE=YES
    /PRESORTED
    /BREAK=Serialno
    /pubassist_hh  = max(pubassist).
execute.
compute hhfilter = (rel=0).
filter by hhfilter.
weight by wgtp.
frequencies /variables=pubassist_hh /order=analysis.

*  HVS PUBLIC ASSIST FLAG.
compute pubassist_hh = 0.
if tanfyn = 1 or safetynetyn =1 or ssiyn=1 or otherwelfareyn=1 pubassist_hh = 1.
weight by fhhwgt.
frequencies /variables=pubassist_hh /order=analysis.

