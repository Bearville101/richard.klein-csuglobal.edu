* Converting ASCII Data File to a permanent SAS Data set;
LIBNAME HHSFSREV '/folders/myfolders/sasuser.v94';                                                              
     FILENAME INFS '/folders/myfolders/HHS/h198.dat';                                                
 *INPUT Statement - giving names and column beginning and endings;
     DATA HHSFSREV.H198;                                                                        
     INFILE INFS LRECL=51;                                                                     
    INPUT @1      HOMEIDX  $7.0
      @8      DUID     $5.0
      @13     PANEL    $2.0
      @15     FSOUT42   2.0
      @17     FSLAST42  2.0
      @19     FSAFRD42  2.0
      @21     FSSKIP42  2.0
      @23     FSSKDY42  2.0
      @25     FSLESS42  2.0
      @27     FSHGRY42  2.0
      @29     FSWTLS42  2.0
      @31     FSNEAT42  2.0
      @33     FSNEDY42  2.0
      @35     FSWT42    12.6
      @47     VARSTR    4.0
      @51     VARPSU    1.0
; 
*LABEL Statement - giving descriptive names to SAS variables;                                                                             
    LABEL HOMEIDX ='HOME ID NUMBER (DUID + RU + ROUND)'
      DUID    ='DWELLING UNIT ID'
      PANEL   ='PANEL'
      FSOUT42 ='HOW OFTEN HAVE YOU RUN OUT OF FOOD'
      FSLAST42='HOW OFTEN DID FOOD NOT LAST'
      FSAFRD42='HOW OFTEN NOT AFFORD BALANCED MEALS'
      FSSKIP42='DID YOU EVER SKIP MEALS'
      FSSKDY42='HOW MANY DAYS WERE MEALS SKIPPED'
      FSLESS42='DID YOU EVER EAT LESS'
      FSHGRY42='DID YOU EVER GO HUNGRY'
      FSWTLS42='LOW FOOD MONEY CAUSE WEIGHT LOSS'
      FSNEAT42='DID YOU EVER NOT EAT'
      FSNEDY42='HOW MANY DAYS DID YOU NOT EAT'
      FSWT42  ='FOOD SECURITY WEIGHT'
      VARSTR  ='VARIANCE ESTIMATION STRATUM - 2017'
      VARPSU  ='VARIANCE ESTIMATION PSU - 2017';  
run;
 
 * ttest statement comparing FSAFRD42 - How often not afford balanced meals v. FSNEAT42 - 
 Did you even not eat;
   ods graphics on;
 proc ttest;
 paired FSAFRD42*FSLAST42;
 run;
 ods graphics off;
                                                                                         
 RUN;
 