* Encoding: UTF-8.
GET FILE='\\Chgoldfs\pru\15-2005-2015 Poverty Report\Data\2015_BASE_IV_FINAL.SAV'. 
DATASET NAME DataSet1 WINDOW=FRONT. 
GET FILE='\\Chgoldfs\pru\16-2005-2016 Poverty Report\BaseFiles\2016_BASE.sav'. 
DATASET NAME DataSet2 WINDOW=FRONT. 
 
GET DATA  /TYPE=TXT 
  /FILE="\\Chgoldfs\pru\16-2005-2016 Poverty Report\Components\Housing\OUTPUT\2016\DonorCapEQ5_V6_HousingForMerge_2016.CSV" 
  /DELCASE=LINE 
  /DELIMITERS="," 
  /QUALIFIER='"' 
  /ARRANGEMENT=DELIMITED 
  /FIRSTCASE=2 
  /IMPORTCASE=ALL 
  /VARIABLES= 
  SERIALNO F4.0 
  SPORDER F2.0 
  getheap F1.0 
  heapamt F2.0 
  constat_hvs F2.0 
  ooprent_hvs F4.0 
  grent_hvs F4.0 
  conrent_hvs F4.0 
  mktrate F16.12 
  RentOrOwn F1.0 
  ReceiveRentSub F1.0 
  HsgStatus F1.0 
  Donatedval F6.0 
  Matchtype F2.0 
  elep_No_cash_rent F3.0 
  gasp_No_cash_rent F3.0 
  fulp_No_cash_rent F1.0 
  watp_No_cash_rent F4.0 
  HOOP_CEO F16.11 
  PUshareofHH F4.2 
  mktrate_annual F16.11 
  CEO_Housing_Adjustment_HH F16.11 
  CEO_Housing_Adjustment_Hsg_Thrs F17.11 
  CEO_Housing_Adjustment_Market_calc F17.12 
  CEO_Housing_Adjustment F16.11. 
CACHE. 
EXECUTE. 
DATASET NAME DataSet3 WINDOW=FRONT. 
DATASET ACTIVATE DataSet2. 
SORT CASES BY SERIALNO(A) SPORDER(A). 
DATASET ACTIVATE DataSet3. 
SORT CASES BY SERIALNO(A) SPORDER(A). 
DATASET ACTIVATE DataSet2. 
MATCH FILES /FILE=* 
  /FILE='DataSet3' 
  /RENAME (RentOrOwn = d0) 
  /BY SERIALNO SPORDER 
  /DROP= d0. 
EXECUTE. 
DATASET CLOSE DataSet3. 
DATASET ACTIVATE DataSet1. 
USE ALL.

VALUE LABELS HsgStatus 
1 "Renter - Public Housing" 
2 "Renter - Mitchell Lama Rental" 
3 "Renter - Tenant-Based Subsidy" 
4 "Renter - Rent Regulated" 
5 "Renter - Other Regulated" 
6 "Renter - Market Rate" 
7 "Renter - No Cash Rent" 
8 "Owner - Owned Free & Clear" 
9 "Owner - Paying Mortgage" 
10 "Non-building Housing (Boat, RV, etc.)". 

DATASET ACTIVATE DataSet2. 
USE ALL.

VALUE LABELS HsgStatus 
1 "Renter - Public Housing" 
2 "Renter - Mitchell Lama Rental" 
3 "Renter - Tenant-Based Subsidy" 
4 "Renter - Rent Regulated" 
5 "Renter - Other Regulated" 
6 "Renter - Market Rate" 
7 "Renter - No Cash Rent" 
8 "Owner - Owned Free & Clear" 
9 "Owner - Paying Mortgage" 
10 "Non-building Housing (Boat, RV, etc.)". 

GET FILE='\\Chgoldfs\pru\0-Source Data\HVS\2014\HVS 2014 HH.sav'. 
DATASET NAME DataSet4 WINDOW=FRONT. 
WEIGHT BY fhhwgt. 
CROSSTABS 
  /TABLES=CEO_HsgStatus BY boro 
  /FORMAT=AVALUE TABLES 
  /CELLS=COUNT 
  /COUNT ROUND CELL.


DATASET ACTIVATE DataSet1. 
USE ALL. 
COMPUTE filter_$=(REL = 0). 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
weight by wgtp. 
CROSSTABS 
  /TABLES=HsgStatus BY Boro 
  /FORMAT=AVALUE TABLES 
  /CELLS=Count 
  /COUNT ROUND CELL.

DATASET ACTIVATE DataSet2. 
USE ALL. 
COMPUTE filter_$=(REL = 0). 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
weight by wgtp. 
CROSSTABS 
  /TABLES=HsgStatus BY Boro 
  /FORMAT=AVALUE TABLES 
  /CELLS=Count 
  /COUNT ROUND CELL.

DATASET ACTIVATE DataSet2. 
USE ALL. 
COMPUTE filter_$=(REL = 0). 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
weight by wgtp. 
MEANS TABLES=NP BY HsgStatus 
  /CELLS=MEAN MEDIAN.
FILTER OFF.
WEIGHT BY PWGTP.
MEANS TABLES=AGEP BY HsgStatus 
  /CELLS=MEAN MEDIAN.


