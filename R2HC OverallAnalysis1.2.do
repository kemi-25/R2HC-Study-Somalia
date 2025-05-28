*******************************************************************************
*             Project: BHA Endline Data Analysis
*             Objectives:
*                        - Conduct cleaning on the dataset
*                        - Inspect data and label vaiables 
*                        - Generate compsoite variables
*                        - Explore data- distribution
*                        - Explore outliers and take decisisons
*                        - EDA
*                        - Exploring relationships and modelling 
*             Date file created: January 2024
*             By: Kemish Kenneth
*******************************************************************************
*---------------
*   HOUSEKEEPING
*---------------
clear all
capture log close
macro drop _all
version 18
*----------------------------------------
*   Directory and Log file
*----------------------------------------
**  Kemish's work on data cleaning and Exploration: Main folder for Baseline data on JHU R2HC Dropbox folder
cd  "/Users/kemish/Library/CloudStorage/Dropbox-InstituteofInternationalPrograms/Kemish Kenneth/R2HC/Data Management and Analysis Plan/Data/Overall Analysis"

 /*change directory*/

log using "BHA_EndlineAnalysis.d.log", replace /*change name to your preference*/

*----------------------------------------
*   Opening dataset
*----------------------------------------
import excel "SC_SOM_R2HC_Endline_Reshaped_.xlsx",firstrow case(upper)

*-----------------------------------------
*  General inspection of dataset
*-----------------------------------------
codebook
describe, short
summ
duplicates list

/* No duplicates in the dataset on all variables.
*/
*----------------------------------------------------------------------
*   Encode variables-converting categorical string variables to numeric 
*----------------------------------------------------------------------
multencode ENUMERATORTEAM C_REGION C_DIST C_VILLAGE C_CLUSTER_NUMBER C_ARMS MOTHER_NAME CHILD_NAME1 CHILD_SEX1 CHILD_NAME2 CHILD_ID2 CHILD_SEX2 CHILD_NAME3 CHILD_ID3 CHILD_SEX3  CHILD_NAME4 CHILD_ID4 CHILD_SEX4 WEREYOUTHEONEWHORESPONDEDD WHATISYOURRELATIONSHIPTOTHE, gen(enum_team region district village cluster arm mother_name namechld1 sexchld1 namechld2 idchld2 sexchld2 namechld3 idchld3 sexchld3 namechld4 idchld4 sexchld4 same_respondentasbasline rship_respondent_child)

drop ENUMERATORTEAM C_REGION C_DIST C_VILLAGE C_CLUSTER_NUMBER C_ARMS MOTHER_NAME CHILD_NAME1 CHILD_SEX1 CHILD_NAME2 CHILD_ID2 CHILD_SEX2 CHILD_NAME3 CHILD_ID3 CHILD_SEX3  CHILD_NAME4 CHILD_ID4 CHILD_SEX4 WEREYOUTHEONEWHORESPONDEDD WHATISYOURRELATIONSHIPTOTHE

multencode NAMEOFYOUNGESTCHILDRECORDED IFOTHERSPECIFYRELATIONSHIPT WHATISYOURNAME WHATISYOURAGE AREYOUCURRENTLYPREGNANT SINCEBASELINE7MONTHSAGOD NAMEOFNEWBABY WHOASSISTEDWITHTHEDELIVERYO WHEREDIDYOUGIVEBIRTHTONE WASNEWBORN_NAMEDELIVEREDBY WHENNEWBORN_NAMEWASBORNW WHOUSUALLYDECIDESHOWTHEHOUS WHOUSUALLYMAKESDECISIONSABOU CI INTHELAST3MONTHSHASANYME, gen (name_child rship_if_other rship_other_name rship_other_age preg newborn newborn_name newborn_birth_assist newborn_deliv_place newborn_cs  newborn_size decision_income decision_healthcare decision_purchases received_assitance_last3months)

drop NAMEOFYOUNGESTCHILDRECORDED IFOTHERSPECIFYRELATIONSHIPT WHATISYOURNAME WHATISYOURAGE AREYOUCURRENTLYPREGNANT SINCEBASELINE7MONTHSAGOD NAMEOFNEWBABY WHOASSISTEDWITHTHEDELIVERYO WHEREDIDYOUGIVEBIRTHTONE WASNEWBORN_NAMEDELIVEREDBY WHENNEWBORN_NAMEWASBORNW WHOUSUALLYDECIDESHOWTHEHOUS WHOUSUALLYMAKESDECISIONSABOU CI INTHELAST3MONTHSHASANYME

multencode DOESYOURHOUSEHOLDOWNANYOFT DOESYOURHOUSEHOLDHAVEANYOF EC EN WHATISTHEMAINMATERIALOFTHE FL GM WHEREDOYOUGOTOWHENYOUHAVE WHEREDOYOUDISPOSEYOUNGEST_ IFYOUWERETOGIVEBIRTHTOANO HV ISCHILD_NAME1AVAILABLENOW ANTH_CHILD_1 ANTH_CHILD_SEX1 WHATISTHERELATIONSHIPOFTHIS ISOEDEMAPRESENTINANTH_CHIL ISANTH_CHILD_1CURRENTLYREG ANTH_CHILD_2 ANTH_CHILD_SEX2 IZ ANTH_LT5AGEMTHS2 JD ISANTH_CHILD_2CURRENTLYREG ANTH_CHILD_3 ANTH_CHILD_SEX3 JK ANTH_LT5AGEMTHS3 JO ISANTH_CHILD_3CURRENTLYREG ANTH_CHILD_4 ANTH_CHILD_SEX4 JV ANTH_LT5AGEMTHS4 JZ ISANTH_CHILD_4CURRENTLYREG ENUMERATORONLYRECORDTHEMEMB, gen(own_livestock own_hhassets own_personalassets own_bankaccount floor_material roof_material wall_material defecate_mother dispose_feaces_child init_bfeeding_pract excl_bfeeding_pract child1_available child1_name_rep child1_sex_rep rshi_to_child1 oedemachld1 child1_current_inwasting_prog child2_name_rep child2_sex_rep rshi_to_child2 child2_age_rep oedemachld2 child2_current_inwasting_prog child3_name_rep child3_sex_rep rshi_to_child3 child3_age_rep oedemachld3 child3_current_inwasting_prog child4_name_rep child4_sex_rep rshi_to_child4 child4_age_rep oedemachld4 child4_current_inwasting_prog hh_members)

drop DOESYOURHOUSEHOLDOWNANYOFT DOESYOURHOUSEHOLDHAVEANYOF EC EN WHATISTHEMAINMATERIALOFTHE FL GM WHEREDOYOUGOTOWHENYOUHAVE WHEREDOYOUDISPOSEYOUNGEST_ IFYOUWERETOGIVEBIRTHTOANO HV ISCHILD_NAME1AVAILABLENOW ANTH_CHILD_1 ANTH_CHILD_SEX1 WHATISTHERELATIONSHIPOFTHIS ISOEDEMAPRESENTINANTH_CHIL ISANTH_CHILD_1CURRENTLYREG ANTH_CHILD_2 ANTH_CHILD_SEX2 IZ ANTH_LT5AGEMTHS2 JD ISANTH_CHILD_2CURRENTLYREG ANTH_CHILD_3 ANTH_CHILD_SEX3 JK ANTH_LT5AGEMTHS3 JO ISANTH_CHILD_3CURRENTLYREG ANTH_CHILD_4 ANTH_CHILD_SEX4 JV ANTH_LT5AGEMTHS4 JZ ISANTH_CHILD_4CURRENTLYREG ENUMERATORONLYRECORDTHEMEMB

multencode HOWOFTENDIDTHISHAPPENINTHE NE NH WHATTYPEOFHANDWASHINGSTATION ISCLEANSINGAGENTAVAILABLEFOR, gen(freq_no_foodto_eat freq_sleep_hungry freq_whole_nightday_hungry handwash_station_type detergen_present)
drop HOWOFTENDIDTHISHAPPENINTHE NE NH WHATTYPEOFHANDWASHINGSTATION ISCLEANSINGAGENTAVAILABLEFOR

multencode HASYOUNGEST_CHILDEVERRECEI HASYOUNGEST_CHILDHADDIARRH INTHELAST3MONTHSDIDYOUOR INTHELAST3MONTHSWEREYOUA IFYESWHATDIDTHEYRECEIVEDU IFYESWHATISYOURENTITLEMENT WHATISTHEMAINSOURCEOFDRINK IFOTHERSPECIFY WHATDOYOUDOTOTHEWATERBEFO WHATKINDOFTOILETFACILITYDO WHENDOWASHYOURHANDSAFTERW WHENDOYOUTHINKARETHETHREE WHATSHOULDYOUDOTOYOURWATER HOWSOONAFTERBIRTHSHOULDYOU FORTHEFIRST6MONTHSOFLIFE IFYESTOWHATEXTENTWASTHIS IFNOTELLMEWHY HOWLONGAFTERBIRTHDIDYOUPUT DOYOUREMEMBERHOWOLDYOUNGE TC, gen(list_vaccines_received illnesschild_last2wks malnut_screening_last3mths malnu_trt_last3mths list_assist_received list_bha_kitreceived water_mainsource water_mainsource_other water_trt_pract toilet_type  list_moments_handwash_pract list_moments_handwash_know  water_trt_know  init_bfeeding_know excl_bfeeding_know m2m_changed_bfeeding m2m_notchanged_bfeeding_reasons init_bfeeding_child remem_init_liquid remem_init_solids)

drop HASYOUNGEST_CHILDEVERRECEI HASYOUNGEST_CHILDHADDIARRH INTHELAST3MONTHSDIDYOUOR INTHELAST3MONTHSWEREYOUA IFYESWHATDIDTHEYRECEIVEDU IFYESWHATISYOURENTITLEMENT WHATISTHEMAINSOURCEOFDRINK IFOTHERSPECIFY WHATDOYOUDOTOTHEWATERBEFO WHATKINDOFTOILETFACILITYDO WHENDOWASHYOURHANDSAFTERW WHENDOYOUTHINKARETHETHREE WHATSHOULDYOUDOTOYOURWATER HOWSOONAFTERBIRTHSHOULDYOU FORTHEFIRST6MONTHSOFLIFE IFYESTOWHATEXTENTWASTHIS IFNOTELLMEWHY HOWLONGAFTERBIRTHDIDYOUPUT DOYOUREMEMBERHOWOLDYOUNGE TC

*------------------------------------------------------------------------------
*  Change numerical variables from string to numerical format and remove "days"
*-----------------------------------------------------------------------------
foreach x in INTHEPASTWEEKAPPROXIMATELY LG LJ LM LP LS LV LY MB ARELYONLESSPREFERREDANDLE BBORROWFOODORRELYONHELP CLIMITPORTIONSIZEATMEALTIM DRESTRICTCONSUMPTIONBYADULT EREDUCENUMBEROFMEALSEATEN {
	replace `x' = substr(`x', 1, strpos(`x', " ") - 1)
}
destring INTHEPASTWEEKAPPROXIMATELY LG LJ LM LP LS LV LY MB ARELYONLESSPREFERREDANDLE BBORROWFOODORRELYONHELP CLIMITPORTIONSIZEATMEALTIM DRESTRICTCONSUMPTIONBYADULT EREDUCENUMBEROFMEALSEATEN, replace

*------------------------------------------------------------------------------
*  Changed responses from string yesno to numerical "1" and "0"
*-----------------------------------------------------------------------------

foreach var of varlist YN_CEREALS_TUBERS YN_LEGUMES YN_VEGETABLES YN_FRUITS YN_MEAT_FISH YN_DAIRY YN_SUGAR YN_OIL YN_CONDIMENT YN_CHEAP_FOOD YN_BORROW YN_REDUCE_PORTION YN_PRIORITIZE_CHILD_MEALS YN_SKIP_MEALS {
    replace `var' = strtrim(strproper(`var'))
    replace `var' = "0" if `var' == "no"
    replace `var' = "1" if `var' == "yes"
}

foreach var of varlist YN_CEREALS_TUBERS YN_LEGUMES YN_VEGETABLES YN_FRUITS YN_MEAT_FISH YN_DAIRY YN_SUGAR YN_OIL YN_CONDIMENT YN_CHEAP_FOOD YN_BORROW YN_REDUCE_PORTION YN_PRIORITIZE_CHILD_MEALS YN_SKIP_MEALS {
    replace `var' = strtrim(strproper(`var'))
    replace `var' = "0" if `var' == "No"
    replace `var' = "1" if `var' == "Yes"
}
destring YN_CEREALS_TUBERS YN_LEGUMES YN_VEGETABLES YN_FRUITS YN_MEAT_FISH YN_DAIRY YN_SUGAR YN_OIL YN_CONDIMENT YN_CHEAP_FOOD YN_BORROW YN_REDUCE_PORTION YN_PRIORITIZE_CHILD_MEALS YN_SKIP_MEALS,replace

foreach var of varlist DOESANYMEMBEROFTHISHOUSEHOL INTHEPAST30DAYSWASTHEREE INTHEPAST30DAYSDIDYOUOR NG THINKINGABOUTYOURYOUNGESTCHI {
    replace `var' = strtrim(strproper(`var'))
    replace `var' = "0" if `var' == "No"
    replace `var' = "1" if `var' == "Yes"
}
destring DOESANYMEMBEROFTHISHOUSEHOL INTHEPAST30DAYSWASTHEREE INTHEPAST30DAYSDIDYOUOR NG THINKINGABOUTYOURYOUNGESTCHI,replace

foreach var of varlist DIDYOUSEEKTREATMENTFORTHEI IFYESDIDYOUORYOUNGEST_CH DOESTHEPLWINTHEHHWHOHAVE SINCETHESAVEPROGRAMMINGHASS DIDYOURHHRECEIVEDNFIKITSUN DIDYOURECEIVEDTHEFULLKITCO DOESTHEHOUSEHOLDHAVEACCESST ARETHEREMOTHERTOMOTHERSUPPO HAVEYOUATTENDEDANYOFTHEMOT WOULDYOUSHARETHISINFORMATION HASYOUNGEST_CHILDEVERBEEN WASYOUNGEST_CHILDBREASTFED NOWIWOULDLIKETOASKYOUABOU WASYOUNGEST_CHILDGIVENORAL PLAINWATER INFANTFORMULA ANYMILKSUCHASTINNEDPOWDERE ANYJUICEORJUICEDRINKS CLEARBROTH YOGURT ANYTHINPORRIDGE ANYOTHERLIQUIDS DIDYOUNGEST_CHILDDRINKANYT FOODMADEFROMGRAINSSUCHASB PUMPKINCARROTSSQUASHORSWE WHITEPOTATOESWHITEYAMSMANI ANYDARKGREENLEAFYVEGETABLES ANYOTHERVEGETABLES RIPEMANGOESRIPEPAPAYASORO ANYOTHERFRUITS LIVERKIDNEYHEARTOROTHERO ANYMEATFROMDOMESTICATEDANIMA SP ANYFLESHFROMWILDANIMALS EGGS FRESHORDRIEDFISHSHELLFISH ANYFOODSMADEFROMBEANSPEAS ANYFOODSMADEFROMNUTSANDSEE CHEESEYOGURTOROTHERMILKPR ANYOILFATSORBUTTERORFOO ANYSUGARYFOODSSUCHASCHOCOLA CONDIMENTSFORFLAVORSUCHASC FOODSMADEWITHREDPALMOILRE DIDYOUNGEST_CHILDEATANYSO EARLY_INITIATION ISWATERPRESENTFORHANDWASHING {
    replace `var' = strtrim(strproper(`var'))
    replace `var' = "0" if `var' == "No"
    replace `var' = "1" if `var' == "Yes"
}
destring DIDYOUSEEKTREATMENTFORTHEI IFYESDIDYOUORYOUNGEST_CH DOESTHEPLWINTHEHHWHOHAVE SINCETHESAVEPROGRAMMINGHASS DIDYOURHHRECEIVEDNFIKITSUN DIDYOURECEIVEDTHEFULLKITCO DOESTHEHOUSEHOLDHAVEACCESST ARETHEREMOTHERTOMOTHERSUPPO HAVEYOUATTENDEDANYOFTHEMOT WOULDYOUSHARETHISINFORMATION HASYOUNGEST_CHILDEVERBEEN WASYOUNGEST_CHILDBREASTFED NOWIWOULDLIKETOASKYOUABOU WASYOUNGEST_CHILDGIVENORAL PLAINWATER INFANTFORMULA ANYMILKSUCHASTINNEDPOWDERE ANYJUICEORJUICEDRINKS CLEARBROTH YOGURT ANYTHINPORRIDGE ANYOTHERLIQUIDS DIDYOUNGEST_CHILDDRINKANYT FOODMADEFROMGRAINSSUCHASB PUMPKINCARROTSSQUASHORSWE WHITEPOTATOESWHITEYAMSMANI ANYDARKGREENLEAFYVEGETABLES ANYOTHERVEGETABLES RIPEMANGOESRIPEPAPAYASORO ANYOTHERFRUITS LIVERKIDNEYHEARTOROTHERO ANYMEATFROMDOMESTICATEDANIMA SP ANYFLESHFROMWILDANIMALS EGGS FRESHORDRIEDFISHSHELLFISH ANYFOODSMADEFROMBEANSPEAS ANYFOODSMADEFROMNUTSANDSEE CHEESEYOGURTOROTHERMILKPR ANYOILFATSORBUTTERORFOO ANYSUGARYFOODSSUCHASCHOCOLA CONDIMENTSFORFLAVORSUCHASC FOODSMADEWITHREDPALMOILRE DIDYOUNGEST_CHILDEATANYSO EARLY_INITIATION ISWATERPRESENTFORHANDWASHING,replace

destring LIQUIDS_SCORE SOLIDS_SCORE TOTAL_SOLID_LIQUID EXCLUSIVE_BREASTFEEDING, replace 

foreach var of varlist IFYESDIDYOUATTENDANTENATAL IFYESDIDYOURECEIVEVITAS HASYOURHHBEENDISPLACEDINTH {
    replace `var' = strtrim(strproper(`var'))
    replace `var' = "0" if `var' == "No"
    replace `var' = "1" if `var' == "Yes"
}
destring IFYESDIDYOUATTENDANTENATAL IFYESDIDYOURECEIVEVITAS HASYOURHHBEENDISPLACEDINTH,replace


*--------------------------------------------------------------
* Drop the composite indicators that were automated in the tool  
*---------------------------------------------------------------
drop MDD_GROUP_1_BREASTMILK MDD_GROUP_2_GRAINS_TUBERS MDD_GROUP_3_LEGUMES_NUTS MDD_GROUP_4_DAIRY MDD_GROUP_5_MEAT MDD_GROUP_6_EGGS MDD_GROUP_7_VIT_A_FRUIT_VEG MDD_GROUP_8_OTHER_FRUIT_VEG MDD_TOTAL_GROUPS MDD_5_GROUPS
drop PTS_CEREALS_TUBERS PTS_LEGUMES PTS_VEGETABLES PTS_FRUITS PTS_MEAT_FISH PTS_DAIRY PTS_SUGAR PTS_OIL PTS_CONDIMENT PTS_TOTAL_FCS CATEGORY_FCS IPC_PHASE_FCS ALT_CATEGORY_FCS_HIGH_OIL ALT_IPC_PHASE_FCS_HIGH_OIL PTS_CHEAP_FOOD PTS_BORROW PTS_REDUCE_PORTION PTS_PRIORITIZE_CHILD_MEALS PTS_SKIP_MEALS PTS_TOTAL_RCSI IPC_PHASE_RCSI HHS_1_SCORE HHS_2_SCORE HHS_3_SCORE HHS_SCORE_TOTAL HHS_CATEGORY IPC_PHASE_HHS

drop HOUSEHOLDMEMBERUNIQUEIDCASH DISPLACEMENTSTATUS SELECTREGIONFROMLIST SELECTDISTRICTFROMLIST SELECTVILLAGEFROMLIST SELECTSTUDYARMFROMLIST IFNOTRESPONDENTATBASELINEA IFOTHERPLEASESPECIFY ISITACCURATETOSAYYOURHOUSE
 
*------------------------------------------
*   Defining yesno variables- 0=No; 1=Yes
*------------------------------------------

label define yesno 0 "No" 1 "Yes"

foreach x in BT BU BV BW IFYESCOMPAREDTOBASELINE7 CL CM CN CO CP CQ CR CS CT CY CZ DA DB DC DD DE DO DP DQ DR DS DT DU DV DW DX DY DZ EA EB ED EE EF EG EH EI EJ EK EL EM ER ES ET EU EV EW EX EY EZ FA FB FC FD FE FF FG FH FI FJ FM FN FO FP FQ FR FS FT FU FV FW FX FY FZ GA GB GC GD GE GF GG GH GI GJ GK GN GO GP GQ GR GS GT GU GV GW GX GY GZ HA HB HC HD HE HF HG HH HI HJ HK HL HM HN HO {
	label values `x' yesno
}

foreach x in YN_CEREALS_TUBERS YN_LEGUMES YN_VEGETABLES YN_FRUITS YN_MEAT_FISH YN_DAIRY YN_SUGAR YN_OIL YN_CONDIMENT YN_CHEAP_FOOD YN_BORROW YN_REDUCE_PORTION YN_PRIORITIZE_CHILD_MEALS YN_SKIP_MEALS INTHEPAST30DAYSWASTHEREE INTHEPAST30DAYSDIDYOUOR THINKINGABOUTYOURYOUNGESTCHI DIDYOUSEEKTREATMENTFORTHEI IFYESDIDYOUORYOUNGEST_CH DOESTHEPLWINTHEHHWHOHAVE SINCETHESAVEPROGRAMMINGHASS DIDYOURHHRECEIVEDNFIKITSUN DIDYOURECEIVEDTHEFULLKITCO NOWIMGOINGTOASKYOUABOUTY DOESTHEHOUSEHOLDHAVEACCESST ISWATERPRESENTFORHANDWASHING WHERESHOUDYOUGOTOWHENYOUH WHERESHOULDYOURCHILDGOTOWH ARETHEREMOTHERTOMOTHERSUPPO HAVEYOUATTENDEDANYOFTHEMOT WOULDYOUSHARETHISINFORMATION HASYOUNGEST_CHILDEVERBEEN WASYOUNGEST_CHILDBREASTFED NOWIWOULDLIKETOASKYOUABOU WASYOUNGEST_CHILDGIVENORAL NEXTIWOULDLIKETOASKYOUABO PLAINWATER INFANTFORMULA ANYMILKSUCHASTINNEDPOWDERE ANYJUICEORJUICEDRINKS CLEARBROTH YOGURT ANYTHINPORRIDGE ANYOTHERLIQUIDS DIDYOUNGEST_CHILDDRINKANYT FOODMADEFROMGRAINSSUCHASB PUMPKINCARROTSSQUASHORSWE WHITEPOTATOESWHITEYAMSMANI ANYDARKGREENLEAFYVEGETABLES ANYOTHERVEGETABLES RIPEMANGOESRIPEPAPAYASORO ANYOTHERFRUITS LIVERKIDNEYHEARTOROTHERO ANYMEATFROMDOMESTICATEDANIMA ANYFLESHFROMWILDANIMALS EGGS FRESHORDRIEDFISHSHELLFISH ANYFOODSMADEFROMBEANSPEAS ANYFOODSMADEFROMNUTSANDSEE CHEESEYOGURTOROTHERMILKPR ANYOILFATSORBUTTERORFOO ANYSUGARYFOODSSUCHASCHOCOLA CONDIMENTSFORFLAVORSUCHASC FOODSMADEWITHREDPALMOILRE DIDYOUNGEST_CHILDEATANYSO EARLY_INITIATION EXCLUSIVE_BREASTFEEDING DOESANYMEMBEROFTHISHOUSEHOL{
	label values `x' yesno
}

foreach x in HW HX HY HZ IA IB IC ID IE IF IG NG NP NQ NR NS NW NX NY NZ OF OG OH OO OP OQ OR OS OY OZ PA PB PC PD PJ PK PL PM PR PS PT PU PV PW PZ QA QB QC QD QE QH QI QJ QK QL QM QQ QR QS QT QU QV QW QX QY QZ RA {
	label values `x' yesno
}


***
* Dropping 
**

drop START END TODAY RECORDDATEINTERVIEWSTARTED RECORDTIMEINTERVIEWSTARTED COLLECTGPS RECORDDATEINTERVIEWENDED RECORDTIMEINTERVIEWENDED THANKYOUFORYOURTIMETODAYD THANKYOUFORYOURTIME _UUID AG

*--------------------------------
*  Rename Variables
*--------------------------------
rename (HOUSEHOLDIDNUMBER CL CM CN CO CP CQ CR CS CT HOWMUCHDIDYOURECEIVEEITHER HOWOFTERNDIDYOURECEIVEIT CY CZ DA DB DC DD DE HOWMANYCAMELSDOESYOURHOUSEH) (hhid assist_lt3m_none assist_lt3m_cash assist_lt3m_food assist_lt3m_anim assist_lt3m_viata assist_lt3m_snf assist_lt3m_hyg assist_lt3m_schol assist_lt3m_other val_assist_rec freq_assist_rec own_liv_cam own_liv_cat own_liv_goat own_liv_don own_liv_hor own_liv_pou own_liv_non no_liv_cam)

rename (HOWMANYCATTLEDOESYOURHOUSEH HOWMANYGOATSDOESYOURHOUSEHO HOWMANYDONKEYSDOESYOURHOUSE HOWMANYHORSESDOESYOURHOUSEH HOWMANYPOULTRYDOESYOURHOUSE HOWMANYHECTARESOFAGRICULTURA DO DP DQ DR DS DT DU DV DW DX DY DZ EA EB ED EE EF EG EH EI EJ EK EL EM) (no_liv_cat no_liv_goat no_liv_don no_liv_hor no_liv_pou hec_land hh_item_elect hh_item_rad hh_item_tv hh_item_tel hh_item_com hh_item_ref hh_item_radio hh_item_telv hh_item_telep hh_item_comp hh_item_int hh_item_refg hh_item_ac hh_item_non hh_asset_wat hh_asset_mphon hh_asset_bisc hh_asset_scot hh_asset_doncar hh_asset_tru hh_asset_canoe hh_asset_tract hh_asset_oxplou hh_asset_non)

rename (EO HOWMANYROOMSINTHISHOUSEHOLD ER ES ET EU EV EW EX EY EZ FA FM FN FO FP FQ FR FS FT FU FV FW FX FY FZ GN GO GP GQ) (hh_mobtrans no_room floor_earth floor_dung floor_wood floor_bamboo floor_polished floor_asphalt floor_tiles floor_cement floor_carpet floor_oth roof_none roof_leaf roof_grass roof_rustmat roof_bamboo roof_wodplank roof_cardb roof_metal roof_wood roof_clothtent roof_ceramic roof_cement roof_shing roof_oth wall_none wall_cane wall_dirt wall_bambmud)

rename (GR GS GT GU GV GW GX GY GZ HA HB HC HW HX HY HZ IA IB IC ID IE IF IG IH) (wall_stonmud wall_uncovadbobe wall_plywood wall_cardb wall_reusewood wall_cement wall_stone wall_brick wall_cemblock wall_covadobe shing wall_oth exc_bfd_pract_bm exc_bfd_pract_am exc_bfd_pract_form exc_bfd_pract_porr exc_bfd_pract_sou exc_bfd_pract_tea exc_bfd_pract_wat exc_bfd_pract_fru exc_bfd_pract_veg exc_bfd_pract_meat exc_bfd_pract_oth exc_bfd_prac_oth_sp)

rename (ANTH_CHILD_1WEIGHTKGTOT ANTH_CHILD_1HEIGHTCMTOT ANTH_CHILD_1MUACCMTOTH ANTH_CHILD_2WEIGHTKGTOT ANTH_CHILD_2HEIGHTCMTOT ANTH_CHILD_2MUACCMTOTHE ANTH_CHILD_3WEIGHTKGTOT ANTH_CHILD_3HEIGHTCMTOT ANTH_CHILD_3MUACCMTOTHE ANTH_CHILD_4WEIGHTKGTOT ANTH_CHILD_4HEIGHTCMTOT ANTH_CHILD_4MUACCMTOTHE INTHELASTMONTH30DAYSHOW KL KM KN KO KP KQ KR KS KT KU KV KW KX KY) (wtchld1 htchld1 muacchld1 wtchld2 htchld2 muacchld2 wtchld3 htchld3 muacchld3 wtchld4 htchld4 muacchld4 exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month)

rename (INTHEPASTWEEKAPPROXIMATELY YN_CEREALS_TUBERS LG YN_LEGUMES LJ YN_VEGETABLES LM YN_FRUITS LP YN_MEAT_FISH LS YN_DAIRY LV YN_SUGAR LY YN_OIL MB YN_CONDIMENT ARELYONLESSPREFERREDANDLE YN_CHEAP_FOOD BBORROWFOODORRELYONHELP YN_BORROW CLIMITPORTIONSIZEATMEALTIM YN_REDUCE_PORTION DRESTRICTCONSUMPTIONBYADULT YN_PRIORITIZE_CHILD_MEALS EREDUCENUMBEROFMEALSEATEN YN_SKIP_MEALS INTHEPAST30DAYSWASTHEREE INTHEPAST30DAYSDIDYOUOR) (d_cereals yn_cereals_tub d_legumes yn_legumes d_veg yn_veg d_fruits yn_fruits d_meat_fish yn_meat_fish d_dairy yn_dairy d_sugar yn_sugar d_oil yn_oil d_condiment yn_condiment d_cheap_food yn_cheap_food d_borrow yn_borrow d_reduce_portion yn_reduce_portion d_prior_child_meal yn_prior_child_meal d_skip_meals yn_skip_meals nofood_hh sleephug)

rename (NG THINKINGABOUTYOURYOUNGESTCHI NP NQ NR NS HOWMANYTIMESDIDYOUNGEST_CH NU NW NX NY NZ DIDYOUSEEKTREATMENTFORTHEI IFYESDIDYOUORYOUNGEST_CH OF OG OH DOESTHEPLWINTHEHHWHOHAVE SINCETHESAVEPROGRAMMINGHASS DIDYOURHHRECEIVEDNFIKITSUN DIDYOURECEIVEDTHEFULLKITCO OO OP OQ OR OS OY OZ PA PB PC PD DOESTHEHOUSEHOLDHAVEACCESST PJ PK PL PM PN ISWATERPRESENTFORHANDWASHING PR) (nofood_ntday vacc_yesno vacc_tb vacc_pol vacc_pent vacc_meas vacc_pent_freq vacc_meas_freq chid_ill2wks_dia chid_ill2wks_fev chid_ill2wks_cou chid_ill2wks_non seek_trt_chd trt_rec trt_item_csb trt_item_plump trt_item_oth nfi_kit_plw iycf nfi_kit nfi_kit_full nfi_kit_qua_jerry nfi_kit_qua_soap nfi_kit_qua_aqua nfi_kit_qua_pad nfi_kit_qua_0th wattrt_prac_bo wattrt_prac_chlo wattrt_prac_sun wattrt_prac_filt wattrt_prac_aqua wattrt_prac_oth acc_handwash hwash_sink hwash_bath hwash_laun hwash_oth hwash_oth_spe hwash_wat hwash_pract_fdprep)

rename (PS PT PU PV PW PZ QA QB QC QD QE WHERESHOUDYOUGOTOWHENYOUH UY WHERESHOULDYOURCHILDGOTOWH VA QH QI QJ QK QL QM QQ QR QS QT QU QV QW QX QY QZ RA ARETHEREMOTHERTOMOTHERSUPPO HAVEYOUATTENDEDANYOFTHEMOT WOULDYOUSHARETHISINFORMATION HASYOUNGEST_CHILDEVERBEEN NOTEIFTHEANSWERISLESSTHAN RECORDTHENUMBEROFDAYS WASYOUNGEST_CHILDBREASTFED IFYESHOWMANYTIMESDIDYOUB NOWIWOULDLIKETOASKYOUABOU WASYOUNGEST_CHILDGIVENORAL PLAINWATER INFANTFORMULA HOWMANYTIMESYESTERDAYDURING ANYMILKSUCHASTINNEDPOWDERE RU ANYJUICEORJUICEDRINKS CLEARBROTH YOGURT RY ANYTHINPORRIDGE ANYOTHERLIQUIDS DIDYOUNGEST_CHILDDRINKANYT CANYOUTELLMEHOWOLDYOUNGE ATWHATAGESHOULDYOUSTARTTO FOODMADEFROMGRAINSSUCHASB PUMPKINCARROTSSQUASHORSWE WHITEPOTATOESWHITEYAMSMANI ANYDARKGREENLEAFYVEGETABLES ANYOTHERVEGETABLES RIPEMANGOESRIPEPAPAYASORO ANYOTHERFRUITS LIVERKIDNEYHEARTOROTHERO ANYMEATFROMDOMESTICATEDANIMA SP ANYFLESHFROMWILDANIMALS EGGS FRESHORDRIEDFISHSHELLFISH ANYFOODSMADEFROMBEANSPEAS ANYFOODSMADEFROMNUTSANDSEE CHEESEYOGURTOROTHERMILKPR ANYOILFATSORBUTTERORFOO ANYSUGARYFOODSSUCHASCHOCOLA CONDIMENTSFORFLAVORSUCHASC FOODSMADEWITHREDPALMOILRE DIDYOUNGEST_CHILDEATANYSO IFYESHOWMANYTIMES TD TE) (hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat hwash_pract_oth hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat hw_mt_kno_oth def_moth_kno def_moth_kno_oth def_chil_kno def_chil_kno_oth wattrt_kno_boil wattrt_kno_chlo wattrt_kno_sun wattrt_kno_fil wattrt_kno_aqua wattrt_kno_oth exc_bfd_kno_bmk exc_bfd_kno_anmlk exc_bfd_kno_formk exc_bfd_kno_porr exc_bfd_kno_sou exc_bfd_kno_tea exc_bfd_kno_wat exc_bfd_kno_fru exc_bfd_kno_veg exc_bfd_kno_me exc_bfd_kno_oth m2m m2m_attd m2m_share bfedchild_ever bf_init_chld_hr bf_init_chld_d bf_chld_yest bf_chld_yest_freq yest_chld_vit yest_chld_ors yest_chld_wat yest_chld_formu yest_chld_for_freq yest_chld_tinmk yest_chld_tmk_freq yest_chld_juice yest_chld_broth yest_chld_yog yest_chld_yog_freq yest_chld_porr yest_chld_othliq yest_chld_bott age_init_liq_pract age_init_liq_kno yest_chld_grain yest_chld_pumk yest_chld_tubers yest_chld_darkveg yest_chld_othveg yest_chld_vitafru yest_chld_othfru yest_chld_live yest_chld_dommt yest_chld_wildliv yest_chld_wilfles yest_chld_egg yest_chld_fish yest_chld_leg yest_chld_nuts yest_chld_mkprod yest_chld_oilfat yest_chld_sug yest_chld_cond yest_chld_palmoil yest_chld_ate_solfd yest_chld_ate_solfd_fq age_init_sol_pract age_init_sol_know)

rename DOESANYMEMBEROFTHISHOUSEHOL own_agric_land


drop ACCORDINGTOTHEHHIDHH_ID PLEASEENTERTHEINFORMATIONTHA RESPONDENT_KNOWLEDGE DOYOUAGREEANDCONSENTTOBEI ENUMERATORNAMEACKNOWLEDINGTH ENUMERATORSIGNATUREACKNOWLEDI AZ BO CF CH CJ FB FC FD FE FF FG FH FI FJ FK GA GB GC GD GE GF GG GH GI GJ GK GL HD HE HF HG HH HI HJ HK HL HM HN HO HP HR HT UD UE UF UG UH UI UJ UK UL UM UN UO UP UQ UR US UT UU UV 

**
destring MOTHER_AGE, gen (mothersage)
destring CHILD_AGE1, gen (age_chld)
destring NOF_CHILDREN, gen (num_u5_children)
destring EXP_FOOD_MONTHLY EXP_NUTFOOD_MONTHLY EXP_CALC, gen (exp_food_monthly exp_nutfood_monthly exp_total)


*********
*  Other indicators- Linked to baseline 
**********

multencode WHATISYOURCURRENTEDUCATIONL WHOISTHECURRENTHEADOFHOUSE IFYESDIDYOUASTHEMOTHERHA, gen (edu hoh illness_preg)   
drop WHATISYOURCURRENTEDUCATIONL WHOISTHECURRENTHEADOFHOUSE IFYESDIDYOUASTHEMOTHERHA

rename (IFYESDIDYOUATTENDANTENATAL IFYESHOWMANYTIMESDIDYOUA IFYESDIDYOURECEIVEVITAS ) (anc anc_number iron_folate_lastpreg)
    
 foreach x in anc iron_folate_lastpreg {
	label values `x' yesno
}  

/*
encode hwash_oth_spe, gen (hwash_other_spe)
drop hwash_oth_spe
rename (hwash_other_spe)(hwash_oth_spe)

*/
*********
*  New Displacements indicators 
**********

multencode IFYESREASONFORCURRENTDISPL MONEY MARKET JOBSLIVELIHOOD FOOD EDUCATION HEALTHCARE, gen(curr_disp_reason curr_disp_money_access curr_disp_markt_access curr_disp_jobs_access curr_disp_food_access curr_disp_educ_access curr_disp_heath_access)

drop IFYESREASONFORCURRENTDISPL MONEY MARKET JOBSLIVELIHOOD FOOD EDUCATION HEALTHCARE

rename (HASYOURHHBEENDISPLACEDINTH BT BU BV BW) (hh_recently_disp recent_disp_floods recent_disp_conflict recent_disp_lackoffood recent_disp_other)


*********
* Preparing Endline data for appending
*********
* Renaming and relabeling 
rename oedemachld1  oedema_chld
rename wtchld1 wt_chld
rename htchld1 ht_chld
rename muacchld1 muac_chld
rename TIME time_datacollect
rename CHILD_ID1 id_chld
rename sexchld1 sex_chld

gen hh_endline_reached=1
label variable hh_endline_reached "HH was reached at endline"
order sex_chld, after(id_chld)

tab sex_chld
tab sex_chld, nolabel
replace sex_chld=1 if sex_chld==1822
replace sex_chld=2 if sex_chld==1257
label def sex 1 "Male" 2 "Female"
label value sex_chld sex
outsheet hhid id_chld region arm sex_chld age_chld wt_chld ht_chld  using Sex_Endine.csv, comma replace

tab age_chld
replace age_chld=age_chld+3

tab region
tab region, nolabel
replace region=0 if region==461
replace region=1 if region==1520
label def reg 0 "Bay" 1 "Hiran"
label value region reg

tab oedema_chld
tab oedema_chld, nolabel
replace oedema_chld =0 if oedema_chld==1341
replace oedema_chld=1 if oedema_chld==1767
label value oedema_chld yesno

tab hoh
tab hoh, nolabel
replace hoh =0 if hoh==1
replace hoh=1 if hoh==8
replace hoh=. if hoh==6
label value hoh yesno

tab preg
tab preg, nolabel
replace preg =0 if preg==996
replace preg=1 if preg==1304
label value preg yesno

tab newborn_cs
tab newborn_cs, nolabel
replace newborn_cs =0 if newborn_cs==996
replace newborn_cs=1 if newborn_cs==1304
label value newborn_cs yesno

tab arm
tab arm, nolabel
replace arm=1 if arm==370
replace arm=2 if arm==371
replace arm=3 if arm==372
label def arms 1 "Arm 1" 2 "Arm 2" 3"Arm 3"
label value arm arms

tab edu
tab edu, nolabel
replace edu=. if edu==2
replace edu=1 if edu==5
replace edu=2 if edu==4
replace edu=3 if edu==7
replace edu=4 if edu==9 
label def education 1 "No Formal Edu" 2 "Madrasa" 3 "Primary" 4 "Secondary"
label value edu education

tab decision_income
tab decision_income, nolabel
replace decision_income=1 if decision_income==1058
replace decision_income=2 if decision_income==1057
replace decision_income=3 if decision_income==567
replace decision_income=. if decision_income==1019
label def dec_income 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_income dec_income

tab decision_healthcare
tab decision_healthcare, nolabel
replace decision_healthcare=1 if decision_healthcare==1058
replace decision_healthcare=2 if decision_healthcare==1057
replace decision_healthcare=3 if decision_healthcare==567
replace decision_healthcare=. if decision_healthcare==1019
label def dec_healthcare 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_healthcare dec_healthcare


tab decision_purchases
tab decision_purchases, nolabel
replace decision_purchases=1 if decision_purchases==1058
replace decision_purchases=2 if decision_purchases==1057
replace decision_purchases=3 if decision_purchases==567
replace decision_purchases=. if decision_purchases==1019
label def dec_purchases 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_purchases dec_purchases

tab newborn
tab newborn,nolabel
replace newborn =0 if newborn==996
replace newborn=1 if newborn==1304
label value newborn yesno

tab own_bankaccount
tab own_bankaccount,nolabel
replace own_bankaccount =0 if own_bankaccount==1314
replace own_bankaccount=1 if own_bankaccount==1767
replace own_bankaccount=. if own_bankaccount==858
label value own_bankaccount yesno

multencode RECORDRESPONDENTSTELEPHONENU RECORDALTERNATETELEPHONENUMBE, gen(tel1_endline tel2_endline)
format tel1_endline %9.0f
format tel2_endline %9.0f
tab tel1_endline
tab tel2_endline

** HH MEMBERS 
tab hh_members
tab hh_members,nolabel
replace hh_members =. if hh_members== 271
replace hh_members =. if hh_members==571
replace hh_members =. if hh_members== 648
replace hh_members =. if hh_members== 656
replace hh_members =. if hh_members== 657
replace hh_members =. if hh_members== 661
replace hh_members =. if hh_members== 707
replace hh_members =. if hh_members== 755
replace hh_members =. if hh_members== 766
replace hh_members =. if hh_members== 779
replace hh_members =. if hh_members==780
replace hh_members =. if hh_members== 840
replace hh_members =. if hh_members== 872
replace hh_members =. if hh_members== 910
replace hh_members =. if hh_members== 942
replace hh_members =. if hh_members== 943
replace hh_members =. if hh_members== 1054
replace hh_members =. if hh_members== 1351
replace hh_members =. if hh_members== 1412
replace hh_members =. if hh_members== 1532
replace hh_members =. if hh_members==1574
replace hh_members =. if hh_members== 1588
replace hh_members =. if hh_members== 1589
replace hh_members =. if hh_members== 1692
replace hh_members =. if hh_members== 1788
replace hh_members =. if hh_members==5
replace hh_members =23 if hh_members==24
replace hh_members =5 if hh_members==7


tab malnut_screening_last3mths
tab malnut_screening_last3mths,nolabel
replace malnut_screening_last3mths=1 if malnut_screening_last3mths==406
replace malnut_screening_last3mths=2 if malnut_screening_last3mths==404
replace malnut_screening_last3mths=3 if malnut_screening_last3mths==403
replace malnut_screening_last3mths=4 if malnut_screening_last3mths==338
label def mal_screen 1 "Mother" 2 "Child" 3 "Both(Mother+Child)" 4 "None"
label value malnut_screening_last3mths mal_screen


tab malnu_trt_last3mths
tab malnu_trt_last3mths,nolabel
replace malnu_trt_last3mths=1 if malnu_trt_last3mths==406
replace malnu_trt_last3mths=2 if malnu_trt_last3mths==404
replace malnu_trt_last3mths=3 if malnu_trt_last3mths==403
replace malnu_trt_last3mths=4 if malnu_trt_last3mths==338
label def mal_trt 1 "Mother" 2 "Child" 3 "Both(Mother+Child)" 4 "None"
label value malnu_trt_last3mths mal_trt

tab water_mainsource
tab water_mainsource, nolabel
replace water_mainsource=1 if water_mainsource==196
replace water_mainsource=2 if water_mainsource==369
replace water_mainsource=3 if water_mainsource==374
replace water_mainsource=4 if water_mainsource==375
replace water_mainsource=6 if water_mainsource==380
replace water_mainsource=7 if water_mainsource== 388
replace water_mainsource=. if water_mainsource==197 | water_mainsource==353
label def wat_source 1 "Borehole or tube well" 2 "Piped water or public tap" 3 "Protected dug well or protected spring" 4 "Rainwater collection" 5 "Surface water (river, lake, stream, etc" 6 "Tanker truck or cart" 7 "Unprotected dug well or unprotected spr"
label value water_mainsource wat_source

tab toilet_type
tab toilet_type, nolabel
replace toilet_type=1 if toilet_type==281
replace toilet_type=2 if toilet_type==299
replace toilet_type=3 if toilet_type==313
replace toilet_type=4 if toilet_type==336
replace toilet_type=5 if toilet_type==370
replace toilet_type=. if toilet_type==352
label def toi_type 1 "Bucket toilet" 2 "Composting toilet" 3 " Flush or pour flush toilet" 4 "No toilet/Bush/Field (open defacation)" 5 " Pit latrine" 
label value toilet_type toi_type

* District
tab district
tab district,nolabel
replace district=0 if district==437
replace district=1 if district==468
replace district=2 if district==1787
replace district=3 if district==1919
label def dist 0 "Baidoa" 1 "Beledweyne" 2 "Mahas" 3 "Mataban"
label value district dist

* Villages
outsheet region district village using Village_Endline.csv, comma replace

tab village
tab village,nolabel

tab village if district==0  // //Baidoa villages
tab village if district==0,nolabel
replace village=1 if village==444
replace village=2 if village==452
replace village=3 if village==490
replace village=4 if village==1003
replace village=5 if village==1027
replace village=6 if village==1280
replace village=7 if village==1282
replace village=8 if village==1283
replace village=9 if village==1361
replace village=10 if village==1398
replace village=11 if village==2815
replace village=12 if village==2854
replace village=13 if village==2936

tab village if district==1 //Beledweyne villages
tab village if district==1,nolabel
replace village=14 if village==1035
replace village=15 if village==1041
replace village=16 if village==1255
replace village=17 if village==1585
replace village=18 if village==1652
replace village=19 if village==2658
replace village=20 if village==2824

tab village if district==2 //Mahas villages
tab village if district==2,nolabel
replace village=21 if village==474
replace village=22 if village==1028
replace village=23 if village==1285
replace village=24 if village==1787

tab village if district==3 //Mataban villages
tab village if district==3,nolabel
replace village=25 if village==446
replace village=26 if village==472
replace village=27 if village==1042
replace village=28 if village==1284
replace village=29 if village==1406
replace village=30 if village==1922
replace village=31 if village==1948
replace village=32 if village==2388
replace village=33 if village==2403

label def vil 1 "Banadir cluster" 2 "Barwaaqo cluster" 3 "Boodan Cluster" 4 " Deg Galoole Cluster" 5 "Doon waraabe Cluster" 6 " Garasgof cluster" 7 "Gas LO' cluster" 8 "Gelgelweyn cluster" 9 "Halimey Cluster" 10 "Hanano2 cluster" 11 "Tawakal2 Dinsoor" 12 "Walaq1 cluster" 13 "Yaa rabi cluster" 14 "Dusmo" 15 "Elgal" 16 "Feerfeer" 17 "Illinguud" 18 "Jawiil" 19 "Sarirale" 20 "Tuulo Hiran" 21 "Bilcile" 22 "Duduncad" 23 "Goob" 24 "Mahas" 25 "Barkurtan" 26 "Bergadiid" 27 "Elmijowle" 28 "Gerijir" 29 "Harqaboobe" 30 "Mataban town" 31 "Mirqasim" 32 "Qabno" 33 "Qodqod"
label value village vil

* Enum team
tab enum_team
rename enum_team enum_team_endline

rename (NOWIAMGOINGTOTAKEYOURMUAC MOTHERSWEIGHTKGTOTHENEAR ) (muac_mother wt_mother)
drop hwash_oth_spe 
drop HOWMUCHWOULDYOUESTIMATEYOU KI

drop CU exc_bfd_prac_oth_sp HOWMANYHOUSEHOLDMEMBERSAREC HOWMANYOFTHECHILDRENINTHIS ACCORDINGTOINFORMATIONFROMTH ISCHILD_NAME2AVAILABLENOW ISCHILD_NAME3AVAILABLENOW ISCHILD_NAME4AVAILABLENOW FORTHENEXTSETOFQUESTIONSI OT PE PG PX QF QN RB _COLLECTGPS_LATITUDE _COLLECTGPS_LONGITUDE _COLLECTGPS_ALTITUDE _COLLECTGPS_PRECISION def_moth_kno_oth def_chil_kno_oth namechld2 idchld2 sexchld2 namechld3 idchld3 sexchld3 namechld4 idchld4 sexchld4 child2_name_rep child2_sex_rep rshi_to_child2 child2_age_rep oedemachld2 child2_current_inwasting_prog child3_name_rep child3_sex_rep rshi_to_child3 child3_age_rep oedemachld3 child3_current_inwasting_prog child4_name_rep child4_sex_rep rshi_to_child4 child4_age_rep oedemachld4 child4_current_inwasting_prog rship_if_other water_mainsource_other

tab cluster
tab cluster, nolabel
replace cluster=10 if cluster==818
replace cluster=11 if cluster==819
replace cluster=12 if cluster==820
replace cluster=13 if cluster==821
replace cluster=14 if cluster==822
replace cluster=15 if cluster==823
replace cluster=16 if cluster==824
replace cluster=17 if cluster==825
replace cluster=18 if cluster==826
replace cluster=19 if cluster==827
replace cluster=2 if cluster==828
replace cluster=20 if cluster==829
replace cluster=21 if cluster==830
replace cluster=22 if cluster==831
replace cluster=23 if cluster==832
replace cluster=24 if cluster==833
replace cluster=25 if cluster==834
replace cluster=26 if cluster==835
replace cluster=27 if cluster==836
replace cluster=28 if cluster==837
replace cluster=29 if cluster==838
replace cluster=3 if cluster==839
replace cluster=30 if cluster==840
replace cluster=31 if cluster==841
replace cluster=32 if cluster==842
replace cluster=33 if cluster==843
replace cluster=4 if cluster==844
replace cluster=5 if cluster==845
replace cluster=6 if cluster==846
replace cluster=7 if cluster==847
replace cluster=8 if cluster==848
replace cluster=9 if cluster==849
replace cluster=1 if cluster==933

label def clust 1 "CL1" 2 "CL2" 3 "CL3" 4 "CL5" 5 "CL5" 6 "CL6" 7 "CL7" 8 "CL8" 9 "CL9" 10 "CL10" 11 "CL11" 12 "CL12" 13 "CL13" 14 "CL14" 15 "CL15" 16 "CL16" 17 "CL17" 18 "CL18" 19 "CL19" 20 "CL20" 21 "CL21" 22 "CL22" 23 "CL23" 24 "CL24" 25 "CL25" 26 "CL26" 27 "CL27" 28 "CL28" 29 "CL29" 30 "CL30" 31 "CL31" 32 "CL32" 33 "CL33"
label value cluster clust

**************************
** Summary and checking duplicates 
*************************
tabstat hhid, by(arm) stat(N) // 

duplicates report
tabstat hhid, by(arm) stat(N) 

sort hhid
order id_chld, after(hhid)
order sex_chld, after(id_chld)


save "R2HC_Endlinedata_reshaped.dta", replace 

use R2HC_Endlinedata_reshaped.dta, clear

********
* Prepare BaselineMidline data for appending 
*******
use R2HC_BaselineMidlineData_appendedv0.dta, clear
describe exc_bfd_prac_oth_sp
multencode exc_bfd_prac_oth_sp rship_other_name rship_other_age, gen(exc_bfd_prac_other_sp rship_oth_name rship_oth_age)
drop exc_bfd_prac_oth_sp rship_other_name rship_other_age
rename (exc_bfd_prac_other_sp rship_oth_name rship_oth_age) (exc_bfd_prac_oth_sp rship_other_name rship_other_age)


tab edu
tab edu, nolabel
replace edu=1 if edu==1139
replace edu=2 if edu==932
replace edu=3 if edu==1223
replace edu=4 if edu==1390
label def education 1 "No Formal Edu" 2 "Madrasa" 3"Primary" 4 "Secondary"
label value edu education

tab decision_income
tab decision_income, nolabel
replace decision_income=1 if decision_income==1279| decision_income==2643
replace decision_income=2 if decision_income==1278 | decision_income==2642
replace decision_income=3 if decision_income==788 | decision_income==1550
replace decision_income=. if decision_income==1207 | decision_income==2504
label def dec_income 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_income dec_income

tab decision_healthcare
tab decision_healthcare, nolabel
replace decision_healthcare=1 if decision_healthcare==1279| decision_healthcare==2643
replace decision_healthcare=2 if decision_healthcare==1278 | decision_healthcare==2642
replace decision_healthcare=3 if decision_healthcare==788 | decision_healthcare==1550
replace decision_healthcare=. if decision_healthcare==1207 | decision_healthcare==2504
label def dec_healthcare 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_healthcare dec_healthcare


tab decision_purchases
tab decision_purchases, nolabel
replace decision_purchases=1 if decision_purchases==2643
replace decision_purchases=2 if decision_purchases==2642
replace decision_purchases=3 if decision_purchases==1550
replace decision_purchases=. if decision_purchases==2504
label def dec_purchases 1 "Jointly" 2 "Mother" 3"Father" 
label value decision_purchases dec_purchases

tab malnut_screening_last3mths
tab malnut_screening_last3mths,nolabel
replace malnut_screening_last3mths=1 if malnut_screening_last3mths==40 |malnut_screening_last3mths==507
replace malnut_screening_last3mths=2 if malnut_screening_last3mths==39 |malnut_screening_last3mths==505
replace malnut_screening_last3mths=3 if malnut_screening_last3mths==38 |malnut_screening_last3mths== 504
replace malnut_screening_last3mths=4 if malnut_screening_last3mths==26 |malnut_screening_last3mths==373
label def mal_screen 1 "Mother" 2 "Child" 3 "Both(Mother+Child)" 4 "None"
label value malnut_screening_last3mths mal_screen


tab malnu_trt_last3mths
tab malnu_trt_last3mths,nolabel
replace malnu_trt_last3mths=1 if malnu_trt_last3mths==40 |malnu_trt_last3mths==507
replace malnu_trt_last3mths=2 if malnu_trt_last3mths==39 |malnu_trt_last3mths==505
replace malnu_trt_last3mths=3 if malnu_trt_last3mths==38 |malnu_trt_last3mths== 504
replace malnu_trt_last3mths=4 if malnu_trt_last3mths==26 |malnu_trt_last3mths==373
label def mal_trt 1 "Mother" 2 "Child" 3 "Both(Mother+Child)" 4 "None"
label value malnu_trt_last3mths mal_trt


tab water_mainsource
tab water_mainsource, nolabel
replace water_mainsource=1 if water_mainsource==233 |water_mainsource==516
replace water_mainsource=2 if water_mainsource==1636 |water_mainsource==432
replace water_mainsource=3 if water_mainsource==1638 |water_mainsource== 438
replace water_mainsource=4 if water_mainsource==1681 |water_mainsource==439
replace water_mainsource=5 if water_mainsource==2010 |water_mainsource==453
replace water_mainsource=6 if water_mainsource==2013 |water_mainsource==455
replace water_mainsource=7 if water_mainsource== 2024|water_mainsource== 462
replace water_mainsource=. if water_mainsource==1633 |water_mainsource==406 | water_mainsource==234
label def wat_source 1 "Borehole or tube well" 2 "Piped water or public tap" 3 "Protected dug well or protected spring" 4 "Rainwater collection" 5 "Surface water (river, lake, stream, etc" 6 "Tanker truck or cart" 7 "Unprotected dug well or unprotected spr"
label value water_mainsource wat_source

tab toilet_type
tab toilet_type, nolabel
replace toilet_type=1 if toilet_type==517
replace toilet_type=2 if toilet_type==608 |toilet_type==312
replace toilet_type=3 if toilet_type==770 |toilet_type==327
replace toilet_type=4 if toilet_type==1592 |toilet_type==370
replace toilet_type=5 if toilet_type==1637 |toilet_type==433
replace toilet_type=. if toilet_type==1632 |toilet_type==405
label def toi_type 1 "Bucket toilet" 2 "Composting toilet" 3 " Flush or pour flush toilet" 4 "No toilet/Bush/Field (open defacation)" 5 " Pit latrine" 
label value toilet_type toi_type

tab hh_members
replace hh_members=. if hh_members > 23 & !missing(hh_members)
replace time_datacollect=1 if time_datacollect==3

drop ifotherspecify hwash_oth_spe cilh1_avail accordingtoinformationfromth gx hr forthenextsetofquestionsi _index

tab district if time_datacollect==0
tab district if time_datacollect==0,nolabel
replace district=0 if district==141
replace district=1 if district==157
replace district=2 if district==933
replace district=3 if district==995
label def dist 0 "Baidoa" 1 "Beledweyne" 2 "Mahas" 3 "Mataban"
label value district dist

tab district if time_datacollect==1
tab district if time_datacollect==1,nolabel
replace district=0 if district==534
replace district=1 if district==566
replace district=2 if district==1842
replace district=3 if district==1983
tab district

* Villages
outsheet region district village  if time_datacollect==0 using Village_Baseline.csv, comma replace

tab village if time_datacollect==0 & district==0. //Baidoa villages at baseline 
tab village if time_datacollect==0 & district==0,nolabel
replace village=1 if village==143
replace village=2 if village==151
replace village=3 if village==171
replace village=4 if village==322
replace village=5 if village==343
replace village=6 if village==561
replace village=7 if village==563
replace village=8 if village==564
replace village=9 if village==655
replace village=10 if village==679
replace village=11 if village==1475
replace village=12 if village==1514
replace village=13 if village==1596

tab village if time_datacollect==1 & district==0. // Baidoa villages at midline 
tab village if time_datacollect==1 & district==0,nolabel
replace village=1 if village==542
replace village=2 if village==551
replace village=3 if village==585
replace village=4 if village==906
replace village=5 if village==943
replace village=6 if village==1236
replace village=7 if village==1238
replace village=8 if village==1239
replace village=9 if village==1346
replace village=10 if village==1389
replace village=11 if village==3064
replace village=12 if village==3124
replace village=13 if village==3242


tab village if time_datacollect==0 & district==1 //Beledweyne villages at baseline 
tab village if time_datacollect==0 & district==1,nolabel
replace village=14 if village==352
replace village=15 if village==357
replace village=16 if village==529
replace village=17 if village==814
replace village=18 if village==844
replace village=19 if village==1386
replace village=20 if village==1486

tab village if time_datacollect==1 & district==1 //Beledweyne villages at midline 
tab village if time_datacollect==1 & district==1,nolabel
replace village=14 if village==953
replace village=15 if village==966
replace village=16 if village==1199
replace village=17 if village==1609
replace village=18 if village==1689
replace village=19 if village==2873
replace village=20 if village==3085

tab village if time_datacollect==0 & district==2 //Mahas villages at baseline 
tab village if time_datacollect==0 & district==2,nolabel
replace village=21 if village==161
replace village=22 if village==345
replace village=23 if village==566
replace village=24 if village==933

tab village if time_datacollect==1 & district==2 //Mahas villages at midline
tab village if time_datacollect==1 & district==2,nolabel
replace village=21 if village==569
replace village=22 if village==944
replace village=23 if village==1250
replace village=24 if village==1842

tab village if time_datacollect==0 & district==3 //Mataban villages at baseline 
tab village if time_datacollect==0 & district==3,nolabel
replace village=25 if village==145
replace village=26 if village==158
replace village=27 if village==358
replace village=28 if village==565
replace village=29 if village==687
replace village=30 if village==996
replace village=31 if village==1007
replace village=32 if village==1233
replace village=33 if village==1243


tab village if time_datacollect==1 & district==3 //Mataban villages at midline 
tab village if time_datacollect==1 & district==3,nolabel
replace village=25 if village==544
replace village=26 if village==567
replace village=27 if village==967
replace village=28 if village==1240
replace village=29 if village==1399
replace village=30 if village==1984
replace village=31 if village==2026
replace village=32 if village==2559
replace village=33 if village==2579

label def vil 1 "Banadir cluster" 2 "Barwaaqo cluster" 3 "Boodan Cluster" 4 " Deg Galoole Cluster" 5 "Doon waraabe Cluster" 6 " Garasgof cluster" 7 "Gas LO' cluster" 8 "Gelgelweyn cluster" 9 "Halimey Cluster" 10 "Hanano2 cluster" 11 "Tawakal2 Dinsoor" 12 "Walaq1 cluster" 13 "Yaa rabi cluster" 14 "Dusmo" 15 "Elgal" 16 "Feerfeer" 17 "Illinguud" 18 "Jawiil" 19 "Sarirale" 20 "Tuulo Hiran" 21 "Bilcile" 22 "Duduncad" 23 "Goob" 24 "Mahas" 25 "Barkurtan" 26 "Bergadiid" 27 "Elmijowle" 28 "Gerijir" 29 "Harqaboobe" 30 "Mataban town" 31 "Mirqasim" 32 "Qabno" 33 "Qodqod"
label value village vil

* Enumerator Teams
tab enumeratornameacknowledingth
rename enumeratornameacknowledingth enum_baseline

tab enum_team
rename enum_team enum_team_midline

sort hhid
order id_chld, after(hhid)
order sex_chld, after(id_chld)

* Cluster 
tab cluster if time_datacollect==0
tab cluster if time_datacollect==0, nolabel
replace cluster=10 if cluster==173
replace cluster=11 if cluster==174
replace cluster=12 if cluster==175
replace cluster=13 if cluster==176
replace cluster=14 if cluster==177
replace cluster=15 if cluster==178
replace cluster=16 if cluster==179
replace cluster=17 if cluster==180
replace cluster=18 if cluster==181
replace cluster=19 if cluster==182
replace cluster=2 if cluster==183
replace cluster=20 if cluster==184
replace cluster=21 if cluster==185
replace cluster=22 if cluster==186
replace cluster=23 if cluster==187
replace cluster=24 if cluster==188
replace cluster=25 if cluster==189
replace cluster=26 if cluster==190
replace cluster=27 if cluster==191
replace cluster=28 if cluster==192
replace cluster=29 if cluster==193
replace cluster=3 if cluster==194
replace cluster=30 if cluster==195
replace cluster=31 if cluster==196
replace cluster=32 if cluster==197
replace cluster=33 if cluster==198
replace cluster=4 if cluster==199
replace cluster=5 if cluster==200
replace cluster=6 if cluster==201
replace cluster=7 if cluster==202
replace cluster=8 if cluster==203
replace cluster=9 if cluster==204
replace cluster=1 if cluster==262

tab cluster if time_datacollect==1
tab cluster if time_datacollect==1, nolabel
replace cluster=10 if cluster==657
replace cluster=11 if cluster==658
replace cluster=12 if cluster==659
replace cluster=13 if cluster==660
replace cluster=14 if cluster==661
replace cluster=15 if cluster==662
replace cluster=16 if cluster==663
replace cluster=17 if cluster==664
replace cluster=18 if cluster==665
replace cluster=19 if cluster==666
replace cluster=2 if cluster==667
replace cluster=20 if cluster==668
replace cluster=21 if cluster==669
replace cluster=22 if cluster==670
replace cluster=23 if cluster==671
replace cluster=24 if cluster==672
replace cluster=25 if cluster==673
replace cluster=26 if cluster==674
replace cluster=27 if cluster==675
replace cluster=28 if cluster==676
replace cluster=29 if cluster==677
replace cluster=3 if cluster==678
replace cluster=30 if cluster==679
replace cluster=31 if cluster==680
replace cluster=32 if cluster==681
replace cluster=33 if cluster==682
replace cluster=4 if cluster==683
replace cluster=5 if cluster==684
replace cluster=6 if cluster==685
replace cluster=7 if cluster==686
replace cluster=8 if cluster==687
replace cluster=9 if cluster==688
replace cluster=1 if cluster==822

label def clust 1 "CL1" 2 "CL2" 3 "CL3" 4 "CL5" 5 "CL5" 6 "CL6" 7 "CL7" 8 "CL8" 9 "CL9" 10 "CL10" 11 "CL11" 12 "CL12" 13 "CL13" 14 "CL14" 15 "CL15" 16 "CL16" 17 "CL17" 18 "CL18" 19 "CL19" 20 "CL20" 21 "CL21" 22 "CL22" 23 "CL23" 24 "CL24" 25 "CL25" 26 "CL26" 27 "CL27" 28 "CL28" 29 "CL29" 30 "CL30" 31 "CL31" 32 "CL32" 33 "CL33"
label value cluster clust

tab cluster 
tab cluster, nolabel


save "R2HC_BaselineMidlineData_appendedv1.1.dta", replace

*************
* APPEND
*************
use R2HC_BaselineMidlineData_appendedv1.1.dta, clear
append using R2HC_Endlinedata_reshaped.dta
describe, short

elabel variable (name_chld sex_chld age_chld wt_chld ht_chld muac_chld oedema_chld) ("Child Name" "Child Sex" "Child Age" "Child Weight" "Child Height" "Child MUAC" "Child Oedema")

save "R2HC_CleanAllData_v0.dta", replace  // This is the clean dataset for all three time points


**//////////////////////////////
********************************
* ANALYSIS OF OVEALL R2HC DATASET
********************************
**//////////////////////////////

use R2HC_CleanAllData_v0.dta, clear

label def timepoint 0 "Baseline" 1 "Midline" 2 "Endline"
label value time_datacollect timepoint

gen retained= .
replace retained=1 if hh_baseline_reached==1
replace retained=2 if hh_midline_reached==1
replace retained=3 if hh_endline_reached==1
label def reta 1 "At Baseline" 2 "Retained_Midline" 3 "Retained_Endline"
label value retained reta

** HH missing a U5 child record at baseline 
 list hhid time_datacollect if num_u5_children ==0  // HH 1469 didnt have an U5 child at baseline. I dropped this HH from baseline 
drop if hhid==1469 & time_datacollect==0

** Duplicates 
* id_chld
duplicates report id_chld if time_datacollect==0    // no duplicates child ID
duplicates report id_chld if time_datacollect==1   // no duplicates child ID
duplicates report id_chld if time_datacollect==2 // 2 duplicates child IDs

duplicates list id_chld if time_datacollect==2 // CH075 and CH560 have duplicates at endline

list hhid id_chld sex_chld age_chld wt_chld ht_chld muac_chld oedema_chld wt_mother muac_mother mother_name if id_chld=="CH075" & time_datacollect==2
list hhid id_chld sex_chld age_chld wt_chld ht_chld muac_chld oedema_chld wt_mother muac_mother mother_name if id_chld=="CH560" & time_datacollect==2
drop if id_chld=="CH075" & time_datacollect==2 & wt_mother==67.5 
drop if id_chld=="CH560" & time_datacollect==2 & wt_mother==20.3        // dropped the duplicates children from endline dataset

** Number of HH
drop ychld_tag

** Tagging youngest children at each time points 
egen ychld_tag0 = tag(hhid) if time_datacollect==0
egen ychld_tag1 = tag(hhid) if time_datacollect==1
egen ychld_tag2 = tag(hhid) if time_datacollect==2
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)

tabstat hhid if ychld_tag0==1 | ychld_tag1==1 | ychld_tag2==1, by(time_datacollect) stat(N) nototal
dtable hhid if ychld_tag0==1 | ychld_tag1==1 | ychld_tag2==1, by(time_datacollect) title("Total Households per Timepoint") ///
export(table0.xlsx, replace)


/*
graph bar (count) if ychld_tag0==1 | ychld_tag1==1 | ychld_tag2==1, over (time_datacollect) ytitle(Number of HH) title("Number of HHs per Timepoint") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(hh1, replace)  // overall

graph bar (count) if ychld_tag0==1 | ychld_tag1==1 | ychld_tag2==1, over (time_datacollect) over(arm) ytitle(Number of HH) title("Number of HHs per Timepoint &Arm") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) bar(2,color(red)) bar(3,color(sand)) name(hh2, replace)  // by arm

grc1leg hh1 hh2, legendfrom(hh1) ycommon altshrink

* Note- HHs at baseline= 1490, HHs at midline = 1261, HHs at endline = 1153

tabstat sex_chld if ychld_tag0==1 | ychld_tag1==1 | ychld_tag2==1, by(time_datacollect) stat(N) nototal
*/

*----------------------------------------
*   SETTING PANEL DATA
*----------------------------------------
count if missing(id_chld)
count if missing(hhid)

gen id_child = real(substr(id_chld,3,.)) // extract child id to numeric so it can set the panel data.
label variable id_child "child ID"

order hhid, first
order id_chld, after(hhid)
order id_child, after(id_chld)
order time_datacollect, after(id_child)
order hh_baseline_reached, after(time_datacollect)
order hh_midline_reached, after(hh_baseline_reached)
order hh_endline_reached, after(hh_midline_reached)
order sex_chld, after(hh_endline_reached)
order age_chld, after(sex_chld)
order wt_chld, after(age_chld)
order ht_chld, after(wt_chld) 
order muac_chld, after(ht_chld) 
order oedema_chld, after(muac_chld)
sort hhid id_child time_datacollect

isid id_child time_datacollect 
xtset id_child time_datacollect  
xtdescribe

** Tagging panel observations and their patterns

**
by id_child (time_datacollect), sort: gen obs_count = _N
tab id_child if obs_count ==3 // this will list those with less than 2 observations 

** Using Frame
frame copy default id_child_time_datacollect
frame change id_child_time_datacollect
keep id_child time_datacollect
sort id_child time_datacollect
forvalues y = 0/2 {
    by id_child (time_datacollect): egen participated`y' = max(time_datacollect == `y')
}
drop time_datacollect
duplicates drop

frame change default
frlink m:1 id_child, frame(id_child_time_datacollect)
frget participated*, from(id_child_time_datacollect)
frame drop id_child_time_datacollect

tab participated0 
tab participated1 
tab participated2

tab id_child if participated0 & participated1 & participated2

** Summarizes all observations in the time period and not only number of individuals 


*----------------------------------------
*   HH ATTRITION AT MIDLINE and ENDLINE
*----------------------------------------
gen midline=1  if participated0 & participated1
replace midline=0 if participated0 & !participated1

label define fup1 0 "Lost at midline" 1 "Retained at midline"
label value midline fup1
tab midline

gen endline=1  if participated0 & participated2
replace endline=0 if participated0 & !participated2

label define fup2 0 "Lost at endline" 1 "Retained at endline"
label value endline fup2
tab endline

/*
*** Excluding data with gaps from analyiss 
xtdescribe
tsspell time_datacollect, cond(D.time_datacollect==1)
replace _spell= F._spell if _spell==0
egen nspell=max(_spell), by(id_chld)
tab nspell
drop if nspell>0
*/

*Note:
*287 (15%) children were not reached at Midline from a baseline total of 1894
** Within variation (variation btn same child over time)
* Between variations (Variation btn diffrent children over time)

xtsum sex_chld age_chld wt_chld


* INVESTIGATING HHs and Children lost to follow-up at midline and endline
tabstat hhid if time_datacollect==0, by(midline) stat(N)
tabstat hhid arm if time_datacollect==1  , by(midline)  stat(N) long

dtable i.midline if time_datacollect==0, by(arm, tests) sample("Baseline freq(%)") title("Attrition Rate of Children at Midline") ///
note("pearson test") ///
export(table1b.xlsx, replace)

dtable i.endline if time_datacollect==0, by(arm, tests) sample("Baseline freq(%)") title("Attrition Rate of Children at Endline") ///
note("pearson test") ///
export(table1e.xlsx, replace)


** overall 
dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0, by(midline, tests) sample("Sample freq(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("X-tics of Children at Baseline by Attrition at Midline") ///
note("pearson test") ///
export(table0b.xlsx, replace)

dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0, by(endline, tests) sample("Sample freq(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("X-tics of Children at Baseline by Attrition at Endline") ///
note("pearson test") ///
export(table0e.xlsx, replace)

sort midline
by midline: collect: mean age_chld wt_chld ht_chld muac_chld

* redefine composite result _r_ci to suite your style
collect composite define _a_ci = _r_lb _r_ub, trim
collect style cell result[_a_ci], sformat("[%s]")

* add _r_ci to the result autolevels
collect style autolevels result _a_ci

* change 'var' to 'colname' in the layout
collect layout (colname) (midline#result)

* add CIs for the factor variables
by midline: collect: proportion sex_chld, percent

* add custom string format for the factor variable percent CI limits
collect style cell ///
        colname[i.rep78]#result[_r_lb _r_ub], sformat("%s%%") ///

collect preview
collect export myfile0.xlsx, replace 


**By arms
* Arm 1
dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==1, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children By Attrition at Midline_Arm 1") ///
note("pearson test") ///
export(table2arm1b.xlsx, replace)

dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==1, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children at By Attrition at Endline_Arm 1") ///
note("pearson test") ///
export(table2arm1e.xlsx, replace)
* Arm 2
dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==2, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children at By Attrition at Midline_Arm 2") ///
note("pearson test") ///
export(table2arm2b.xlsx, replace)

dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==2, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children at By Attrition at Endeline_Arm 2") ///
note("pearson test") ///
export(table2arm2e.xlsx, replace)
* Arm 3
dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==3, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children at By Attrition at Mideline_Arm 3") ///
note("pearson test") ///
export(table2arm3b.xlsx, replace)

dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0 & arm==3, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("X-tics of All Children at By Attrition at Endline_Arm 3") ///
note("pearson test") ///
export(table2arm3e.xlsx, replace)

* ==============================================================================
* CHILD ANTHROPOMETRIC MEASURES
* ==============================================================================
** Total number of children
tabstat id_child if time_datacollect==0, by(arm) statistics(N) // 1,894 children at baseline
tabstat id_child if time_datacollect==1, by(arm) statistics(N) // 1607 children at midline
tabstat id_child if time_datacollect==2, by(arm) statistics(N) // 1473 children at endline

*-------------------
* Sex of child 
*------------------
tab sex_chld  arm, col
count if missing(sex_chld)  // no missing 
* Simialr numbers across the three arms 

*-------------------
* Age of child 
*------------------
tab age_chld
tab age_chld arm, col
tab age_chld time_datacollect, col
count if missing(age_chld) // no missig values
hist age_chld
graph box age_chld, over(arm)
tab age_chld if age_chld>59 & time_datacollect==0 
tab age_chld if age_chld>59 & time_datacollect==1 // 98 children aged >59 months 
tab age_chld if age_chld>59 & time_datacollect==2 // 163 children aged >59 months 

/*
* Removed children >59 months 
clonevar age_chld_removed = age_chld
replace age_chld_removed=. if age_chld_removed>59
order age_chld_removed, after(oedema_chld)
*/

* Gave children with age >59 months with 59 following discussion with Nadia.
replace age_chld=59 if age_chld>59 

recode age_chld (6/11= 0 "6-11 Months") (12/23=1 "12-23 Months") (24/59=2 "24-59 Months"), generate(age_chld_gp)
tab age_chld_gp arm, col
order age_chld_gp, after(oedema_chld)

tabstat age_chld,by (arm) statistics(mean min max) nototal col(stat) format(%3.2f) long

recode age_chld (6/23= 0 "<2 years") (24/59=1 "2+ years"), generate(age_chld_2gps)
/*
twoway (histogram age_chld if time_datacollect==0, start(5.5) width(0.85) color(red%30)) ///        
       (histogram age_chld if time_datacollect==3, start(5.5) width(0.85) color(green%30)), ///   
       legend(order(1 "Baseline" 2 "Midline" )) ///
	   title(Histogram of Age)
*/
/*
graph bar if time_datacollect==3, over (age_chld_gp) bar(1,color(sand)) ytitle(Percentage) title("Age group_Overall") blabel(bar,position(outside) format(%9.1f)color(black))  name(ag1,replace)  // overall
graph bar if time_datacollect==3, over(age_chld_gp) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage) title("Age group_By Arm") name(ag2, replace) // by arm
grc1leg ag1 ag2, legendfrom(ag2) ycommon altshrink

*/
* Note-
* Age ranged from 9-62 months 
* 6% (98) children are aged > 59 months- similar across arms

*--------------------
* Presence of Oedema
*--------------------
tab oedema_chld arm, col
tab oedema_chld, nolabel
count if missing(oedema_chld)    // 54 ob is missing Oedema status 
tab oedema_chld arm,col
/*
graph bar if time_datacollect==3, over (oedema_chld) bar(1,color(sand)) ytitle(Percentage of children) title("Oedema_Overall") blabel(bar,position(outside) format(%9.1f)color(black))  name(oed1,replace)  // overall
graph bar if time_datacollect==3,over(oedema_chld) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of children) title("Oedema_By Arm") name(oed2, replace) // by arm

grc1leg oed1 oed2, legendfrom(oed2) ycommon altshrink
*/

* Note:
* 0.94% of children had oedem. (1.1% in Arm 1, 0.2% in Arm2 and 1.6% in Arm 3)

* 1) Child MUAC (in cm)
summ muac_chld, detail   
tab muac_chld
count if missing(muac_chld)                                  //55 ob is missing MUAC
tabstat  muac_chld, statistics( count mean sd min max) by(arm) format(%3.2f) 
tabstat  muac_chld, statistics( count mean sd min max) by(time_datacollect) format(%3.2f) 
    hist  muac_chld, normal color(gray)
	hist muac_chld, by(arm)
    graph box   muac_chld
	graph box   muac_chld, over (arm) 

twoway (histogram muac_chld if time_datacollect==0, start(5.5) width(0.25) color(red%30)) ///        
       (histogram muac_chld if time_datacollect==1, start(5.5) width(0.25) color(green%30)) ///   
       (histogram muac_chld if time_datacollect==2, start(5.5) width(0.25) color(gray%40)), ///
	   legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of MUAC)
	   
/* Notes:
* MUAC range from 11.1-19.2 cm 
* Similar dist. across the three amrs                                                   
*/

* 2) Child Height (in cm)
summ ht_chld, detail    
tab ht_chld
count if missing(ht_chld)            // 54 obs missing height
tabstat  ht_chld, statistics( count mean sd min max) by(arm) format(%3.2f) 
    hist  ht_chld if time_datacollect==0,title(Histogram of Height_Baseline) normal
	hist  ht_chld if time_datacollect==1,title(Histogram of Height_Midline) normal
	hist  ht_chld if time_datacollect==2,title(Histogram of Height_Midline) normal
	hist ht_chld, by(arm)normal
    graph box   ht_chld, mark(1,mlabel( ht_chld))
	graph box   ht_chld, over (arm) mark(1,mlabel( ht_chld))
	replace ht_chld=. if ht_chld ==13.7   // 1 obs replaced with missing
tabstat  ht_chld, statistics( count mean sd min max) by(time_datacollect) format(%3.2f) 	
	
	
/*
	outsheet hhid id_child ht_chld age_chld time_datacollect  if time_datacollect==0 using Ht_Baseline.csv, comma replace
		outsheet hhid id_child ht_chld age_chld time_datacollect  if time_datacollect==1 using Ht_Midline.csv, comma replace
			outsheet hhid id_child ht_chld age_chld time_datacollect  if time_datacollect==2 using Ht_Endine.csv, comma replace		
			bysort id_child (ht_chld): generate ht_mbdiff = ht_chld - ht_chld[_n-2]
			
* Getting diffrence in heights 

* Baseline vs Midline_Arm
gen ispresentm = !missing(ht_chld) 
bysort id_chld (time_datacollect) : gen htdiff_mb = ht_chld[_N-1] - ht_chld[1]
order htdiff_mb, after(ht_chld)
tab htdiff_mb 

count if htdiff_mb < -1&time_datacollect==1
tab id_chld if htdiff_mb < -1 &time_datacollect==1
tabstat id_child if htdiff_mb <-1 &time_datacollect==1, by(arm) statistics(N)

dtable id_child if htdiff_mb <-1 & time_datacollect==1 , by(arm) title("Children with lower heights at midline vs baseline") ///
export(tablehm.xlsx, replace)

gen htdiff_mb_gp=.
replace htdiff_mb_gp=0 if htdiff_mb < -1 &time_datacollect==1
replace htdiff_mb_gp=1 if htdiff_mb >=-1 & htdiff_mb!=. &time_datacollect==1
label def htdmb 0 "<-1cm diff" 1 "Expected range" 
label value htdiff_mb_gp htdmb

graph bar if time_datacollect==1, over(htdiff_mb_gp) title("Ht Difference Btn Midline vs Baseline")
tab htdiff_mb_gp arm,col
tab htdiff_mb_gp region,col

// difference in height b'tn endline and midline	
// Considered allowance of measurement error at 1cm
// 141 children have a decrease in heights at midline compared to baseline

tab htdiff_mb if time_datacollect==1
tab ht_chld if htdiff_mb < -1 & !missing(htdiff_mb) & time_datacollect==1 
gen neg_mid=1 if htdiff_mb < -1 & !missing(htdiff_mb) & time_datacollect==1
replace neg_mid=0 if htdiff_mb >= -1 & !missing(htdiff_mb) & time_datacollect==1
tab neg_mid

gen ht_bas= ht_chld if time_datacollect==0

bysort id_child (time_datacollect) : gen ht_chld_mod1 = ht_chld
order ht_chld_mod1, after(ht_chld)
order ht_bas, after(ht_chld_mod1)
order neg_mid, after (ht_bas)
replace ht_bas=ht_bas[_n-1] if missing(ht_bas)
replace ht_chld_mod1= ht_bas+7.5 if neg_mid==1 & !missing(ht_chld_mod1)
bysort id_chld (time_datacollect) : gen htdiff1 = ht_chld_mod1[_N-1] - ht_chld_mod1[1]
tab htdiff1


* Midline vs Endline
gen ispresent = !missing(ht_chld_mod1) 
bysort ispresent id_chld (time_datacollect) : gen htdiff_em = ht_chld_mod1[_N] - ht_chld_mod1[_N-1]
order htdiff_em, after(htdiff_mb)
tab htdiff_em

count if htdiff_em< -1&time_datacollect==2
tab id_chld if htdiff_em < -1 &time_datacollect==2
tabstat hhid if htdiff_em < -1 &time_datacollect==2, by(arm) statistics(N)

dtable id_child if htdiff_em < -1 & time_datacollect==2 , by(arm) title("Children with lower heights at endline vs baseline") ///
export(tablehe.xlsx, replace)

gen htdiff_em_gp=.
replace htdiff_em_gp=0 if htdiff_em < -1 &time_datacollect==2
replace htdiff_em_gp=1 if htdiff_em >=-1 & htdiff_em!=. &time_datacollect==2
label def htdeb 0 "<-1cm diff" 1 "Expected range" 
label value htdiff_em_gp htdeb

graph bar if time_datacollect==2, over(htdiff_em_gp) title("Ht Difference Btn Endline vs Midline")
tab htdiff_em_gp arm,col
tab htdiff_em_gp region,col

hist  htdiff_em if time_datacollect==2,title(Histogram of Height_Endline) normal

tab htdiff_em_gp enum_team_endline
tab htdiff_em_gp village
tab htdiff_em_gp region, col

// difference in height b'tn endline and midline
// Considered allowance of measurement error at 1cm
// 117 children have a decrease in heights at endeline compared to baseline

tab htdiff_em if time_datacollect==2
tab ht_chld_mod1 if htdiff_em < -1 & !missing(htdiff_em) & time_datacollect==2
gen neg_end=1 if htdiff_em < -1 & !missing(htdiff_em) & time_datacollect==2
replace neg_end=0 if htdiff_em >= -1 & !missing(htdiff_em) & time_datacollect==2
tab neg_end

gen ht_mid= ht_chld_mod1 if time_datacollect==1
bysort id_child (time_datacollect) : gen ht_chld_modified = ht_chld_mod1
order ht_mid, after(ht_bas)
order neg_end, after (ht_mid)
order ht_chld_modified, after (neg_end)

replace ht_mid=ht_mid[_n-1] if missing(ht_mid)
replace ht_chld_modified= ht_mid+7.5 if neg_end==1 
bysort id_chld (time_datacollect) : gen htdiff3 = ht_chld_modified[_N] - ht_chld_modified[_N-1]
tab htdiff3

*/
			
/* Notes*
* 19 obs missing height
* Similar dist. across the arms 
* Vlaues range from 63.3 to 118.4 cm 
*/
twoway (histogram ht_chld if time_datacollect==0, start(55) width(1.75) color(red%30)) ///        
       (histogram ht_chld if time_datacollect==1, start(55) width(1.75) color(green%30)) ///  
	   (histogram ht_chld if time_datacollect==2, start(55) width(1.75) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of Height)

* 3) Child weight (in kg)
summ wt_chld, detail    
tab wt_chld
count if missing(wt_chld)            //54 ob missing weight values
tabstat  wt_chld, statistics( count mean sd min max) by(arm) format(%3.2f) 
    
	hist wt_chld, normal by(arm)
    graph box   wt_chld, mark(1,mlabel( wt_chld))
	graph box   wt_chld, over (arm) mark(1,mlabel( wt_chld))
	
replace wt_chld=. if wt_chld ==93.7   // 1 obs replaced with missing

twoway (histogram wt_chld if time_datacollect==0, start(0) width(0.5) color(red%30)) ///        
       (histogram wt_chld if time_datacollect==1, start(0) width(0.5) color(green%30)) ///   
	   (histogram wt_chld if time_datacollect==2, start(0) width(0.5) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of Weight)
	   
/* Notes**
* 19 obs missing weight value                     
* Weights range from 5.7 - 22.7kg
* Similar dist accross arms
*/

** Investigating the 54 chidren missing anthro measurements
list hhid id_chld arm  name_chld sex_chld if missing(oedema_chld) 
list hhid id_chld arm  name_chld sex_chld if missing(muac_chld)
list hhid id_chld arm  name_chld sex_chld if missing(ht_chld) 
list hhid id_chld arm  name_chld sex_chld if missing(wt_chld) 

tab id_child arm if missing(oedema_chld)
tab age_chld arm if missing(oedema_chld) 

* Note:
* There are 19 children missing muac, wt, ht and oedema data 
* Arm 1= 13, Arm 2=31, Arm 3=10

dtable age_chld wt_chld ht_chld muac_chld, by(time_datacollect, tests nototal) sample("Sample freq(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric mesuremnts") ///
note("pearson test") ///
export(table10.xlsx, replace)


ci mean age_chld wt_chld ht_chld muac_chld if time_datacollect==0
ci mean age_chld wt_chld ht_chld muac_chld if time_datacollect==1
ci mean age_chld wt_chld ht_chld muac_chld if time_datacollect==2


*///////////////////////////////////////
*===================================================	
* Child outcomes (WAZ, HAZ, WHZ BMIZ) for <=59months
*===================================================
*///////////////////////////////////////
/* Use WHO 2006 Child Growth Standard Module (the other who moduel is the igrowup module )
/**ssc install zscore06, replace */  // install the zscore06 module from ssc if using for the first time 
zscore06- calculates anthropometric z-scores using the 2006 WHO child growth standards. Lenght/heigh-for-age, weight-for-height, BMI-for-age and weight-for-age Z-scores are calculated for children 0 to 5 years of age. If the age, height or weight values are outside the range of reference values, a value of 99 is given for the corresponding Z-score(s)
*/
zscore06, a(age_chld) s(sex_chld) h(ht_chld) w(wt_chld) male(1) female(2)  // using age where children above 59 months were given 59 months 
* rename 
rename haz06 haz
rename waz06 waz
rename whz06 whz
rename bmiz06 bmiz
order whz, after(age_chld_gp)
order waz, after(whz)
order haz, after(waz)
order bmiz, after(haz)

/*
zscore06, a(age_chld_removed) s(sex_chld) h(ht_chld) w(wt_chld) male(1) female(2)  // using age where children above 59 months were removed from analysis
* rename 
rename haz06 haz_ageabove59removed
rename waz06 waz_ageabove59removed
rename whz06 whz_ageabove59removed
rename bmiz06 bmiz_ageabove59removed
*/

* HAZ (haz06) ranges from -7.91 to 99 (normal range: -6 to 6)
* WAZ (waz06) ranges from  -6.12 to 99 (normal range: -6 to 5 )
* WHZ (whz06) ranges from  -6.06 to 99 (normal range: -5 to 5)
* BMIZ (bmiz06) ranges from -6.02 to 7.63 (normal range: -5 to 5)

* Flag implausible Z-scores (WHO Child growth standards)
gen hazflagged = .
replace hazflagged = 1 if haz <-6 |haz > 6
gen wazflagged= .
replace wazflagged= 1 if waz <-6 |waz > 5
gen whzflagged= .
replace whzflagged = 1 if whz <-5 |whz > 5
gen bmizflagged= .
replace bmizflagged = 1 if bmiz <-5|bmiz >5
summ hazflagged wazflagged whzflagged bmizflagged     
** HHs they are coming from **
tab arm if hazflagged == 1 | wazflagged==1 |whzflagged==1 | bmizflagged==1 


* Replaced flagged with missing flagged scores (biologically implausible)
replace haz =. if haz <-6 |haz > 6
replace waz =. if waz <-6 |waz > 5
replace whz =. if whz <-5 |whz > 5
replace bmiz =. if bmiz <-5|bmiz >5

/*
** When diffrent age was used
replace haz_ageabove59removed =. if haz_ageabove59removed <-6 |haz_ageabove59removed > 6
replace waz_ageabove59removed =. if waz_ageabove59removed <-6 |waz_ageabove59removed > 5
replace whz_ageabove59removed =. if whz_ageabove59removed <-5 |whz_ageabove59removed > 5
replace bmiz_ageabove59removed =. if bmiz_ageabove59removed <-5|bmiz_ageabove59removed >5
*/

*--------------
* Labeling 
*--------------
label variable haz "HAZ-Score"
label variable waz "WAZ-Score"
label variable whz "WHZ-Score"
label variable bmiz "BMIZ-Score"
/*
label variable haz_ageabove59removed "HAZscore"
label variable waz_ageabove59removed "WAZscore"
label variable whz_ageabove59removed "WHZscore"
label variable bmiz_ageabove59removed "BMIZscore"
label variable hazflagged "Flagged height for age Z-score"
label variable wazflagged "Flagged weight for age Z-score"
label variable whzflagged "Flagged weight for height Z-score"
label variable bmizflagged "Flagged BMI Z-score"
*/


*------------------------
* Height for Age Z-Score
*------------------------
summ haz, detail    
count if missing(haz)            // 73 ob missing HAZ scores
tabstat  haz, statistics( count mean sd median) by(arm) format(%3.2f) 
    hist  haz, normal 
	hist haz, normal by(arm)
    graph box   haz, mark(1,mlabel( haz))
	graph box   haz, over (arm) mark(1,mlabel( haz))
/*
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) ///  
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ)
	   
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) ///   
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ) ///
	   by(arm)
*/	   
*------------------------
* Weight for Age Z-Score
*-----------------------
summ waz, detail    
count if missing(waz)            // 57 ob missing WAZ scores
tabstat  waz, statistics( count mean sd median) by(arm) format(%3.2f) 
    hist  waz, normal 
	hist waz, normal by(arm)
    graph box   waz, mark(1,mlabel( waz))
	graph box   waz, over (arm) mark(1,mlabel( waz))
/*
	twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) ///   
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ)
	   
	   twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) ///  
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ) ///
	   by(arm)
*/
*----------------------------
* Weight for Height Z-Score
*---------------------------
summ whz, detail    
count if missing(whz)            // 69 ob missing WHZ scores
tabstat  whz, statistics( count mean sd median) by(arm) format(%3.2f) 
    hist  whz, normal 
	hist whz, normal by(arm)
    graph box   whz, mark(1,mlabel( whz))
	graph box   whz, over (arm) mark(1,mlabel( whz))

twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) /// 
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ)
	   
	   twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(green%30)) ///   
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(gray%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ_By Arm) ///
	   by(arm)

*--------------
* BMI Z-Score
*--------------
summ bmiz, detail    
count if missing(bmiz)            // 73 ob missing BMIZ scores
tabstat  bmiz, statistics( count mean sd median) by(arm) format(%3.2f) 
    hist  bmiz, normal 
	hist bmiz, normal by(arm)
    graph box   bmiz, mark(1,mlabel( bmiz))
	graph box   bmiz, over (arm) mark(1,mlabel( bmiz))
* Means simialr across the arms 


***
**  Exploring WHZ score
***

kdensity whz,nograph generate(x fx) 
kdensity whz if time_datacollect==0,nograph generate(fx0) at(x) 
kdensity whz if time_datacollect==1,nograph generate(fx1) at(x)
kdensity whz if time_datacollect==2,nograph generate(fx2) at(x)
label var fx0 "Baseline" 
label var fx1 "Midline"
label var fx2 "Endline"
line fx0 fx1 fx2 x, sort ytitle(Density)

/*
gen where = _n + 4 in 1/45
local choices kernel(biweight) bw(5) at(where)

kdensity whz06 if arm==1, `choices' gen(x2 d2)
kdensity whz06 if arm==2, `choices' gen(x1 d1)
kdensity whz06 if arm==3, `choices' gen(x0 d0)

gen rug2 = -0.004
gen rug1 = -0.006
gen rug0 = -0.008

twoway area d2 d1 d0 where, xtitle("`: var label whz06'") color(orange%40 blue%40 gray%40) ///
|| scatter rug2 whz06 if arm==1, ms(|) mc(orange) msize(medlarge) ///
|| scatter rug1 whz06 if arm==2, ms(|) mc(blue) msize(medlarge) ///
|| scatter rug0 whz06 if arm==3, ms(|) mc(gray) msize(medlarge) ///
legend(order(1 "Arm 1" 2 "Arm 2" 3 "Arm 3") pos(1) ring(0) col(1)) ///
ytitle(Probability density) yla(, ang(h)) xla(-6(2)6)


tab whz06

kdensity whz06, lc(red) 

kdensity whz06 if arm==1, lc(red) plot(kdensity whz06 if arm==2, lc(blue) kdensity whz06 if arm==3) legend(order(1 "Arm 1" 2 "Arm 2" 3 "Arm 3") col(1) pos(1) ring(0))
*/


*--------------------------------------------------------------------------------------------------------
* Exploring whether outcomes at baseline of children lost to follow-up are signficantly diffrent those retained 
*---------------------------------------------------------------------------------------------------------
** Z- scores **

** Endline 
dtable whz waz haz if time_datacollect==0, by(endline, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Endline") ///
note("pearson test") ///
export(table6e.xlsx, replace)

/*
* get CIs for the continuous variables
by endline: collect: mean whz waz haz

* redefine composite result _r_ci to suite your style
collect composite define _r_ci = _r_lb _r_ub, trim
collect style cell result[_r_ci], sformat("[%s]")

* add _r_ci to the result autolevels
collect style autolevels result _r_ci

* change 'var' to 'colname' in the layout
collect layout (colname) (endline#result)

/* add CIs for the factor variables
by midline: collect: proportion for rep, percent
*/
* add custom string format for the factor variable percent CI limits
collect style cell ///
        colname[i.rep78]#result[_r_lb _r_ub], sformat("%s%%") ///

collect preview
collect export myfile6e.xlsx, replace
*/
** Midline 
dtable whz waz haz if time_datacollect==0, by(midline, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Midline") ///
note("pearson test") ///
export(table6m.xlsx, replace)

/*
* get CIs for the continuous variables
by midline: collect: mean whz waz haz

* redefine composite result _r_ci to suite your style
collect composite define _r_ci = _r_lb _r_ub, trim
collect style cell result[_r_ci], sformat("[%s]")

* add _r_ci to the result autolevels
collect style autolevels result _r_ci

* change 'var' to 'colname' in the layout
collect layout (colname) (midline#result)

/* add CIs for the factor variables
by midline: collect: proportion for rep, percent
*/
* add custom string format for the factor variable percent CI limits
collect style cell ///
        colname[i.rep78]#result[_r_lb _r_ub], sformat("%s%%") ///

collect preview
collect export myfile6m.xlsx, replace 
*/
*------------------------------------------------------
* Outcome inidicators: Wasting, Stunting and underweight 
*-----------------------------------------------------
* Wasting by WHZ
** 2 categories: Wasting and no wasting (wasting= < -2 SD, no wasting >= -2 SD)

gen wast_2cat=.
replace wast_2cat= 1 if whz < -2 & whz <.
replace wast_2cat =0 if whz >= -2 & !missing(whz)
label define wast2cat1 0 "Not wasted" 1 "Wasted"
label value wast_2cat wast2cat1
label variable wast_2cat "Wasting by WHZ(2 categories)"
tab wast_2cat arm if time_datacollect==0, col
tab wast_2cat arm if time_datacollect==1, col
tab wast_2cat arm if time_datacollect==2, col
tab wast_2cat region, col

** Endline 
dtable i.wast_2cat, by(endline, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by WHZ at Endline") ///
export(tablewaste1e.xlsx, replace)


graph bar if participated2==1, over (wast_2cat) ytitle(Percent of wasting) title("Child Wasting by WHZ Category at Endline") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall

graph bar if participated2==1,over(wast_2cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of wasting) title("Child Wasting by WHZ Category and Arm at Endline") // by arm

** Midline

dtable i.wast_2cat, by(midline, nototal) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by WHZ at Midline") ///
export(tablewaste1m.xlsx, replace)


graph bar if participated1==1, over (wast_2cat) ytitle(Percent of wasting) title("Child Wasting by WHZ Category at Midline") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall

graph bar if participated1==1,over(wast_2cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of wasting) title("Child Wasting by WHZ Category and Arm at Midline") // by arm

 

** Wasting-5 categories
// Severe < -3 SD
// Moderate >= -3 to < -2 SD
// Normal >= -2 to <= +2 SD
// Overweight > +2 to <= +3 SD
// Obesity > +3 SD

gen wast_cat = .
replace wast_cat= 0 if whz >= -2 & whz <= 2   //Normal
replace wast_cat= 1 if whz >= -3 & whz < -2   // Moderate
replace wast_cat= 2 if whz < -3                 // Severe
replace wast_cat= 3 if whz > 2 & whz <= 3     //overweight
replace wast_cat= 4 if whz > 3 & !missing(whz)  // Obesity

label define wastcat 0 "Not Wasted" 1 "MAM" 2 "SAM" 3 "Overweight" 4 "Obese"
label value wast_cat wastcat
label variable wast_cat "Wasting by WHZ(5 categories)"
tab wast_cat arm, col

tab wast_cat arm if time_datacollect==0, col
tab wast_cat arm if time_datacollect==1, col
tab wast_cat arm if time_datacollect==2, col
/*
graph bar, over (wast_cat) ytitle(Percent of wasting) title("Child Wasting by WHZ Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall

graph bar,over(wast_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of wasting) title("Child Wasting by WHZ Category and Arm") // by arm
*/
** Comparing Wasting by WHZ to IPC classification 
/* The IPC Acute Food Insecurity Reference Table
<5% = None/Acceptable
5-9.9%= Alert/Stressed
10-14.9% = serious/crisis
15-29.9% = Critical/Emergency
>=30% Extremely critical/catastrophe 
*/


** Wasting by MUAC
/* MUAC cut-off points
* Severe = < 11.5cm
* Moderate = < 12.5 & >=11.5
* Normal = >= 12.5 */

** 2 categories: Wasting and no wasting (wasting= < 12.5, no wasting >= 12.5)
gen wast_2muac=. 
replace wast_2muac=1 if muac_chld <12.5
replace wast_2muac=0 if muac_chld >= 12.5 & !missing(muac_chld)
label define wast2muac 0 "Not wasted" 1 "Wasted"
label value wast_2muac wast2muac
label variable wast_2muac "Wasting by MUAC(2 categories)"
tab wast_2muac arm if time_datacollect==0, col
tab wast_2muac arm if time_datacollect==1, col
tab wast_2muac arm if time_datacollect==2, col
tab wast_2muac arm, col

** 3 categories: (normal moderate and severe)
gen wast_muac=.
replace wast_muac= 0 if muac_chld >=12.5 & !missing(muac_chld)  //Normal
replace wast_muac= 1 if muac_chld < 12.5 & muac_chld >=11.5 & !missing(muac_chld)  // Moderate
replace wast_muac= 2 if muac_chld <11.5                 // Severe
label define wastmuac 0 "Not wasted" 1 "MAM" 2 "SAM"
label variable wast_muac "Wasting by MUAC(3 categories)"
label value wast_muac wastmuac
tab wast_muac arm, col

** Comparing Wasting by MUAC to IPC classification 
/* The IPC Acute Food Insecurity Reference Table
<5% = Phase 1-2
5-9.9%= Phase 2-3
10-14.9% = Phases 3-4
>=15% = Phases 4-5

*/

/*
* 2 groups 
graph bar, over (wast_2muac) ytitle(Percent of wasting) title("Child Wasting by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall

graph bar,over(wast_2muac) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of wasting) title("Child Wasting by Category and Arm") // by arm

*3 groups
graph bar, over (wast_muac) ytitle(Percent of wasting) title("Child Wasting by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall
graph bar,over(wast_muac) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of wasting) title("Child Wasting by Category and Arm") // by arm
*/

**********
* SUMMING ALL WASTING (Wasting Criteria (WHO 2023): WHZ <-2 SD  OR MUAC <12.5cm AND/OR Nutritional Oedema)
***********

gen wast_all=.
replace wast_all=1 if wast_2cat==1 | wast_2muac==1 | oedema_chld==1
replace wast_all=0 if wast_2cat==0 & wast_2muac==0 & oedema_chld==0
tab wast_all
label def wastall 0 "Not wasted" 1 "Wasted"
label val wast_all wastall
tab wast_all arm if time_datacollect==0,col
tab wast_all arm if time_datacollect==3,col
tab wast_all arm if time_datacollect==0 &region==0,col
tab wast_all arm if time_datacollect==3 &region==1,col


* Stunting 
** 2 categories: Stunting and no stunting (stunting= < -2 SD, no stunting >= -2 SD)
gen stunt_2cat=.
replace stunt_2cat= 1 if haz < -2 
replace stunt_2cat= 0 if haz >= -2 & !missing(haz)
label define stunt2cat 0 "Not Stunted" 1 "Stunted"
label value stunt_2cat stunt2cat
label variable stunt_2cat "Stunting(2 categories)"
tab stunt_2cat arm if time_datacollect==0, col
tab stunt_2cat arm if time_datacollect==1, col
tab stunt_2cat arm if time_datacollect==2, col
tab stunt_2cat region, col

/** Stunting-3 categories
// Severe < -3 SD
// Moderate >= -3 to < -2 SD
// Normal >= -2 */

gen stunt_cat = .
replace stunt_cat= 0 if haz >= -2 & !missing(haz) //Normal
replace stunt_cat= 1 if haz < -2 & haz >= -3 & !missing(haz) // Moderate
replace stunt_cat= 2 if haz < -3    // Severe
label define stuntcat 0 "Not Stunted" 1 "Moderately Stunted" 2 "Severely Stunted"
label value stunt_cat stuntcat
label variable stunt_cat "Stunting(3 categories)"
tab stunt_cat arm, col

** Comparing Stunting by HAZ to IPC classification 
/* The IPC Acute Food Insecurity Reference Table
<20% = Acceptable/Generaly food secure
20-40%= moderatly food insecure
NDC for for Phases 3-5
*/
/*
* 2 groups
graph bar, over (stunt_2cat) ytitle(Percent of stunting) title("Child Stunting by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall
graph bar,over(stunt_2cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of stunting) title("Child Stunting by Category and Arm") // by arm

* 5 groups
graph bar, over (stunt_cat) ytitle(Percent of stunting) title("Child Stunting by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall
graph bar,over(stunt_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of stunting) title("Child Stunting by Category and Arm") // by arm
*/

* Underweight and overweight for age  
** 2 categories: Underweight for age and Normal weight for age (underweight= < -2 SD, normal weight >= -2 SD)
tab waz
count if missing(waz)

gen wt_2cat=.
replace wt_2cat=1 if waz < -2 
replace wt_2cat=0 if waz >= -2 & !missing(waz)
label define wt2cat 0 "Normal weight for age" 1 "Underweight for age"
label value wt_2cat wt2cat
label variable wt_2cat "Underweight(2 categories)"
tab wt_2cat arm if time_datacollect==0, col
tab wt_2cat arm if time_datacollect==1, col
tab wt_2cat arm if time_datacollect==2, col

** Under and Over weight for age-5 categories
// Severe underweight for age < -3 SD
// Moderate underweight for age >= -3 to < -2 SD
// Normal weight for age >= -2 to <= +2 SD
// Overweight for age > +2 to <= +3 SD
// Obesity for age > +3 SD

gen wt_cat = .
replace wt_cat= 0 if waz >= -2 & waz <= 2   //Normal
replace wt_cat= 1 if waz >= -3 & waz < -2   // Moderate underweight 
replace wt_cat= 2 if waz < -3       // Severe underweight 
replace wt_cat= 3 if waz > 2 & waz <= 3     //Overweight 
replace wt_cat= 4 if waz > 3 &!missing(waz)  // Obesity 

label define wtcat 0 "Normal wt for age" 1 "Moderate Underweight for age" 2 "Severe underweight for age" 3 "Overweight" 4 "Obesity"
label value wt_cat wtcat
label variable wt_cat "Underweight/Overweight(5 categories)"
tab wt_cat arm if time_datacollect==0, col
tab wt_cat arm if time_datacollect==1, col
tab wt_cat arm if time_datacollect==2, col

/*
* 2 groups
graph bar, over (wt_2cat) ytitle(Percent of stunting) title("Child underweight by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall
graph bar,over(wt_2cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of stunting) title("Child underweight by Category and Arm") // by arm

* 5 groups
graph bar, over (wt_cat) ytitle(Percent of stunting) title("Child Underweight by Category") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))  // overall
graph bar,over(wt_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percent of stunting) title("Child underweight by Category and Arm") // by arm
*/

** *--------------------------------------------------------------------------------------------------------
* Exploring whether outcomes at baseline of children lost to follow-up are signficantly diffrent those retained 
*---------------------------------------------------------------------------------------------------------
** AT ENDLINE
** Wasting and underweight**
dtable i.wast_2cat i.wt_2cat if time_datacollect==0, by(endline, nototal tests) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Endline") ///
export(table7e.xlsx, replace)


**By arms
dtable i.wast_2cat i.wt_2cat  if time_datacollect==0 &arm==1, by(endline, nototal tests) sample("Baseline: freq(%)") nformat(%6.1f proportions) title("Outcomes of Children at Baseline by Attrition at Endline-Arm1") ///
export(table8_arm1.xlsx, replace)

dtable i.wast_2cat i.wt_2cat  if time_datacollect==0 &arm==2, by(endline, nototal tests) sample("Baseline: freq(%)") nformat(%6.1f proportions) title("Outcomes of Children at Baseline by Attrition at Endline-Arm2") ///
export(table8_arm2.xlsx, replace)

dtable i.wast_2cat i.wt_2cat  if time_datacollect==0 &arm==3, by(endline, nototal tests) sample("Baseline: freq(%)") nformat(%6.1f proportions) title("Outcomes of Children at Baseline by Attrition at Endline-Arm3") ///
export(table8_arm3.xlsx, replace)

** By regions
dtable i.wast_2cat i.wt_2cat if time_datacollect==0 & region==0, by(endline, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline_Reatained at Endline-Bay") ///
export(table9_Bay.xlsx, replace)

dtable i.wast_2cat i.wt_2cat if time_datacollect==0 & region==1, by(endline, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline_Reatained at Endline-Hiran") ///
export(table9_Hiran.xlsx, replace)

** 95% CI
tab participated2 
proportion wast_2cat, over(participated2)
proportion wt_2cat, over(participated2)

** AT MIDLINE
** Wasting and underweight**
dtable i.wast_2cat i.wt_2cat if time_datacollect==0, by(midline, nototal tests) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("Outcomes of Children at Baseline by Attrition") ///
export(table7.xlsx, replace)


**By arms
dtable i.wast_all i.wt_2cat  if time_datacollect==0, by(arm, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline by Attrition") ///
export(table8.xlsx, replace)

dtable i.wast_all i.wt_2cat if time_datacollect==0 & midline==0, by(arm, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline by Attrition") ///
export(table9.xlsx, replace)

** By regions
dtable i.wast_all i.wt_2cat if time_datacollect==0, by(region, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline by Attrition") ///
export(table10.xlsx, replace)

dtable i.wast_all i.wt_2cat if time_datacollect==0 & midline==0, by(region, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("Outcomes of Children at Baseline by Attrition") ///
export(table11.xlsx, replace)

** 95% CI
tab midline 
proportion wast_all, over(midline)
proportion wt_2cat, over(midline)



/*
* Children who are both wasted and stunted vs only wasted children 
gen wast_stunt=.
replace wast_stunt= 0 if whz06 < -2 & whz06 <. & haz06 < -2 & haz06 <.   //wasted & stunted
replace wast_stunt= 1 if whz06 < -2 & whz06 <. & haz06 >= -2  //Only wasted
replace wast_stunt= 2 if haz06 < -2 & haz06 <. & whz06 >= -2 // Only stunted

label define waststunt 0 "Wasted & Stunted" 1 "Only wasted" 2 "Only stunted"
label value wast_stunt waststunt
label variable wast_stunt "Wasted and Stunted Children"
tab wast_stunt arm, col
*/

*------------------------------------------
*         HH Food Security             *
*------------------------------------------

* 1) Household Hunger Score (HHS)                                                                       
gen hhs_newQ1= .
replace hhs_newQ1=1 if freq_no_foodto_eat ==3
replace hhs_newQ1=2 if freq_no_foodto_eat ==2
replace hhs_newQ1=0 if freq_no_foodto_eat ==1
replace hhs_newQ1=0 if nofood_hh ==0
label variable hhs_newQ1 "hhs_newQ1"

gen hhs_newQ2= .
replace hhs_newQ2=1 if freq_sleep_hungry  ==3
replace hhs_newQ2=2 if freq_sleep_hungry  ==2
replace hhs_newQ2=0 if freq_sleep_hungry  ==1
replace hhs_newQ2=0 if sleephug  ==0
label variable hhs_newQ2 "hhs_newQ2"

gen hhs_newQ3= .
replace hhs_newQ3=1 if freq_whole_nightday_hungry  ==3
replace hhs_newQ3=2 if freq_whole_nightday_hungry  ==2
replace hhs_newQ3=0 if freq_whole_nightday_hungry ==1
replace hhs_newQ3=0 if nofood_ntday ==0
label variable hhs_newQ3 "hhs_newQ3"

label def newqnla 0 "Never" 1 "Rarely" 2 "Often"
label value hhs_newQ1 newqnla
label value hhs_newQ2 newqnla
label value hhs_newQ3 newqnla

gen hhs= .
replace hhs = hhs_newQ1 + hhs_newQ2 +hhs_newQ3
label variable hhs "HHS Score"

tabstat hhs,by (arm) statistics( n mean sd min p50 max) format(%3.2f) // HH food security //


gen hhs_cat=.
replace hhs_cat = 0 if hhs <= 1
replace hhs_cat = 1 if hhs >=2 & hhs < 4
replace hhs_cat = 2 if hhs >=4 & !missing(hhs)
label variable hhs_cat "HHS category"

label define hhscat 0 "Little to no Hunger" 1 "Moderate Hunger" 2 "Severe Hunger"
label values hhs_cat hhscat


tab  hhs arm
tab hhs arm, col
tab hhs_cat
tab hhs_cat arm, col
graph bar, over(hhs_cat) over(arm)


* Elements
/*
graph bar if time_datacollect==0, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Baseline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhs1, replace)  // overall
graph bar if time_datacollect==0, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Baseline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghhs2, replace)  // overall
graph bar if time_datacollect==0, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Baseline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhs3, replace) // overall

graph bar if time_datacollect==1, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghh1, replace)  // overall
graph bar if time_datacollect==1, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Midline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghh2, replace)  // overall
graph bar if time_datacollect==1, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Midline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghh3, replace) // overall

graph bar if time_datacollect==2, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Endline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhe1, replace)  // overall
graph bar if time_datacollect==2, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Endline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghhe2, replace)  // overall
graph bar if time_datacollect==2, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Endline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhe3, replace) // overall

graph combine ghhs1 ghhs2 ghhs3 ghh1 ghh2 ghh3, ycommon altshrink
graph combine ghhs1 ghhs2 ghhs3 ghhe1 ghhe2 ghhe3, ycommon altshrink

graph bar if time_datacollect==0,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Baseline: No food to Eat") name(ghhs4, replace) // by arm
graph bar if time_datacollect==0,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2_Baseline: Sleep Hungry") name(ghhs5, replace) // by arm
graph bar if time_datacollect==0,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3_Baseline: Whole night&day without eating") name(ghhs6, replace) // by arm

graph bar if time_datacollect==1,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat") name(ghh4, replace) // by arm
graph bar if time_datacollect==1,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2Midline: Sleep Hungry") name(ghh5, replace) // by arm
graph bar if time_datacollect==1,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3Midline: Whole night&day without eating") name(ghh6, replace) // by arm

graph bar if time_datacollect==2,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat") name(ghhe4, replace) // by arm
graph bar if time_datacollect==2,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2Midline: Sleep Hungry") name(ghhe5, replace) // by arm
graph bar if time_datacollect==2,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3Midline: Whole night&day without eating") name(ghhe6, replace) // by arm

grc1leg ghhs4 ghhs5 ghhs6 ghh4 ghh5 ghh6, legendfrom(ghhs6) ycommon altshrink
grc1leg ghhs4 ghhs5 ghhs6 ghhe4 ghhe5 ghhe6, legendfrom(ghhs6) ycommon altshrink


proportion hhs_cat if time_datacollect==0 
estimates store baseline
proportion hhs_cat if time_datacollect==1
estimates store midline
proportion hhs_cat if time_datacollect==2
estimates store endline
coefplot baseline midline endline, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(HHS categoreis) ytitle(Proportion) title(HHS categories comparing Baseline Midline and Endline)

proportion hhs_cat if time_datacollect==0, over(arm)
estimates store baseline_arm
proportion hhs_cat if time_datacollect==1, over(arm)
estimates store midline_arm
proportion hhs_cat if time_datacollect==2, over(arm)
estimates store endline_arm
coefplot baseline_arm midline_arm endline_arm, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(HHS categoreis) ytitle(Proportion) title(HHS categories comparing Baseline Midline and Endline)

*/


* 2) Food Consumption Score (FCS)
gen fcs = d_cereals*2 +d_legumes*3+ d_veg + d_fruits +d_meat_fish*4 + d_dairy*4 +  d_sugar*0.5 + d_oil*0.5
label variable fcs "FCS"

** General category (0-21: Poor; 21.5-35: Borderline; >35: Acceptable)
gen fcs_cat=.
replace fcs_cat = 0 if fcs <= 21
replace fcs_cat = 1 if fcs >=21.5 & fcs <=35
replace fcs_cat = 2 if fcs > 35 & !missing(fcs)
label variable fcs_cat "FCS category"

label define fcscat 0 "Poor" 1 "Borderline" 2 "Acceptable"
label values fcs_cat fcscat

* Alternate categorization for Somalia (used in context with high consumption of oil and sugar: (0-28: Poor; 28.5-42: Borderline; >42: Acceptable)
gen fcs_cat_alt=.
replace fcs_cat_alt = 0 if fcs <= 28
replace fcs_cat_alt = 1 if fcs >=28.5 & fcs <=42
replace fcs_cat_alt = 2 if fcs > 42 & !missing(fcs)
label variable fcs_cat_alt "FCS category_High oil&sugar Consumption"

label define fcscatalt 0 "Poor" 1 "Borderline" 2 "Acceptable"
label values fcs_cat_alt fcscatalt

tab fcs arm
summ fcs, detail
tabstat  fcs, statistics( count mean sd median ) by(arm) format(%9.1f)
hist fcs, normal
hist fcs, normal by(arm)
graph box fcs, mark(1,mlabel(fcs))
graph box fcs, over (arm) mark(1,mlabel(fcs))
tab fcs_cat
tab fcs_cat_alt
tab fcs_cat arm, col
tab fcs_cat_alt arm, col

/*
*FCS categories
graph bar if time_datacollect==0, over (fcs_cat)  bar(1,color(sand)) ytitle(Percentage of HH)  title("Percent of HH by FCS cat_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(fcs1,replace)  // overall
graph bar if time_datacollect==1, over (fcs_cat)  bar(1,color(sand)) ytitle(Percentage of HH)  title("Percent of HH by FCS cat_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(fcs2,replace)  // overall
graph bar if time_datacollect==2, over (fcs_cat)  bar(1,color(sand)) ytitle(Percentage of HH)  title("Percent of HH by FCS cat_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(fcs3,replace)  // overall

graph bar if time_datacollect==0,over(fcs_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of HH) title("Percent of HH by FCS cat & Arm_Baseline") name(fcs4, replace) // by arm
graph bar if time_datacollect==1,over(fcs_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of HH) title("Percent of HH by FCS cat & Arm_Midline") name(fcs5, replace) // by arm
graph bar if time_datacollect==2,over(fcs_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of HH) title("Percent of HH by FCS cat & Arm_Endline") name(fcs6, replace) // by arm

graph combine fcs1 fcs2 fcs3, ycommon altshrink
grc1leg fcs4 fcs5 fcs6 , legendfrom(fcs4) ycommon altshrink


proportion fcs_cat if time_datacollect==0 
estimates store base_fcs
proportion fcs_cat if time_datacollect==1
estimates store mid_fcs
proportion fcs_cat if time_datacollect==2
estimates store end_fcs
coefplot base_fcs mid_fcs end_fcs, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(FCS categoreis) ytitle(Proportion) title(FCS categories comparing Baseline Midline and Endline)

proportion fcs_cat if time_datacollect==0, over(arm)
estimates store base_fcs_arm
proportion fcs_cat if time_datacollect==1, over(arm)
estimates store mid_fcs_arm
proportion fcs_cat if time_datacollect==2, over(arm)
estimates store end_fcs_arm
coefplot base_fcs_arm mid_fcs_arm end_fcs_arm, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(FCS categoreis) ytitle(Proportion) title(FCS categories comparing Baseline Midline and Endline_By Arm) eqlabels("Arm 1" "Arm 2" "Arm 3")
*/

/*
** Mean days of consumption of diffrent food items
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0, title("Mean days of Consumption of food groups_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs1,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1, ytitle(Mean Days) title("Mean days of Consumption of food groups_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs2,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2, ytitle(Mean Days) title("Mean days of Consumption of food groups_Endline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs3,replace)scheme(mrc)  // Overall


graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Baseline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs4,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Midline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs5,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Endline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs6,replace) scheme(mrc) //by arm

grc1leg gfcs1 gfcs2 gfcs3, legendfrom(gfcs2) ycommon altshrink
grc1leg gfcs4 gfcs5 gfcs6, legendfrom(gfcs4) ycommon altshrink

*/

* 3) Reduced Coping Stratgy Index (rCSI)
gen rCSI=(d_cheap_food*1) + (d_borrow*2) + (d_reduce_portion*1) + (d_prior_child_meal*3) + (d_skip_meals*1)
lab var rCSI "Reduced Consumption Strategies Index"

summ rCSI, detail
tab rCSI arm
tabstat  rCSI, statistics( count mean sd min median max iqr) col(stat) format(%3.2f)
tabstat  rCSI, statistics(count mean sd min median max iqr) by(arm) col(stat) format(%3.2f) nototal

hist rCSI, normal
hist rCSI, normal by (arm)
graph box rCSI, over(arm) over(time_datacollect) asyvars
graph box rCSI, over(arm) over(time_datacollect) ascategory

 
* By arm
dtable rCSI if arm==1, by(time_datacollect, nototal)  title("rCSI") ///
note("ttest") ///
export(tablercis1.xlsx, replace)

dtable rCSI if arm==2, by(time_datacollect, nototal)  title("rCSI") ///
note("ttest") ///
export(tablercis2.xlsx, replace)

dtable rCSI if arm==3, by(time_datacollect, nototal)  title("rCSI") ///
note("ttest") ///
export(tablercis3.xlsx, replace)



** Mean number of days using coping mechanisms-rCSI

/*
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0, title("Mean days of using coping strategy_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi1,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1, ytitle(Mean Days) title("Mean days of using coping strategy_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi2,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2, ytitle(Mean Days) title("Mean days of using coping strategy_Endline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi3,replace)scheme(mrc)  // Overall

graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Baseline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi4,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Midline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi5,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Endline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi6,replace) scheme(mrc) //by arm

grc1leg gcsi1 gcsi2 gcsi3, legendfrom(gcsi2) ycommon altshrink
grc1leg gcsi4 gcsi5 gcsi6, legendfrom(gcsi4) ycommon altshrink
*/



** *-----------------------------------------------------------------------------------------------------------------------------------
* Exploring whether HH Food security inidcators at baseline of children lost to follow-up are signficantly diffrent from those retained 
*---------------------------------------------------------------------------------------------------------------------------------------
** AT ENDLINE
** Overall
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0, by(endline, nototal tests) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("HH Food Security at Baseline by Attrition at Endline") ///
export(table12e.xlsx, replace)

**By arms
* Arm 1
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==1, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition at Endline_Arm 1") ///
note("pearson and ttest") ///
export(table14arm1e.xlsx, replace)
* Arm 2
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==2, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition at Endline_Arm 2") ///
note("pearson and ttest") ///
export(table14arm2e.xlsx, replace)
* Arm 3
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==3, by(endline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition at Endline_Arm 3") ///
note("pearson and ttest") ///
export(table14arm3e.xlsx, replace)

** By regions
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & region==0, by(endline, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline for Retained at Endline_Bay") ///
export(table15_Bay.xlsx, replace)

dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & region==1, by(endline, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline for Retained at Endline_Hiran") ///
export(table15_Hiran.xlsx, replace)

** AT MIDLINE
** Overall
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0, by(midline, nototal tests) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("HH Food Security at Baseline by Attrition") ///
export(table12.xlsx, replace)


**By arms
* Arm 1
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==1, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition_Arm 1") ///
note("pearson and ttest") ///
export(table14arm1.xlsx, replace)
* Arm 2
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==2, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition_Arm 2") ///
note("pearson and ttest") ///
export(table14arm2.xlsx, replace)
* Arm 3
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & arm==3, by(midline, tests) sample("Overall Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition_Arm 3") ///
note("pearson and ttest") ///
export(table14arm3.xlsx, replace)

** By regions
dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0, by(region, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition") ///
export(table15.xlsx, replace)

dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0 & midline==0, by(region, tests) sample("Baseline: freq(%)") nformat(%6.1f mean proportions sd) title("HH Food Security at Baseline by Attrition") ///
export(table16.xlsx, replace)

save "R2HC_CleanAllData_v1.dta", replace 

*************************************************************************************************************************************************
**///////////////////////////////////////////////////////////////////////////////////
* Research Question 1: What is the optimum duration of cash transfers: 3 v 6 months
* Research Question 2: Compare the Outcome at the Endline for 3 study Arms. 
*            a) ITT analysis (All HHs enrolled)
*            b) Wasting prevalence 
*            c) Wasting incidence 
**//////////////////////////////////////////////////////////////////////////////////
use R2HC_CleanAllData_v1.dta, clear

** 1 a) Compare outcomes at 3 months vs 6 months using all HHs
tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)

* Distributtion by cluster and villages
outsheet arm region district village cluster if time_datacollect==0 using Studysites_Baseline.csv, comma replace

* Arm 1
* Bay
tab district if arm==1 & region==0
tab village if arm==1 & region==0 & district==0
tab cluster if arm==1 & region==0 & district==0 &village==3
tab cluster if arm==1 & region==0 & district==0 &village==4
tab cluster if arm==1 & region==0 & district==0 &village==6
tab cluster if arm==1 & region==0 & district==0 &village==8

* Hiran
tab district if arm==1 & region==1
tab village if arm==1 & region==1 & district==1
tab cluster if arm==1 & region==1 & district==1 & village==15
tab cluster if arm==1 & region==1 & district==1 & village==16

tab village if arm==1 & region==1 & district==2
tab cluster if arm==1 & region==1 & district==2 & village==22
tab cluster if arm==1 & region==1 & district==2 & village==24

tab village if arm==1 & region==1 & district==3
tab cluster if arm==1 & region==1 & district==3 & village==25
tab cluster if arm==1 & region==1 & district==3 & village==27
tab cluster if arm==1 & region==1 & district==3 & village==32

* Arm 2
* Bay
tab district if arm==2 & region==0
tab village if arm==2 & region==0 & district==0
tab cluster if arm==2 & region==0 & district==0 &village==2
tab cluster if arm==2 & region==0 & district==0 &village==10
tab cluster if arm==2 & region==0 & district==0 &village==11
tab cluster if arm==2 & region==0 & district==0 &village==12

* Hiran
tab district if arm==2 & region==1
tab village if arm==2 & region==1 & district==1
tab cluster if arm==2 & region==1 & district==1 & village==17
tab cluster if arm==2 & region==1 & district==1 & village==18

tab village if arm==2 & region==1 & district==2
tab cluster if arm==2 & region==1 & district==2 & village==21
tab cluster if arm==2 & region==1 & district==2 & village==23

tab village if arm==2 & region==1 & district==3
tab cluster if arm==2 & region==1 & district==3 & village==26
tab cluster if arm==2 & region==1 & district==3 & village==30
tab cluster if arm==2 & region==1 & district==3 & village==33

* Arm 3

* Bay
tab district if arm==3 & region==0
tab village if arm==3 & region==0 & district==0
tab cluster if arm==3 & region==0 & district==0 &village==1
tab cluster if arm==3 & region==0 & district==0 &village==5
tab cluster if arm==3 & region==0 & district==0 &village==7
tab cluster if arm==3 & region==0 & district==0 &village==9
tab cluster if arm==3 & region==0 & district==0 &village==13

* Hiran
tab district if arm==3 & region==1
tab village if arm==3 & region==1 & district==1
tab cluster if arm==3 & region==1 & district==1 & village==14
tab cluster if arm==3 & region==1 & district==1 & village==19
tab cluster if arm==3 & region==1 & district==1 & village==20

tab village if arm==3 & region==1 & district==3
tab cluster if arm==3 & region==1 & district==3 & village==28
tab cluster if arm==3 & region==1 & district==3 & village==29
tab cluster if arm==3 & region==1 & district==3 & village==31



tabstat hhid if region==0, by(village) stat(N) nototal 
tabstat hhid if region==1, by(village) stat(N) nototal 


save "R2HC_CleanAllData_v1.dta", replace 


** PREVALENCE ANALYSIS

use R2HC_CleanAllData_v1.dta, clear

** (i) Child outcomes
*-------------------
* Summarize characteristics 
*------------------ 
* Overall
dtable i.region i.district i.arm  i.displaced i.recent_disp_floods i.sex_chld age_chld, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children") ///
export(table_xtics1.xlsx, replace)

** By Arm
dtable i.region i.district i.displaced i.recent_disp_floods i.sex_chld age_chld if arm==1, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children_Arm 1") ///
export(table_xticsArm1.xlsx, replace)

dtable i.region i.district i.displaced i.recent_disp_floods i.sex_chld age_chld if arm==2, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children_Arm 2") ///
export(table_xticsArm2.xlsx, replace)

dtable i.region i.district i.displaced i.recent_disp_floods i.sex_chld age_chld if arm==3, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children_Arm 3") ///
export(table_xticsArm3.xlsx, replace)


* Anthropometric indicators 
tabstat  muac_chld, statistics( count mean sd min max) by(time_datacollect) format(%3.2f) 
    hist  muac_chld, normal color(gray)
	hist muac_chld, by(time_datacollect)
    graph box   muac_chld
	graph box   muac_chld, over (time_datacollect) 

*MUAC
/*
twoway (histogram muac_chld if time_datacollect==0, start(5.5) width(0.25) color(red%30)) ///        
       (histogram muac_chld if time_datacollect==1, start(5.5) width(0.25) color(blue%30)) ///   
       (histogram muac_chld if time_datacollect==2, start(5.5) width(0.25) color(green%30)), ///
	   legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of MUAC)
	   * By Arm
twoway (histogram muac_chld if time_datacollect==0, start(5.5) width(0.25) color(red%30)) ///        
       (histogram muac_chld if time_datacollect==1, start(5.5) width(0.25) color(blue%30)) ///   
       (histogram muac_chld if time_datacollect==2, start(5.5) width(0.25) color(green%30)), ///
	   legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of MUAC) ///
	   by (arm)
* Ht
twoway (histogram ht_chld if time_datacollect==0, start(55) width(1.75) color(red%30)) ///        
       (histogram ht_chld if time_datacollect==1, start(55) width(1.75) color(blue%30)) ///  
	   (histogram ht_chld if time_datacollect==2, start(55) width(1.75) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of Height) ///
	   by (arm)

* Wt
twoway (histogram wt_chld if time_datacollect==0, start(0) width(0.5) color(red%30)) ///        
       (histogram wt_chld if time_datacollect==1, start(0) width(0.5) color(blue%30)) ///   
	   (histogram wt_chld if time_datacollect==2, start(0) width(0.5) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of Weight) ///
	   by(arm)
* Oedema
graph bar,over(oedema_chld) over(time_datacollect) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of children) title("Presence of Oedema") name(oedema, replace)

graph bar,over(oedema_chld) over(time_datacollect) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of children) title("Presence of Oedema") name(oedema, replace)
*/
* Summary of Anthro-0verall
dtable age_chld wt_chld ht_chld  muac_chld, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements") ///
note("pearson test") ///
export(tableannthro1.xlsx, replace)	   

** By Arm
dtable age_chld wt_chld ht_chld muac_chld if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_Arm 1") ///
export(tableannthroArm1.xlsx, replace)

dtable age_chld wt_chld ht_chld muac_chld if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_Arm 2") ///
export(tableannthroArm2.xlsx, replace)

dtable age_chld wt_chld ht_chld muac_chld if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_Arm 3") ///
export(tableannthroArm3.xlsx, replace)

/*
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///  
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ)
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///  
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ_By Arm) ///
	   by(arm)
	   
twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///   
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ)
twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///   
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ_By Arm) ///
	   by(arm)

twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) /// 
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ)
twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) /// 
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ-By Arm) ///
	   by(arm)
*/	   
* Summary of Z scvores 
dtable whz waz haz, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score") ///
export(tableanthro2.xlsx, replace)
format whz waz haz %9.3f
ci mean whz waz haz if time_datacollect==0 
ci mean whz waz haz if time_datacollect==1
ci mean whz waz haz if time_datacollect==2

* By Arm
dtable whz waz haz if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 1") ///
export(tableanthro_arm1.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==1
ci mean whz waz haz if time_datacollect==1 & arm==1
ci mean whz waz haz if time_datacollect==2 & arm==1

dtable whz waz haz if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 2") ///
export(tableanthro_arm2.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==2
ci mean whz waz haz if time_datacollect==1 & arm==2
ci mean whz waz haz if time_datacollect==2 & arm==2

dtable whz waz haz if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 3") ///
export(tableanthro_arm3.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==3
ci mean whz waz haz if time_datacollect==1 & arm==3
ci mean whz waz haz if time_datacollect==2 & arm==3

* Kernal Density
kdensity whz,nograph generate(y fy) 
kdensity whz if time_datacollect==0,nograph generate(fy0) at(y) 
kdensity whz if time_datacollect==1,nograph generate(fy1) at(y)
kdensity whz if time_datacollect==2,nograph generate(fy2) at(y)
label var fy0 "Baseline" 
label var fy1 "Midline"
label var fy2 "Endline"
line fy0 fy1 fy2 y, sort ytitle(Density)
line fy0 fy1 fy2 y, sort ytitle(Density) by(arm)		   
	
* Timepoint
dtable i.wast_2cat i.wast_2muac, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by WHZ and MUAC") ///
export(tablewaste.xlsx, replace)

format wast_2cat %9.3f
format wast_2muac %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0
  ci proportions wast_2cat wast_2muac if time_datacollect==1
   ci proportions wast_2cat wast_2muac if time_datacollect==2
   

 * Wasting comparing study arms
dtable i.wast_2cat i.wast_2muac if time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Pre-baseline") ///
export(tablewast_prebas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==0 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==3

dtable i.wast_2cat i.wast_2muac if time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prev-midline") ///
export(tablewast_premid.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==3


dtable i.wast_2cat i.wast_2muac if time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prev-endline") ///
export(tablewast_preend.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if time_datacollect==2 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==3
 

* Wasting by arms
dtable i.wast_2cat i.wast_2muac if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm 1") ///
export(tablewast_arm1.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==1
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==1
   ci proportions wast_2cat  wast_2muac if time_datacollect==2 & arm==1
   
dtable i.wast_2cat i.wast_2muac if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm 2") ///
export(tablewast_arm2.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==2
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==2
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==2

dtable i.wast_2cat i.wast_2muac if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm 3") ///
export(tablewast_arm3.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==3
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==3
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==3
   
/*
quietly eststo Baseline: proportion wast_2cat if time_datacollect==0, over(arm)
quietly eststo Midline: proportion wast_2cat if time_datacollect==1, over(arm)
quietly eststo Endline: proportion wast_2cat if time_datacollect==2, over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Child Wasting by WHZ) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit)

   proportion wast_2cat if time_datacollect==0 
estimates store baseline_wast
proportion wast_2cat if time_datacollect==1
estimates store midline_wast
proportion wast_2cat if time_datacollect==2
estimates store endline_wast
coefplot baseline_wast midline_wast endline_wast, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(Wasting by WHZ) ytitle(Proportion) title(Wasting by WHZ comparing Baseline Midline and Endline)
*/
* Region
** Compare regions
dtable i.wast_2cat i.wast_2muac if time_datacollect==0, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by region_Baseline") ///
export(tablewast_regbaseline.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
ci proportions wast_2cat wast_2muac if region==0 & time_datacollect==0
 ci proportions wast_2cat wast_2muac if region==1 & time_datacollect==0
 
 dtable i.wast_2cat i.wast_2muac if time_datacollect==1, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by region_Midline") ///
export(tablewast_regmidline.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
ci proportions wast_2cat wast_2muac if region==0 & time_datacollect==1
ci proportions wast_2cat wast_2muac if region==1 & time_datacollect==1
 
 dtable i.wast_2cat i.wast_2muac if time_datacollect==2, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting by region_Endline") ///
export(tablewast_regendline.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
ci proportions wast_2cat wast_2muac if region==0 & time_datacollect==2
 ci proportions wast_2cat wast_2muac if region==1 & time_datacollect==2
  
** For each region (control for region)
 * Bay region
 *Bay overtime
 dtable i.wast_2cat i.wast_2muac if region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prev for Bay over time") ///
export(tablewastebay.xlsx, replace)

format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==0 &time_datacollect==0
 proportion wast_2cat wast_2muac if region==0 &time_datacollect==1
   proportion wast_2cat wast_2muac if region==0 &time_datacollect==2
   
 ** Bay-Comparing arms
 dtable i.wast_2cat i.wast_2muac if region==0& time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting prevBay-baseline") ///
export(tablewast_prevbaybas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if region==0& time_datacollect==0 & arm==1
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==0 & arm==2
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==0 & arm==3

dtable i.wast_2cat i.wast_2muac if region==0& time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting PrevBay-midline") ///
export(tablewast_prevbaymid.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if region==0& time_datacollect==1 & arm==1
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==1 & arm==2
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==1 & arm==3

dtable i.wast_2cat i.wast_2muac if region==0& time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting PrevBay-endline") ///
export(tablewast_prevbayend.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if region==0& time_datacollect==2 & arm==1
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==2 & arm==2
   proportion wast_2cat  wast_2muac if region==0& time_datacollect==2 & arm==3
 
 * Bay by Arm
dtable i.wast_2cat i.wast_2muac if arm==1& region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm1Bay") ///
export(tablewast_arm1bay.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==1 &region==0
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==0
   ci proportions wast_2cat  wast_2muac if time_datacollect==2 & arm==1 &region==0
   
dtable i.wast_2cat i.wast_2muac if arm==2 &region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm2Bay") ///
export(tablewast_arm2bay.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==2 &region==0
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==2 &region==0
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==2 &region==0

dtable i.wast_2cat i.wast_2muac if arm==3 &region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm3Bay") ///
export(tablewast_arm3bay.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==3 &region==0
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==3 &region==0
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==3 &region==0
  
  * Hiran Region
 *Hiran overtime
 dtable i.wast_2cat i.wast_2muac if region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prev for Hiran over time") ///
export(tablewastehiran.xlsx, replace)

format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==1 &time_datacollect==0
 proportion wast_2cat wast_2muac if region==1 &time_datacollect==1
   proportion wast_2cat wast_2muac if region==1 &time_datacollect==2
   
 ** Bay-Comparing arms
 dtable i.wast_2cat i.wast_2muac if region==1& time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting prevHiran-baseline") ///
export(tablewast_prevhiranbas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if region==1& time_datacollect==0 & arm==1
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==0 & arm==2
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==0 & arm==3

dtable i.wast_2cat i.wast_2muac if region==1& time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting PrevHiran-midline") ///
export(tablewast_prevhiranmid.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if region==1& time_datacollect==1 & arm==1
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==1 & arm==2
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==1 & arm==3

dtable i.wast_2cat i.wast_2muac if region==1& time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting PrevHiran-endline") ///
export(tablewast_prevhiranend.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if region==1& time_datacollect==2 & arm==1
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==2 & arm==2
   proportion wast_2cat  wast_2muac if region==1& time_datacollect==2 & arm==3 
  
  *Hiran-By Arm
dtable i.wast_2cat i.wast_2muac if arm==1& region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm1Hiran") ///
export(tablewast_arm1hiran.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==1 &region==1
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==1
   ci proportions wast_2cat  wast_2muac if time_datacollect==2 & arm==1 &region==1
   
dtable i.wast_2cat i.wast_2muac if arm==2 &region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm2Hiran") ///
export(tablewast_arm2hiran.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==2 &region==1
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==2 &region==1
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==2 &region==1

dtable i.wast_2cat i.wast_2muac if arm==3 &region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prevalence-Arm3Hiran") ///
export(tablewast_arm3hiran.xlsx, replace)
format wast_2cat %9.3f
ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==3 &region==1
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==3 &region==1
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==3 &region==1
   
 
 ** Controlling for recent displacement due to floods
 tab hh_recently_disp

 dtable i.wast_2cat i.wast_2muac if time_datacollect==2, by(hh_recently_disp, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Prev at Endline by recent displacement") ///
export(tablefloods.xlsx, replace)

format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==0 &time_datacollect==0
 proportion wast_2cat wast_2muac if region==0 &time_datacollect==1
   proportion wast_2cat wast_2muac if region==0 &time_datacollect==2
  
*** 
* Maternal Outcome 
*** 
summ  muac_mother, detail    
tab muac_mother
replace muac_mother=. if muac_mother==0
tab muac_mother
tabstat  muac_mother, statistics( count mean median) by(arm)
    hist  muac_mother
	hist  muac_mother, by(arm)
    graph box  muac_mother, mark(1,mlabel(muac_mother))
	graph box  muac_mother, over (arm) mark(1,mlabel(muac_mother))
	graph box  muac_mother, over (time_datacollect) mark(1,mlabel(muac_mother))

	replace muac_mother=. if muac_mother>45
	replace muac_mother=. if muac_mother<10
	
/*Note from Sydney's Analysis: to have the correct mother values, we need to drop any duplicate mother records stored under multiple children in the same household*/	
replace muac_mother=. if ychld_tag0==0 & time_datacollect==0
replace muac_mother=. if ychld_tag1==0 & time_datacollect==1
replace muac_mother=. if ychld_tag2==0 & time_datacollect==2

replace matmuac_cat=. if ychld_tag0==0 & time_datacollect==0
replace matmuac_cat=. if ychld_tag1==0 & time_datacollect==1
replace matmuac_cat=. if ychld_tag2==0 & time_datacollect==2
	
* MUAC categorization:
** Maternal malnutirion using MUAC cut-off (Tang, A.M., Chung, M., Dong, K., et al. (2016). Determining a Global MidUpper Arm Circumference Cutoff to Assess Malnutrition in Pregnant Women. FHI 360/Food Nutr Tech Assist III Proj (FANTA): Washington, DC.) 
** Storng correlation btn BMI <18.5 and MUAC <23 in most settings 
** Malnourished < 23cm
** Normal >=23 - 30 cm 
** Overweight >30cm

gen matmuac_cat= .
replace matmuac_cat=1 if muac_mother <23
replace matmuac_cat=0 if muac_mother >=23 & !missing(muac_mother)
label variable matmuac_cat "Maternal Malnutrition(MUAC)"
label def matmuac_cat 1 "Wasted" 0 "Not wasted" 
label value matmuac_cat matmuac_cat

tab matmuac_cat

* Overall
dtable muac_mother i.preg i.edu, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers") ///
export(table_mothx-tics.xlsx, replace)

** By Arm
dtable muac_mother i.preg i.edu if arm==1, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Arm 1") ///
export(table_mothxticsArm1.xlsx, replace)
dtable muac_mother i.preg i.edu if arm==2, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Arm 2") ///
export(table_mothxticsArm2.xlsx, replace)
dtable muac_mother i.preg i.edu if arm==3, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Arm 3") ///
export(table_mothxticsArm3.xlsx, replace)


twoway (histogram muac_mother if time_datacollect==0, start(0) width(1.5) color(red%30)) ///        
       (histogram muac_mother if time_datacollect==1, start(0) width(1.5) color(blue%30)) ///
	    (histogram muac_mother if time_datacollect==2, start(0) width(1.5) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of Maternal MUAC)
*Maternal wasting 
  * Overall
dtable i.matmuac_cat, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC") ///
export(tablewastmoth.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0
proportion matmuac_cat if time_datacollect==1
proportion matmuac_cat if time_datacollect==2

* Overall-comparing arms
dtable i.matmuac_cat if time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Prevalence of Maternal Wasting_Comparing Arms_Bas") ///
export(tablewastmoth_prev_bas.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 &arm==1
proportion matmuac_cat if time_datacollect==0 &arm==2
proportion matmuac_cat if time_datacollect==0 &arm==3

dtable i.matmuac_cat if time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Prevalence of Maternal Wasting_Comparing Arms_Mid") ///
export(tablewastmoth_prev_mid.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==1 &arm==1
proportion matmuac_cat if time_datacollect==1 &arm==2
proportion matmuac_cat if time_datacollect==1 &arm==3

dtable i.matmuac_cat if time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Prevalence of Maternal Wasting_Comparing Arms_End") ///
export(tablewastmoth_prev_end.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==2 &arm==1
proportion matmuac_cat if time_datacollect==2 &arm==2
proportion matmuac_cat if time_datacollect==2 &arm==3

**
tabi 552 80 \ 546 69, chi2
tabi 552 80 \ 450 76, chi2
tabi 546 69 \ 450 76, chi2

tabi 363 32 \ 370 39, chi2
tabi 363 32 \ 367 43, chi2
tabi 370 39 \ 367 43, chi2

tabi 304 50 \ 349 39, chi2
tabi 304 50 \ 337 48, chi2
tabi 349 39 \ 337 48, chi2
  
  * By Arm
dtable i.matmuac_cat if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm1") ///
export(tablewastmoth_arm1.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==1
proportion matmuac_cat if time_datacollect==1 & arm==1
proportion matmuac_cat if time_datacollect==2 & arm==1

dtable i.matmuac_cat if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm2") ///
export(tablewastmoth_arm2.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==2
proportion matmuac_cat if time_datacollect==1 & arm==2
proportion matmuac_cat if time_datacollect==2 & arm==2

dtable i.matmuac_cat if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm3") ///
export(tablewastmoth_arm3.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==3
proportion matmuac_cat if time_datacollect==1 & arm==3
proportion matmuac_cat if time_datacollect==2 & arm==3

** By region (compare regions)
dtable i.matmuac_cat if time_datacollect==0, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Baseline") ///
export(tablewastmoth_bas.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & region==0
proportion matmuac_cat if time_datacollect==0 & region==1

dtable i.matmuac_cat if time_datacollect==1, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Midline") ///
export(tablewastmoth_mid.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==1 & region==0
proportion matmuac_cat if time_datacollect==1 & region==1

dtable i.matmuac_cat if time_datacollect==2, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Endline") ///
export(tablewastmoth_end.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==2 & region==0
proportion matmuac_cat if time_datacollect==2 & region==1
/*

/////////////////////////////////////////////////////
** INCIDENCE ANALYSIS 
/////////////////////////////////////////////////////

use R2HC_CleanAllData_v1.dta, clear

* Drop wasted children at baseline 
tabstat hhid if wast_2cat==1 & time_datacollect==0, stat(N) // 284 wasted by WHZ at baseline
tabstat hhid if wast_2muac==1 & time_datacollect==0, stat(N) // 4 wasted by MUAC at baseline
drop if wast_2cat==1 & time_datacollect==0  // dropped wasted at baseline
drop if wast_2muac==1 & time_datacollect==0 // dropped wasted at baseline

save "R2HC_CleanAllData_v2inc.dta", replace 

use R2HC_CleanAllData_v2inc.dta, clear 

* Summary of Anthro-0verall
dtable age_chld wt_chld ht_chld  muac_chld, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_2") ///
note("pearson test") ///
export(tableannthro3.xlsx, replace)	   

** By Arm
dtable age_chld wt_chld ht_chld muac_chld if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_IncArm 1") ///
export(tableannthroArm1inc.xlsx, replace)

dtable age_chld wt_chld ht_chld muac_chld if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_IncArm 2") ///
export(tableannthroArm2inc.xlsx, replace)

dtable age_chld wt_chld ht_chld muac_chld if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Summary of Anthropometric measurements_IncArm 3") ///
export(tableannthroArm3inc.xlsx, replace)

/*
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///  
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ)
twoway (histogram haz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram haz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///  
	   (histogram haz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of HAZ_By Arm) ///
	   by(arm)
	   
twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///   
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ)
twoway (histogram waz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram waz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) ///   
	   (histogram waz if time_datacollect==2, start(-6.0) width(0.25) color(green%30)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WAZ_By Arm) ///
	   by(arm)

twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) /// 
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ)
twoway (histogram whz if time_datacollect==0, start(-6.0) width(0.25) color(red%30)) ///        
       (histogram whz if time_datacollect==1, start(-6.0) width(0.25) color(blue%30)) /// 
	   (histogram whz if time_datacollect==2, start(-6.0) width(0.25) color(green%40)), ///
       legend(order(1 "Baseline" 2 "Midline" 3 "Endline")) ///
	   title(Histogram of WHZ-By Arm) ///
	   by(arm)
*/	   
* Summary of Z scvores 
dtable whz waz haz, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Inc") ///
export(tableanthro4.xlsx, replace)
format whz waz haz %9.3f
ci mean whz waz haz if time_datacollect==0 
ci mean whz waz haz if time_datacollect==1
ci mean whz waz haz if time_datacollect==2

* By Arm
dtable whz waz haz if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 1Inc") ///
export(tableanthro_arm1inc.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==1
ci mean whz waz haz if time_datacollect==1 & arm==1
ci mean whz waz haz if time_datacollect==2 & arm==1

dtable whz waz haz if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 2Inc") ///
export(tableanthro_arm2inc.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==2
ci mean whz waz haz if time_datacollect==1 & arm==2
ci mean whz waz haz if time_datacollect==2 & arm==2

dtable whz waz haz if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean sd min max) column(by(hide)) title("Z-score_Arm 3Inc") ///
export(tableanthro_arm3inc.xlsx, replace)
format whz waz haz %9.2f
ci mean whz waz haz if time_datacollect==0 & arm==3
ci mean whz waz haz if time_datacollect==1 & arm==3
ci mean whz waz haz if time_datacollect==2 & arm==3

* Kernal Density
kdensity whz,nograph generate(p fp) 
kdensity whz if time_datacollect==0,nograph generate(fp0) at(p) 
kdensity whz if time_datacollect==1,nograph generate(fp1) at(p)
kdensity whz if time_datacollect==2,nograph generate(fp2) at(p)
label var fp0 "Baseline" 
label var fp1 "Midline"
label var fp2 "Endline"
line fp0 fp1 fp2 p, sort ytitle(Density)
line fp0 fp1 fp2 p, sort ytitle(Density) by(arm)		   
	
* Timepoint
dtable i.wast_2cat i.wast_2muac, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence") ///
export(tablewasteinc.xlsx, replace)

format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if time_datacollect==0
proportion wast_2cat wast_2muac if time_datacollect==1
proportion wast_2cat wast_2muac if time_datacollect==2
   
tabi 1391 195 \ 1233 202, chi2
tabi 1569 19  \ 1415 23, chi2
   
proportion wast_2cat if time_datacollect==0 
estimates store baseline_wast
proportion wast_2cat if time_datacollect==1
estimates store midline_wast
proportion wast_2cat if time_datacollect==2
estimates store endline_wast
coefplot baseline_wast midline_wast endline_wast, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(Wasting by WHZ) ytitle(Proportion) title(Wasting by WHZ comparing Baseline Midline and Endline)

* Wasting by arms
dtable i.wast_2cat i.wast_2muac if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting incidence-Arm1") ///
export(tablewast_arm1inc.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==1
  tabi 469 70 \ 407 72, chi2
  tabi 535 4  \ 475 6, chi2

dtable i.wast_2cat i.wast_2muac if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm2") ///
export(tablewast_arm2inc.xlsx, replace)
format wast_2cat %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==2
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==2
  tabi 501 50 \ 446 50, chi2
  tabi 546 6  \ 491 6, chi2

dtable i.wast_2cat i.wast_2muac if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm3") ///
export(tablewast_arm3inc.xlsx, replace)
format wast_2cat %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==3
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==3
  tabi 421 75 \ 380 80, chi2
  tabi 488 9  \ 449 11, chi2 
  
  * Wasting comparing study arms
dtable i.wast_2cat i.wast_2muac if time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting incidence-baseline") ///
export(tablewast_incbas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==0 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==3
  tabi 469 70 \ 407 72, chi2
  tabi 535 4  \ 475 6, chi2

dtable i.wast_2cat i.wast_2muac if time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-midline") ///
export(tablewast_incmid.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==3
  tabi 469 70 \ 501 50, chi2
  tabi 469 70 \ 421 75, chi2
  tabi 501 50 \ 421 75, chi2

dtable i.wast_2cat i.wast_2muac if time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-endline") ///
export(tablewast_incend.xlsx, replace)
format wast_2cat %9.3f
    proportion wast_2cat wast_2muac if time_datacollect==2 & arm==1
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==2
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==3
  tabi 421 75 \ 380 80, chi2
  tabi 488 9  \ 449 11, chi2 
/*
quietly eststo Baseline: proportion wast_2cat if time_datacollect==0, over(arm)
quietly eststo Midline: proportion wast_2cat if time_datacollect==1, over(arm)
quietly eststo Endline: proportion wast_2cat if time_datacollect==2, over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Child Wasting by WHZ) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit)

   proportion wast_2cat if time_datacollect==0 
estimates store baseline_wast
proportion wast_2cat if time_datacollect==1
estimates store midline_wast
proportion wast_2cat if time_datacollect==2
estimates store endline_wast
coefplot baseline_wast midline_wast endline_wast, vertical recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) xtitle(Wasting by WHZ) ytitle(Proportion) title(Wasting by WHZ comparing Baseline Midline and Endline)
*/
* Region
** Compare regions
dtable i.wast_2cat i.wast_2muac if time_datacollect==0, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting incidence by region_Baseline") ///
export(tablewast_regbasinc.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==0 & time_datacollect==0
proportion wast_2cat wast_2muac if region==1 & time_datacollect==0
 
 dtable i.wast_2cat i.wast_2muac if time_datacollect==1, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting incidence by region_Midline") ///
export(tablewast_regmidinc.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==0 & time_datacollect==1
proportion wast_2cat wast_2muac if region==1 & time_datacollect==1
 
 dtable i.wast_2cat i.wast_2muac if time_datacollect==2, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence by region_Endline") ///
export(tablewast_regendinc.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
proportion wast_2cat wast_2muac if region==0 & time_datacollect==2
proportion wast_2cat wast_2muac if region==1 & time_datacollect==2
  
** For each region (control for region)
 * Bay region-By Arm
dtable i.wast_2cat i.wast_2muac if arm==1& region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm1Bay") ///
export(tablewast_arm1incbay.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==0
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==1 &region==0
   tabi 175 10 \ 159 14, chi2
      tabi 185 0  \ 173 1, chi2
   
dtable i.wast_2cat i.wast_2muac if arm==2 &region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm2Bay") ///
export(tablewast_arm2incbay.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==2 &region==0
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==2 &region==0
   tabi 198 7 \ 187 13, chi2
      tabi 205 1  \ 197 3, chi2
	  
dtable i.wast_2cat i.wast_2muac if arm==3 &region==0, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm3Bay") ///
export(tablewast_arm3incbay.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==3 &region==0
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==3 &region==0
    tabi 252 11 \ 234 16, chi2
      tabi 258 5  \ 247 3, chi2

* Bay region-Comparing Arm
dtable i.wast_2cat i.wast_2muac if region==0 & time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Bay_Bas") ///
export(tablewast_incbay_bas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==0 & arm==1 &region==0
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==2 &region==0
      proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==3 &region==0
  
   
dtable i.wast_2cat i.wast_2muac if region==0 & time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Bay_Mid") ///
export(tablewast_incbay_mid.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==0
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==2 &region==0
      proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==3 &region==0
   
	  
dtable i.wast_2cat i.wast_2muac if region==0 & time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Bay_End") ///
export(tablewast_incbay_end.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==2 & arm==1 &region==0
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==2 &region==0
      proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==3 &region==0
    
 
  * Hiran Region
* Hiran region-By Arm
dtable i.wast_2cat i.wast_2muac if arm==1& region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm1Hiran") ///
export(tablewast_arm1inchiran.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==1
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==1 &region==1
   tabi 294 60 \ 248 58, chi2
      tabi 350 4\ 302 5, chi2
   
dtable i.wast_2cat i.wast_2muac if arm==2 &region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm2Hiran") ///
export(tablewast_arm2inchiran.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==2 &region==1
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==2 &region==1
   tabi 303 43 \ 259 37, chi2
      tabi 341 5\ 294 3, chi2
	  
dtable i.wast_2cat i.wast_2muac if arm==3 &region==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Arm3Hiran") ///
export(tablewast_arm3inchiran.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==3 &region==1
   proportion wast_2cat wast_2muac if time_datacollect==2 & arm==3 &region==1
    tabi 169 64 \ 146 64, chi2
      tabi 230 4\ 202 8, chi2

* Hiran region-Comparing Arm
dtable i.wast_2cat i.wast_2muac if region==1 & time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Hiran_Bas") ///
export(tablewast_inchiran_bas.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==0 & arm==1 &region==1
   proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==2 &region==1
      proportion wast_2cat  wast_2muac if time_datacollect==0 & arm==3 &region==1
  
   
dtable i.wast_2cat i.wast_2muac if region==1 & time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Hiran_Mid") ///
export(tablewast_inchiran_mid.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==1 & arm==1 &region==1
   proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==2 &region==1
      proportion wast_2cat  wast_2muac if time_datacollect==1 & arm==3 &region==1
   
	  
dtable i.wast_2cat i.wast_2muac if region==1 & time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Wasting Incidence-Hiran_End") ///
export(tablewast_inchiran_end.xlsx, replace)
format wast_2cat %9.3f
format wast_2muac %9.3f
  proportion wast_2cat wast_2muac if time_datacollect==2 & arm==1 &region==1
   proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==2 &region==1
      proportion wast_2cat  wast_2muac if time_datacollect==2 & arm==3 &region==1
  
*** 
* Maternal Outcome 
*** 

use R2HC_CleanAllData_v1.dta, clear

summ  muac_mother, detail    
tab muac_mother
replace muac_mother=. if muac_mother==0
tab muac_mother
tabstat  muac_mother, statistics( count mean median) by(arm)
    hist  muac_mother
	hist  muac_mother, by(arm)
    graph box  muac_mother, mark(1,mlabel(muac_mother))
	graph box  muac_mother, over (arm) mark(1,mlabel(muac_mother))
	graph box  muac_mother, over (time_datacollect) mark(1,mlabel(muac_mother))

	replace muac_mother=. if muac_mother>45
	replace muac_mother=. if muac_mother<10
	
* MUAC categorization:
** Maternal malnutirion using MUAC cut-off (Tang, A.M., Chung, M., Dong, K., et al. (2016). Determining a Global MidUpper Arm Circumference Cutoff to Assess Malnutrition in Pregnant Women. FHI 360/Food Nutr Tech Assist III Proj (FANTA): Washington, DC.) 
** Storng correlation btn BMI <18.5 and MUAC <23 in most settings 
** Malnourished < 23cm
** Normal >=23 - 30 cm 
** Overweight >30cm

gen matmuac_cat= .
replace matmuac_cat= 1 if muac_mother <23
replace matmuac_cat=0 if muac_mother >=23 & !missing(muac_mother)
label variable matmuac_cat "Maternal Malnutrition(MUAC)"
label def matmuac_cat 0 "Not Wasted" 1 "Wasted"
label value matmuac_cat matmuac_cat

* Drop wasted children at baseline 
tabstat hhid if matmuac_cat==1 & time_datacollect==0, stat(N) // 225 mothers wasted at baseline
drop if matmuac_cat==1 & time_datacollect==0  // dropped wasted at baseline

save "R2HC_CleanAllData_v3inc_mother.dta", replace 

use R2HC_CleanAllData_v3inc_mother.dta, clear

* Overall
dtable muac_mother i.preg i.edu, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Excluded at baseline") ///
export(table_mothx-tics_inc.xlsx, replace)
** By Arm
dtable muac_mother i.preg i.edu if arm==1, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Excluded wastedbas_Arm 1") ///
export(table_mothxticsArm1_inc.xlsx, replace)
dtable muac_mother i.preg i.edu if arm==2, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Excluded wastedbas_Arm 2") ///
export(table_mothxticsArm2_inc.xlsx, replace)
dtable muac_mother i.preg i.edu if arm==3, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mothers_Excluded wastedbas_Arm 3") ///
export(table_mothxticsArm3_inc.xlsx, replace)


*Maternal wasting 
  * Overall-over time
dtable i.matmuac_cat, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Incidence of Maternal Wasting_Over time") ///
export(tablewastmoth_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0
proportion matmuac_cat if time_datacollect==1
proportion matmuac_cat if time_datacollect==2
tabi 1100 114 \ 990 137, chi2
      
 * Overall-comparing arms
dtable i.matmuac_cat if time_datacollect==0, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Incidence of Maternal Wasting_Comparing Arms_Bas") ///
export(tablewastmoth_inc_bas.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 &arm==1
proportion matmuac_cat if time_datacollect==0 &arm==2
proportion matmuac_cat if time_datacollect==0 &arm==3

dtable i.matmuac_cat if time_datacollect==1, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Incidence of Maternal Wasting_Comparing Arms_Mid") ///
export(tablewastmoth_inc_mid.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==1 &arm==1
proportion matmuac_cat if time_datacollect==1 &arm==2
proportion matmuac_cat if time_datacollect==1 &arm==3


dtable i.matmuac_cat if time_datacollect==2, by(arm, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Incidence of Maternal Wasting_Comparing Arms_End") ///
export(tablewastmoth_inc_end.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==2 &arm==1
proportion matmuac_cat if time_datacollect==2 &arm==2
proportion matmuac_cat if time_datacollect==2 &arm==3
**

tabi 363 32 \ 370 39, chi2
tabi 363 32 \ 367 43, chi2
tabi 370 39 \ 367 43, chi2

tabi 304 50 \ 349 39, chi2
tabi 304 50 \ 337 48, chi2
tabi 349 39 \ 337 48, chi2


  
  * By Arm
dtable i.matmuac_cat if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm1_inc") ///
export(tablewastmoth_arm1_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==1
proportion matmuac_cat if time_datacollect==1 & arm==1
proportion matmuac_cat if time_datacollect==2 & arm==1
tabi 363 32 \ 304 50, chi2

dtable i.matmuac_cat if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm2_Inc") ///
export(tablewastmoth_arm2_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==2
proportion matmuac_cat if time_datacollect==1 & arm==2
proportion matmuac_cat if time_datacollect==2 & arm==2
tabi 370 39 \ 349 39 , chi2

dtable i.matmuac_cat if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by MUAC_Arm3_Inc") ///
export(tablewastmoth_arm3_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & arm==3
proportion matmuac_cat if time_datacollect==1 & arm==3
proportion matmuac_cat if time_datacollect==2 & arm==3
tabi 367 43\ 337 48 , chi2

** By region (compare regions)
dtable i.matmuac_cat if time_datacollect==0, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Baseline_Inc") ///
export(tablewastmoth_regbas_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==0 & region==0
proportion matmuac_cat if time_datacollect==0 & region==1

dtable i.matmuac_cat if time_datacollect==1, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Midline_Inc") ///
export(tablewastmoth_regmid_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==1 & region==0
proportion matmuac_cat if time_datacollect==1 & region==1

dtable i.matmuac_cat if time_datacollect==2, by(region, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Maternal Wasting by Region_Endline_Inc") ///
export(tablewastmoth_regend_inc.xlsx, replace)
format matmuac_cat %9.3f
proportion matmuac_cat if time_datacollect==2 & region==0
proportion matmuac_cat if time_datacollect==2 & region==1
*/

********************************
* DRIVERS ANALYSIS 
*
*******************************
**NOTE: Continue from Prevalence analysis 

*************
* HH Food Security inidcators 
*************
* HHS
/*
* Elements
graph bar if time_datacollect==0, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Baseline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhs1, replace)  // overall
graph bar if time_datacollect==0, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Baseline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghhs2, replace)  // overall
graph bar if time_datacollect==0, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Baseline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhs3, replace) // overall

graph bar if time_datacollect==1, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghh1, replace)  // overall
graph bar if time_datacollect==1, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Midline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghh2, replace)  // overall
graph bar if time_datacollect==1, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Midline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghh3, replace) // overall

graph bar if time_datacollect==2, over (hhs_newQ1) ytitle(Percentage of HH) title("HHS Q1_Endline: No food to Eat_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhe1, replace)  // overall
graph bar if time_datacollect==2, over (hhs_newQ2) ytitle(Percentage of HH) title("HHS Q2_Endline: Sleep Hungry_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue))name(ghhe2, replace)  // overall
graph bar if time_datacollect==2, over (hhs_newQ3) ytitle(Percentage of HH) title("HHS Q3_Endline: Whole night&day without eating_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) name(ghhe3, replace) // overall

graph combine ghhs1 ghhs2 ghhs3 ghh1 ghh2 ghh3 ghhe1 ghhe2 ghhe3, ycommon altshrink
graph combine ghhs1 ghhs2 ghhs3 ghhe1 ghhe2 ghhe3, ycommon altshrink

graph bar if time_datacollect==0,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Baseline: No food to Eat") name(ghhs4, replace) // by arm
graph bar if time_datacollect==0,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2_Baseline: Sleep Hungry") name(ghhs5, replace) // by arm
graph bar if time_datacollect==0,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3_Baseline: Whole night&day without eating") name(ghhs6, replace) // by arm

graph bar if time_datacollect==1,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat") name(ghh4, replace) // by arm
graph bar if time_datacollect==1,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2Midline: Sleep Hungry") name(ghh5, replace) // by arm
graph bar if time_datacollect==1,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3Midline: Whole night&day without eating") name(ghh6, replace) // by arm

graph bar if time_datacollect==2,over(hhs_newQ1) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue))bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q1_Midline: No food to Eat") name(ghhe4, replace) // by arm
graph bar if time_datacollect==2,over(hhs_newQ2) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q2Midline: Sleep Hungry") name(ghhe5, replace) // by arm
graph bar if time_datacollect==2,over(hhs_newQ3) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) bar(3,color(sand)) ytitle(Percentage of HH) title("HHS Q3Midline: Whole night&day without eating") name(ghhe6, replace) // by arm

grc1leg ghhs4 ghhs5 ghhs6 ghh4 ghh5 ghh6, legendfrom(ghhs6) ycommon altshrink
grc1leg ghhs4 ghhs5 ghhs6 ghhe4 ghhe5 ghhe6, legendfrom(ghhs6) ycommon altshrink


** HHS categories 
*Overall
quietly eststo Baseline: proportion hhs_cat if time_datacollect==0
quietly eststo Midline: proportion hhs_cat if time_datacollect==1
quietly eststo Endline: proportion hhs_cat if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale)

quietly eststo Baseline: proportion hhs_cat if time_datacollect==0, over(arm)
quietly eststo Midline: proportion hhs_cat if time_datacollect==1, over(arm)
quietly eststo Endline: proportion hhs_cat if time_datacollect==2, over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale by arm)

** By Region-Bay
quietly eststo Baseline: proportion hhs_cat if time_datacollect==0& region==0
quietly eststo Midline: proportion hhs_cat if time_datacollect==1& region==0
quietly eststo Endline: proportion hhs_cat if time_datacollect==2& region==0
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale for Bay)

quietly eststo Baseline: proportion hhs_cat if time_datacollect==0& region==0, over(arm)
quietly eststo Midline: proportion hhs_cat if time_datacollect==1& region==0, over(arm)
quietly eststo Endline: proportion hhs_cat if time_datacollect==2& region==0, over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale for Bay by arm)

** By Region-Hiran
quietly eststo Baseline: proportion hhs_cat if time_datacollect==0& region==1
quietly eststo Midline: proportion hhs_cat if time_datacollect==1& region==1
quietly eststo Endline: proportion hhs_cat if time_datacollect==2& region==1
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale for Hiran)

quietly eststo Baseline: proportion hhs_cat if time_datacollect==0& region==1, over(arm)
quietly eststo Midline: proportion hhs_cat if time_datacollect==1& region==1, over(arm)
quietly eststo Endline: proportion hhs_cat if time_datacollect==2& region==1, over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Hunger Scale for Hiran by arm)

* 2) Food Consumption Score (FCS)
tab fcs arm
summ fcs, detail
tabstat  fcs, statistics( count mean sd median ) by(arm) format(%9.1f)
hist fcs, normal
hist fcs, normal by(arm)
graph box fcs, mark(1,mlabel(fcs))
graph box fcs, over (arm) mark(1,mlabel(fcs))
tab fcs_cat
tab fcs_cat_alt
tab fcs_cat arm, col
tab fcs_cat_alt arm, col
** Mean days of consumption of diffrent food items
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0, title("Mean days of Consumption of food groups_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs1,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1, ytitle(Mean Days) title("Mean days of Consumption of food groups_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs2,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2, ytitle(Mean Days) title("Mean days of Consumption of food groups_Endline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs3,replace)scheme(mrc)  // Overall


graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Baseline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs4,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Midline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs5,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Endline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs6,replace) scheme(mrc) //by arm

grc1leg gfcs1 gfcs2 gfcs3, legendfrom(gfcs2) ycommon altshrink
grc1leg gfcs4 gfcs5 gfcs6, legendfrom(gfcs4) ycommon altshrink

** Mean days of consumption of diffrent food items-Bay
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0&region==0, title("Mean days of Consumption of food groups_Baseline-Bay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs7,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1&region==0, ytitle(Mean Days) title("Mean days of Consumption of food groups_Midline-Bay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs8,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2&region==0, ytitle(Mean Days) title("Mean days of Consumption of food groups_Endline-Bay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs9,replace)scheme(mrc)  // Overall


graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0&region==0, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Baseline by Arm-Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs10,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1&region==0, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Midline by Arm-Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs11,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2&region==0, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Endline by Arm-Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs12,replace) scheme(mrc) //by arm

grc1leg gfcs7 gfcs8 gfcs9, legendfrom(gfcs7) ycommon altshrink
grc1leg gfcs10 gfcs11 gfcs12, legendfrom(gfcs12) ycommon altshrink

** Mean days of consumption of diffrent food items-Hiran
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0&region==1, title("Mean days of Consumption of food groups_Baseline-Hiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs13,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1&region==1, ytitle(Mean Days) title("Mean days of Consumption of food groups_Midline-Hiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs14,replace)scheme(mrc)  // Overall
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2&region==1, ytitle(Mean Days) title("Mean days of Consumption of food groups_Endline-Hiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfcs15,replace)scheme(mrc)  // Overall


graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==0&region==1, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Baseline by Arm-Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs16,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==1&region==1, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Midline by Arm-Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs17,replace) scheme(mrc) //by arm
graph bar d_cereals d_legumes d_veg d_fruits d_meat_fish d_dairy d_sugar d_oil if time_datacollect==2&region==1, over(arm) ytitle(Mean Days) title("Mean days of Consumption of food groupsat Endline by Arm-Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gfcs18,replace) scheme(mrc) //by arm

grc1leg gfcs13 gfcs14 gfcs15, legendfrom(gfcs13) ycommon altshrink
grc1leg gfcs16 gfcs17 gfcs18, legendfrom(gfcs18) ycommon altshrink

*FCS categories (using Somalia alternative thresholds)
quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score)

quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0,over(arm)
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1,over(arm)
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score by Arm)

* FCS- Bay
quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0&region==0
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1&region==0
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2&region==0
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score for Bay)

quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0&region==0,over(arm)
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1&region==0,over(arm)
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2&region==0,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score for Bay by Arm)

* FCS- Hiran
quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0&region==1
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1&region==1
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2&region==1
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score for Hiran)

quietly eststo Baseline: proportion fcs_cat_alt if time_datacollect==0&region==1,over(arm)
quietly eststo Midline: proportion fcs_cat_alt if time_datacollect==1&region==1,over(arm)
quietly eststo Endline: proportion fcs_cat_alt if time_datacollect==2&region==1,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score for Hiran by Arm)


* 3) Reduced Coping Stratgy Index (rCSI)
summ rCSI, detail
tab rCSI arm
tabstat  rCSI, statistics( count mean sd min median max iqr) col(stat) format(%3.2f)
tabstat  rCSI, statistics(count mean sd min median max iqr) by(arm) col(stat) format(%3.2f) nototal

hist rCSI, normal
hist rCSI, normal by (arm)
graph box rCSI, over(time_datacollect) ascategory
graph box rCSI, over(arm) over(time_datacollect) asyvars
graph box rCSI, over(arm) over(time_datacollect) ascategory

* Overall
dtable rCSI, by(time_datacollect, nototal tests)  title("rCSI") ///
export(tablercis.xlsx, replace)

* By arm
dtable rCSI if arm==1, by(time_datacollect, nototal tests)  title("rCSI") ///
export(tablercis1.xlsx, replace)
dtable rCSI if arm==2, by(time_datacollect, nototal tests)  title("rCSI") ///
export(tablercis2.xlsx, replace)
dtable rCSI if arm==3, by(time_datacollect, nototal tests)  title("rCSI") ///
export(tablercis3.xlsx, replace)

tabstat hhid, by(time_datacollect) stat(N)

tabstat hhid if ychld_tag0==1 &arm==3, stat(N)
tabstat hhid if ychld_tag1==1 &arm==3, stat(N)
tabstat hhid if ychld_tag2==1 &arm==3, stat(N)

* For Bay
dtable rCSI if region==0, by(time_datacollect, nototal tests)  title("Reduced Consumption Strategies Index-Bay") ///
export(tablercisBay.xlsx, replace)

* Bay-by Arm
dtable rCSI if arm==1 & region==0, by(time_datacollect, nototal tests)  title("rCSI-Bay") ///
export(tablercis1Bay.xlsx, replace)
dtable rCSI if arm==2 & region==0, by(time_datacollect, nototal tests)  title("rCSI-Bay") ///
export(tablercis2Bay.xlsx, replace)
dtable rCSI if arm==3 & region==0, by(time_datacollect, nototal tests)  title("rCSI-Bay") ///
export(tablercis3Bay.xlsx, replace)

tabstat hhid if ychld_tag0==1 &region==0, stat(N)
tabstat hhid if ychld_tag1==1 &region==0, stat(N)
tabstat hhid if ychld_tag2==1 &region==0, stat(N)

tabstat hhid if ychld_tag0==1 &arm==1 &region==0, stat(N)
tabstat hhid if ychld_tag1==1 &arm==1 &region==0, stat(N)
tabstat hhid if ychld_tag2==1 &arm==1 &region==0, stat(N)

* For Hiran
dtable rCSI if region==1, by(time_datacollect, nototal tests)  title("Reduced Consumption Strategies Index-Hiran") ///
export(tablercisHiran.xlsx, replace)

* Bay-by Arm
dtable rCSI if arm==1 & region==1, by(time_datacollect, nototal tests)  title("rCSI-Hiran") ///
export(tablercis1Hiran.xlsx, replace)
dtable rCSI if arm==2 & region==1, by(time_datacollect, nototal tests)  title("rCSI-Hiran") ///
export(tablercis2Hiran.xlsx, replace)
dtable rCSI if arm==3 & region==1, by(time_datacollect, nototal tests)  title("rCSI-Hiran") ///
export(tablercis3Hiran.xlsx, replace)

tabstat hhid if ychld_tag0==1 &region==1, stat(N)
tabstat hhid if ychld_tag1==1 &region==1, stat(N)
tabstat hhid if ychld_tag2==1 &region==1, stat(N)

tabstat hhid if ychld_tag0==1 &arm==3 &region==1, stat(N)
tabstat hhid if ychld_tag1==1 &arm==3 &region==1, stat(N)
tabstat hhid if ychld_tag2==1 &arm==3 &region==1, stat(N)

** Mean number of days using coping mechanisms-rCSI
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0, title("Mean days of using coping strategy_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi1,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1, ytitle(Mean Days) title("Mean days of using coping strategy_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi2,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2, ytitle(Mean Days) title("Mean days of using coping strategy_Endline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi3,replace)scheme(mrc)  // Overall

graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Baseline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi4,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Midline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi5,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Endline by Arm") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi6,replace) scheme(mrc) //by arm

grc1leg gcsi1 gcsi2 gcsi3, legendfrom(gcsi2) ycommon altshrink
grc1leg gcsi4 gcsi5 gcsi6, legendfrom(gcsi4) ycommon altshrink

* By region-Bay
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0&region==0, title("Mean days of using coping strategy_BaselineBay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi7,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1&region==0, ytitle(Mean Days) title("Mean days of using coping strategy_MidlineBay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi8,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2&region==0, ytitle(Mean Days) title("Mean days of using coping strategy_EndlineBay") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi9,replace)scheme(mrc)  // Overall

graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0&region==0, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Baseline by Arm_Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi10,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1&region==0, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Midline by Arm_Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi11,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2&region==0, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Endline by Arm_Bay") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi12,replace) scheme(mrc) //by arm

grc1leg gcsi7 gcsi8 gcsi9, legendfrom(gcsi9) ycommon altshrink
grc1leg gcsi10 gcsi11 gcsi12, legendfrom(gcsi12) ycommon altshrink

* By region-Hiran
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0&region==1, title("Mean days of using coping strategy_BaselineHiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi13,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1&region==1, ytitle(Mean Days) title("Mean days of using coping strategy_MidlineHiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi14,replace)scheme(mrc)  // Overall
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2&region==1, ytitle(Mean Days) title("Mean days of using coping strategy_EndlineHiran") blabel(bar,position(outside)format(%9.1f)color(black)) name(gcsi15,replace)scheme(mrc)  // Overall

graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==0&region==1, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Baseline by Arm_Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi16,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==1&region==1, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Midline by Arm_Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi17,replace) scheme(mrc) //by arm
graph bar d_cheap_food d_borrow d_reduce_portion d_prior_child_meal d_skip_meals if time_datacollect==2&region==1, over(arm) ytitle(Mean Days) title("Mean days of using coping strategy at Endline by Arm_Hiran") blabel(bar,position(outside)format(%9.1f)color(blue)) name(gcsi18,replace) scheme(mrc) //by arm

grc1leg gcsi13 gcsi14 gcsi15, legendfrom(gcsi15) ycommon altshrink
grc1leg gcsi16 gcsi17 gcsi18, legendfrom(gcsi18) ycommon altshrink
*/

*------------------------------------------------------
*              Dietary intake              *
*------------------------------------------------------

*==== IYCF ============

*1) Breastfeeding practice for the youngest child 

* (i) Was youngest child ever b/fed?
tab bfedchild arm, col
tab bfedchild arm if time_datacollect==0, col
tab bfedchild arm if time_datacollect==1, col
tab bfedchild arm if time_datacollect==2
/*
graph bar, over (bfedchild) bar(1,color(sand)) ytitle(Percentage of HH) title("Youngest child ever b/fed_Overall") blabel(bar,position(outside) format(%9.1f)color(black))  name(ebfed1,replace)  // overall
graph bar,over(bfedchild) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of HH) title("Youngest child ever b/fed_by Arm") name(ebfed2, replace) // by arm
grc1leg ebfed1 ebfed2, legendfrom(ebfed2) ycommon altshrink


quietly eststo Poor: proportion time_datacollect if fcs_cat_alt==0
quietly eststo Borderline: proportion time_datacollect if fcs_cat_alt==1
quietly eststo Acceptable: proportion time_datacollect if fcs_cat_alt==2
coefplot Poor Borderline Acceptable, vertical xtitle(Time) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Food Consumption Score)

quietly eststo No: proportion time_datacollect if bfedchild==0 
quietly eststo Yes: proportion time_datacollect if bfedchild==1 
coefplot No Yes, vertical xtitle(Ever breatfed) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title (Ever breatfed youngest child (Only at Baseline))
*/


* (ii) When was b/feeeding initiated for the youngest child 
tab init_bfeeding_child 
tab init_bfeeding_child, nolabel
tab bf_init_chld_hr 
tab bf_init_chld_hr, nolabel
tab bf_init_chld_d
tab bf_init_chld_d, nolabel

gen init_bfding_chld_cat=.
replace init_bfding_chld_cat=0 if init_bfeeding_child ==341 
replace init_bfding_chld_cat=1 if init_bfeeding_child ==334
replace init_bfding_chld_cat=2 if init_bfeeding_child ==314 | init_bfeeding_child ==338
tab init_bfding_chld_cat

label def initcat 0 "Immediately" 1 "After Hours" 2 "After Days"
label value init_bfding_chld_cat initcat
tab init_bfding_chld_cat
tab init_bfding_chld_cat arm, col
/*
graph bar, over (init_bfding_chld_cat) bar(1,color(sand)) ytitle(Percentage of HH) title("B/feeding initiation_Overall") blabel(bar,position(outside) format(%9.1f)color(black))  name(bfi1,replace)  // overall
graph bar,over(init_bfding_chld_cat) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(Percentage of HH) title("B/feeding initiation_by Arm") name(bfi2, replace) // by arm

grc1leg bfi1 bfi2, legendfrom(bfi2) ycommon altshrink

quietly eststo By_Arm: proportion init_bfding_chld_cat if time_datacollect==3, over(arm)
coefplot Overall By_Arm, vertical xtitle(Initiation of Breastfeeding) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit)
*/
* Note: Immediadtely, in hours and in days- similar distribution 

* (iii) Exclusive breatfeedng of the youngest child
tab exclusive_breastfeeding   // none of the youngest child was exclusively b/fed for 6 months 


* 2) Minimum Dietary Diversity for Children (MDD-C).
/* 5 or more of the following food groups:
1)     Breastmilk
2)     Grains, roots and tubers (v412a = 1 or v414e = 1 or v414f = 1)
3)     Legumes and nuts (v414o = 1)
4)     Dairy products (infant formula, milk, yogurt, cheese) (v411 = 1 or v411a = 1 or v414v = 1 or v414p = 1)
5)     Flesh foods (meat, fish, poultry and liver/organ meats) (v414h = 1 or v414m = 1 or v414n = 1)
6)     Eggs (v414g = 1)
7)     Vitamin A rich fruits and vegetables (v414i = 1 or v414j = 1 or v414k = 1)
8)     Other fruits and vegetables (v414l = 1) */

tab bf_chld_yest
tab bf_chld_yest time_datacollect, col
tab bf_chld_yest if newborn==1 &time_datacollect==1 // 8 Yes for newborn at midline
tab bf_chld_yest if newborn==1 &time_datacollect==2 // 14 yes for newborn at endline
replace bf_chld_yest=. if bf_chld_yest==1 & newborn==1 &time_datacollect==1
replace bf_chld_yest=. if bf_chld_yest==1 & newborn==1 &time_datacollect==2
gen bf_mid= bf_chld_yest==1 & time_datacollect==1 & !missing(bf_chld_yest) 
gen bf_end= bf_chld_yest==1 & time_datacollect==2 & !missing(bf_chld_yest) 
tab bf_mid
tab bf_end
tab bf_chld_yest if bf_mid==1 & bf_end==1
list hhid id_child if bf_chld_yest==1 & time_datacollect==2

gen breastmk = bf_chld_yest
tab breastmk time_datacollect, col
label variable breastmk "Ate breatmilk yest"
tab breastmk time_datacollect, col

gen grains_rts_tuber=1 if yest_chld_porr==1| yest_chld_grain==1| yest_chld_pumk==1| yest_chld_tubers==1
replace grains_rts_tuber=0 if yest_chld_porr==0 & yest_chld_grain==0 & yest_chld_pumk==0 & yest_chld_tubers==0
label variable grains_rts_tuber "Ate grains&tubers yest"

gen legumes_nuts=1 if yest_chld_leg==1| yest_chld_nuts==1
replace legumes_nuts=0 if yest_chld_leg==0& yest_chld_nuts==0
label variable legumes_nuts "Ate leg&nuts yest"

gen dairy_products=1 if yest_chld_formu==1| yest_chld_tinmk==1| yest_chld_yog==1| yest_chld_mkprod==1
replace dairy_products=0 if yest_chld_formu==0 & yest_chld_tinmk==0 & yest_chld_yog==0 & yest_chld_mkprod==0
label variable dairy_products "Ate dairy prod yest"

gen flesh_foods=1 if yest_chld_live==1| yest_chld_dommt==1| yest_chld_wildliv==1| yest_chld_wilfles==1| yest_chld_fish==1
replace flesh_foods=0 if yest_chld_live==0 & yest_chld_dommt==0 & yest_chld_wildliv==0 & yest_chld_wilfles==0 & yest_chld_fish==0
label variable flesh_foods "Ate flesh_foods yest"

gen eggs=1 if yest_chld_egg==1
replace eggs=0 if yest_chld_egg==0
label variable eggs "Ate eggs yesterday"

gen vitArich=1 if yest_chld_darkveg==1| yest_chld_vitafru==1| yest_chld_juice==1| yest_chld_palmoil==1
replace vitArich=0 if yest_chld_darkveg==0 & yest_chld_vitafru==0 & yest_chld_juice==0 & yest_chld_palmoil==0
label variable vitArich "Ate VitA-richfoods yest"

gen other_fruit_veg=1 if yest_chld_othveg==1| yest_chld_othfru==1
replace other_fruit_veg=0 if yest_chld_othveg==0 & yest_chld_othfru==0
label variable other_fruit_veg "Ate other_fruits/veg yest"

gen mdd5_c= breastmk + grains_rts_tuber + legumes_nuts + dairy_products + flesh_foods + eggs + vitArich + other_fruit_veg
label variable mdd5_c "Total MDD-C Score"
tab mdd5_c
tab mdd5_c if time_datacollect==0

gen mdd_c =1 if mdd5_c >=5 & !missing(mdd5_c)
replace mdd_c =0 if mdd5_c <5
label define mdd 0 "Do Not Meet Dietary Diversity" 1 "Meet Dietary Diversity"
label value mdd_c mdd
label variable mdd_c "MDD-C"

tab mdd_c arm, col
tab mdd_c time_datacollect, col

** Animal-sourced proteins 

tab dairy_products if time_datacollect==0
tab flesh_foods if time_datacollect==0
tab eggs if time_datacollect==0

tab mdd_c arm if time_datacollect==0, col
gen mdd_animalprotein=.
replace mdd_animalprotein=1 if dairy_products==1 |flesh_foods==1|eggs==1
replace mdd_animalprotein=0 if dairy_products==0 &flesh_foods==0 & eggs==0 & !missing(dairy_products) &!missing(flesh_foods) & !missing(eggs)
label variable mdd_animalprotein "Animal-Sourced proteins"
tab mdd_animalprotein arm if time_datacollect==0, col

/*
	   ** Graph with 95% CI
quietly eststo Baseline: proportion mdd_c if time_datacollect==0
quietly eststo Midline: proportion mdd_c if time_datacollect==1
quietly eststo Endline: proportion mdd_c if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MDD-C)

quietly eststo Baseline: proportion mdd_c if time_datacollect==0,over(arm)
quietly eststo Midline: proportion mdd_c if time_datacollect==1,over(arm)
quietly eststo Endline: proportion mdd_c if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MDD-C by Arm)

xtreg mdd5_c i.arm i.time_datacollect, fe
xttest3       // p-value <0.05 (heteroskadacity problem)
xtreg mdd5_c i.arm i.time_datacollect, vce(robust) fe
coefplot, xline(0) mlabel format(%9.2g) mlabposition(12) mlabgap(*2) coeflabel(, wrap(20)) drop(_cons)
*/
dtable i.mdd_c, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("MDD-C response rate") ///
export(tablemdd.xlsx, replace)

tabstat mdd_c if ychld_tag0==1, stat(N)
tabstat mdd_c if ychld_tag1==1, stat(N)
tabstat mdd_c if ychld_tag2==1, stat(N)

** Components of MDD-C
gen breastmlk= breastmk*100 
gen grt= grains_rts_tuber*100 
gen legnuts = legumes_nuts*100 
gen diar_prod= dairy_products*100 
gen flesh_meat= flesh_foods*100 
gen eggz= eggs*100 
gen fruits_vita= vitArich*100 
gen fruits_other= other_fruit_veg*100 
/*
graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==0, ytitle(Percentage HH) title("Consumption of Food Group_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg1,replace)scheme(mrc)  
graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==1, ytitle(Percentage HH) title("Consumption of Food Group_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg2,replace)scheme(mrc) 
graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==2, ytitle(Percentage HH) title("Consumption of Food Group_Endline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg3,replace)scheme(mrc) 

grc1leg gfg1 gfg2 gfg3, legendfrom(gfg2) ycommon altshrink

graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==0, over(arm) ytitle(Percentage HH) title("Consumption of Food Group_Baseline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg4,replace)scheme(mrc) 
graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==1, over(arm) ytitle(Percentage HH) title("Consumption of Food Group_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg5,replace)scheme(mrc)  
graph bar breastmlk grt legnuts diar_prod flesh_meat eggz fruits_vita fruits_other if time_datacollect==2, over(arm) ytitle(Percentage HH) title("Consumption of Food Group_Midline") blabel(bar,position(outside)format(%9.1f)color(black)) name(gfg6,replace)scheme(mrc) 

grc1leg gfg4 gfg5 gfg6, legendfrom(gfg6) ycommon altshrink
*/
* 3) Minimum Meal Frequency (MMF)
/*
a)      For breastfed children, receiving solid or semi-solid food
•        at least twice a day for infants 6-8 months (m4 = 95 & b19 in 6:8 & m39 in 2:7) or
•        at least three times a day for children 9-23 months (m4 = 95 & b19 in 9:23 & m39 in 3:7)
b)     For non-breastfed children age 6-23 months, receiving solid or semi-solid food or milk feeds at least ///
four times a day (m4 ≠ 95 & total milk feeds (see Numerator 1) plus solid feeds (m39 – if in 1:7) >= 4) ///
where at least one of the feeds must be a solid, semi-solid, or soft feed (m39 in 1:7) */

tab yest_chld_ate_solfd_fq
replace yest_chld_ate_solfd_fq=7 if yest_chld_ate_solfd_fq>7 & !missing(yest_chld_ate_solfd_fq)

gen mmf_bf=1 if bf_chld_yest==1 & inrange(age_chld,6,8) & inrange(yest_chld_ate_solfd_fq,2,7)
replace mmf_bf=0 if bf_chld_yest==1 & inrange(age_chld,6,8) & inrange(yest_chld_ate_solfd_fq,0,1)
replace mmf_bf=1 if bf_chld_yest==1 & inrange(age_chld,9,23) & inrange(yest_chld_ate_solfd_fq,3,7)
replace mmf_bf=0 if bf_chld_yest==1 & inrange(age_chld,9,23) & inrange(yest_chld_ate_solfd_fq,0,2)
lab var mmf_bf "Minimum meal frequency breasfed"

recode yest_chld_ate_solfd_fq (8=.), gen(solid_feeds)
egen nonbf_s_ss_mf=rowtotal(yest_chld_tmk_freq solid_feeds)

gen mmf_nbf=0
replace mmf_nbf=. if bf_chld_yest==1 | nonbf_s_ss_mf==. | yest_chld_ate_solfd_fq==.
replace mmf_nbf=1 if bf_chld_yest!=1 & nonbf_s_ss_mf>=4 & inrange(bf_chld_yest,1,7)
lab var mmf_nbf "Minimum meal frequency non-breasfed"

gen mmf=1 if mmf_bf==1 | mmf_nbf==1
replace mmf=0 if mmf_bf==0 | mmf_nbf==0
lab var mmf "Minimum meal frequency"
label define mmfd 0 "Do Not meet MMF" 1 "Meet MMF"
label value mmf mmfd 
tab mmf arm, col
tab mmf time_datacollect, col

/*

	   ** Graph with 95% CI
quietly eststo Midline: proportion mmf if time_datacollect==1
quietly eststo Endline: proportion mmf if time_datacollect==2
coefplot Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MMF)

quietly eststo Midline: proportion mmf if time_datacollect==1,over(arm)
quietly eststo Endline: proportion mmf if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MMF by Arm)	   
*/
* 4) Minimum Acceptable Diet (MAD)

** (For breastfed infants, if MDD and MFF are both achieved then MAD is achieved. For non-breast infants, if MDD, MMF, and MMFF are all achieved, then MAD is achieved. )

gen mad_bf= 1 if bf_chld_yest==1 & mdd_c==1 & mmf_bf==1
replace mad_bf=0 if bf_chld_yest==0 | mdd_c==0 | mmf_bf==0
label variable mad_bf "MAD breastfed"

* For non breatfed children 
gen mdd_nbf_foodgp= grains_rts_tuber + legumes_nuts + flesh_foods + eggs + vitArich  + other_fruit_veg
gen mdd_nbf_4foodgp= 1 if mdd_nbf>=4 & !missing(mdd_nbf_foodgp)
replace mdd_nbf_4foodgp=0 if mdd_nbf_foodgp<4
tab mdd_nbf_4foodgp

gen diaryprod_num = yest_chld_formu+yest_chld_tinmk+yest_chld_yog+yest_chld_mkprod
tab diaryprod_num

gen mad_nbf = 1 if mdd_nbf_4foodgp==1 & mmf_nbf==1 & diaryprod_num>=2
replace mad_nbf = 0 if mdd_nbf_4foodgp==0 | mmf_nbf==0 | diaryprod_num<2
tab mad_nbf
label variable mad_nbf "MAD non-breastfed"

gen mad=1 if mad_bf==1 |mad_nbf==1
replace mad=0 if mad_bf==0 & mad_nbf==0
lab var mad "Minimum Acceptable Meal"
label define madl 0 "Do Not meet MAD" 1 "Meet MAD"
label value mad madl 
tab mad arm, col
/*
	   ** Graph with 95% CI
	   
quietly eststo Midline: proportion mad if time_datacollect==1
quietly eststo Endline: proportion mad if time_datacollect==2
coefplot Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MAD)

quietly eststo Midline: proportion mad if time_datacollect==1,over(arm)
quietly eststo Endline: proportion mad if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(MAD by Arm)
*/
*------------------------------------------------------
*              DISEASES             *
*------------------------------------------------------

*1) Childhood illness 
* Had diarrhoea in the last 2 weeks 
tab chid_ill2wks_dia arm, col

* Had fever in the last 2 weeks 
tab  chid_ill2wks_fev  arm, col

* Had cough in the last 2 weeks
tab chid_ill2wks_cou arm, col

** Childhood illnesses- atleat 1 illness
 gen illness_last2wks = 0 if chid_ill2wks_dia==0 & chid_ill2wks_fev==0 & chid_ill2wks_cou==0 
 replace illness_last2wks = 1 if chid_ill2wks_dia==1| chid_ill2wks_fev==1| chid_ill2wks_cou==1
 tab illness_last2wks arm, col
label value illness_last2wks yesno
/*
 * Atleast any one of the three
	   ** Graph with 95% CI
quietly eststo Baseline: proportion illness_last2wks if time_datacollect==0
quietly eststo Midline: proportion illness_last2wks if time_datacollect==1
quietly eststo Endline: proportion illness_last2wks if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Child experienced any common childhood illness in last two weeks)
	   
quietly eststo Baseline: proportion illness_last2wks if time_datacollect==0,over(arm)
quietly eststo Midline: proportion illness_last2wks if time_datacollect==1,over(arm)
quietly eststo Endline: proportion illness_last2wks if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(percent) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Child experienced any common childhood illness in last two weeks by Arm)
*/
dtable i.illness_last2wks, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Childhood illness response rate") ///
export(tableillnessyesno.xlsx, replace)

/*
* individual disease
graph bar if time_datacollect==0, over (chid_ill2wks_dia) bar(1,color(sand)) ytitle(% of Youngest Children) title("Diarrhea_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill1,replace)  // overall
graph bar if time_datacollect==0, over (chid_ill2wks_fev) bar(1,color(sand)) ytitle(% of Youngest Children) title("Fever_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill2,replace)  // overall
graph bar if time_datacollect==0, over (chid_ill2wks_cou) bar(1,color(sand)) ytitle(% of Youngest Children) title("Cough_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill3,replace)  // overall
graph bar if time_datacollect==1, over (chid_ill2wks_dia) bar(1,color(sand)) ytitle(% of Youngest Children) title("Diarrhea_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill4,replace)  // overall
graph bar if time_datacollect==1, over (chid_ill2wks_fev) bar(1,color(sand)) ytitle(% of Youngest Children) title("Fever_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill5,replace)  // overall
graph bar if time_datacollect==1, over (chid_ill2wks_cou) bar(1,color(sand)) ytitle(% of Youngest Children) title("Cough_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill6,replace)  // overall
graph bar if time_datacollect==2, over (chid_ill2wks_dia) bar(1,color(sand)) ytitle(% of Youngest Children) title("Diarrhea_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill7,replace)  // overall
graph bar if time_datacollect==2, over (chid_ill2wks_fev) bar(1,color(sand)) ytitle(% of Youngest Children) title("Fever_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill8,replace)  // overall
graph bar if time_datacollect==2, over (chid_ill2wks_cou) bar(1,color(sand)) ytitle(% of Youngest Children) title("Cough_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(ill9,replace)  // overall
graph combine ill1 ill2 ill3 ill4 ill5 ill6 ill7 ill8 ill9, ycommon altshrink


graph bar if time_datacollect==0,over(chid_ill2wks_dia) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Diarrhea by Arm_Baseline") name(ill10, replace) // by arm
graph bar if time_datacollect==0,over(chid_ill2wks_fev) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Fever by Arm_Baseline") name(ill11, replace) // by arm
graph bar if time_datacollect==0,over(chid_ill2wks_cou) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Cough by Arm_Baseline") name(ill12, replace) // by arm

graph bar if time_datacollect==1,over(chid_ill2wks_dia) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Diarrhea by Arm_Midline") name(ill13, replace) // by arm
graph bar if time_datacollect==1,over(chid_ill2wks_fev) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Fever by Arm_Midline") name(ill14, replace) // by arm
graph bar if time_datacollect==1,over(chid_ill2wks_cou) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Cough by Arm_Midline") name(ill15, replace) // by arm

graph bar if time_datacollect==2,over(chid_ill2wks_dia) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Diarrhea by Arm_Endline") name(ill16, replace) // by arm
graph bar if time_datacollect==2,over(chid_ill2wks_fev) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Fever by Arm_Endline") name(ill17, replace) // by arm
graph bar if time_datacollect==2,over(chid_ill2wks_cou) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) bar(3,color(emerald)) ytitle(% of Youngest Children) title("Cough by Arm_Endline") name(ill18, replace) // by arm

grc1leg ill10 ill11 ill12 ill13 ill14 ill15 ill16 ill17 ill18, legendfrom(ill18) ycommon altshrink
*/
* 2) Wasting screening & Referral for treatment- mother and child                   
* Screened 
tab malnut_screening_last3mths if time_datacollect==0
tab malnut_screening_last3mths if time_datacollect==0, nolabel
tab malnut_screening_last3mths if time_datacollect==1
tab malnut_screening_last3mths if time_datacollect==1, nolabel
tab malnut_screening_last3mths if time_datacollect==2
tab malnut_screening_last3mths if time_datacollect==2, nolabel

tab malnut_screening_last3mths	time_datacollect, col
* Referred for treatment folowing manut screening 
tab malnu_trt_last3mths if time_datacollect==0
tab malnu_trt_last3mths if time_datacollect==0, nolabel
tab malnu_trt_last3mths if time_datacollect==1
tab malnu_trt_last3mths if time_datacollect==1, nolabel
tab malnu_trt_last3mths if time_datacollect==2
tab malnu_trt_last3mths if time_datacollect==2, nolabel

tab malnu_trt_last3mths	time_datacollect, col
/*
** Malnut screening 
quietly eststo Baseline: proportion malnut_screening_last3mths if time_datacollect==0
quietly eststo Midline: proportion malnut_screening_last3mths if time_datacollect==1
quietly eststo Endline: proportion malnut_screening_last3mths if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Malnutrition Screening)

quietly eststo Baseline: proportion malnut_screening_last3mths if time_datacollect==0,over(arm)
quietly eststo Midline: proportion malnut_screening_last3mths if time_datacollect==1,over(arm)
quietly eststo Endline: proportion malnut_screening_last3mths if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Malnutrition Screening by Arm)
tabstat malnut_screening_last3mths if ychld_tag0==1, stat(N)
tabstat malnut_screening_last3mths if ychld_tag1==1, stat(N)
tabstat malnut_screening_last3mths if ychld_tag2==1, stat(N)

* Malnut trt
quietly eststo Baseline: proportion malnu_trt_last3mths if time_datacollect==0
quietly eststo Midline: proportion malnu_trt_last3mths if time_datacollect==1
quietly eststo Endline: proportion malnu_trt_last3mths if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Malnutrition Treatment)

quietly eststo Baseline: proportion malnu_trt_last3mths if time_datacollect==0,over(arm)
quietly eststo Midline: proportion malnu_trt_last3mths if time_datacollect==1,over(arm)
quietly eststo Endline: proportion malnu_trt_last3mths if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent of Household) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Malnutrition Treatment by Arm)

tabstat malnu_trt_last3mths if ychld_tag0==1, stat(N)
tabstat malnu_trt_last3mths if ychld_tag1==1, stat(N)
tabstat malnu_trt_last3mths if ychld_tag2==1, stat(N)

** Malnut trt_item_csb
quietly eststo Baseline: proportion malnu_trt_last3mth if time_datacollect==0
quietly eststo Midline: proportion malnu_trt_last3mth if time_datacollect==1
quietly eststo Midline: proportion malnu_trt_last3mth if time_datacollect==2
coefplot Baseline Midline, vertical xtitle(Referred for Trt) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit)
*/
* 3) Child currenly enrolled in a wasting program (data only colected during midline)
tab child1_current_inwasting_prog if time_datacollect==1
tab child1_current_inwasting_prog if time_datacollect==1,nolabel
tab child1_current_inwasting_prog if time_datacollect==2
replace child1_current_inwasting_prog=0 if child1_current_inwasting_prog==1341
replace child1_current_inwasting_prog=1 if child1_current_inwasting_prog==1362
replace child1_current_inwasting_prog=1 if child1_current_inwasting_prog==1666
replace child1_current_inwasting_prog=1 if child1_current_inwasting_prog==1667
rename child1_current_inwasting_prog chld_inwasting_prog
tab chld_inwasting_prog
/*
quietly eststo Midline: proportion chld_inwasting_prog if time_datacollect==1
quietly eststo Endline: proportion chld_inwasting_prog if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Child in Wasting Program at Data collection)

quietly eststo Midline: proportion chld_inwasting_prog if time_datacollect==1,over(arm)
quietly eststo Endline: proportion chld_inwasting_prog if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Time) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Child in Wasting Program at Data collection by Arm)
*/

*------------------------------------------------------
*         Healthcare and Feedng practices            *
*------------------------------------------------------
* 2) Births -for mother who had a birth btn baseline and midline 
** Place of Birth **
tab newborn_deliv_place if time_datacollect==0
tab newborn_deliv_place if time_datacollect==0,nolabel
tab newborn_deliv_place if time_datacollect==1
tab newborn_deliv_place if time_datacollect==1,nolabel
tab newborn_deliv_place if time_datacollect==2
tab newborn_deliv_place if time_datacollect==2,nolabel
tab newborn_deliv_place, nolabel
tab newborn_deliv_place arm,  col
     
replace newborn_deliv_place=. if newborn_deliv_place==29
recode newborn_deliv_place (1=0 "Home") (499=0 "Home") (261=0 "Home")(14/16=1 "Public Facility") (24=1 "Public Facility") (32=1 "Public Facility") (1251/1253=1 "Public Facility") (2525=1 "Public Facility") (483/484=1 "Public Facility") (1021=1 "Public Facility")(33=2 "Private Facility") (2549=2 "Private Facility")(1023=2 "Private Facility"), generate(birth_place)
drop newborn_deliv_place
tab birth_place
tab birth_place arm, col
/*
quietly eststo Baseline: proportion birth_place if time_datacollect==0
quietly eststo Midline: proportion birth_place if time_datacollect==1
quietly eststo Endline: proportion birth_place if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Facility type) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Place of last Birth)

quietly eststo Baseline: proportion birth_place if time_datacollect==0,over(arm)
quietly eststo Midline: proportion birth_place if time_datacollect==1,over(arm)
quietly eststo Endline: proportion birth_place if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Facility type) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Place of last Birth by Arm)
*/
dtable i.birth_place, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Place of birth response rate") ///
export(tablebirthplace.xlsx, replace)
tabstat birth_place if ychld_tag0==1, stat(N)
tabstat birth_place if ychld_tag1==1, stat(N)
tabstat birth_place if ychld_tag2==1, stat(N)

*Birth attendance 
replace newborn_birth_assist=. if newborn_birth_assist==29
replace newborn_birth_assist=. if newborn_birth_assist==29
tab newborn_birth_assist if time_datacollect==0
tab newborn_birth_assist if time_datacollect==0,nolabel
tab newborn_birth_assist if time_datacollect==1
tab newborn_birth_assist if time_datacollect==1,nolabel
tab newborn_birth_assist if time_datacollect==2
tab newborn_birth_assist if time_datacollect==2,nolabel

recode newborn_birth_assist (4=0 "Non-SBA") (35=0 "Non-SBA") (827=0 "Non-SBA") (3082=0 "Non-SBA") (373=0 "Non-SBA") (1255=0 "Non-SBA") (12=1 "SBA") (25=1 "SBA")(28=1 "SBA") (933=1 "SBA") (2024=1 "SBA") (394=1 "SBA") (796=1 "SBA") (1004=1 "SBA"), generate(sba)
label variable sba "Skilled birth attendance"
tab sba time_datacollect,  col



/* Note
* Place of delivery_ 
* Arm 1 has a lower SBA rate
*/

gen home_birth_attend =.
replace home_birth_attend=0 if birth_place==0 & sba==0
replace home_birth_attend=1 if birth_place==0 & sba==1
label variable home_birth_attend "Birth Attendant for Home Birth"
label def homebirth 0 "Home birth by Non-SBA" 1 "Home birth by SBA"
label value home_birth_attend homebirth

tab home_birth_attend arm, col

gen facility_birth_attend =.
replace facility_birth_attend=0 if birth_place==1 & sba==0
replace facility_birth_attend=1 if birth_place==1 & sba==1
label variable home_birth_attend "Birth Attendant for Facility Birth"
label def facbirth 0 "Facility birth by Non-SBA" 1 "Facility birth by SBA"
label value facility_birth_attend facbirth
tab facility_birth_attend time_datacollect,col
/*
quietly eststo Baseline: proportion sba if time_datacollect==0
quietly eststo Midline: proportion sba if time_datacollect==1
quietly eststo Endline: proportion sba if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Birth attendant) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Birth Attendant for the last birth)

quietly eststo Baseline: proportion sba if time_datacollect==0,over(arm)
quietly eststo Midline: proportion sba if time_datacollect==1,over(arm)
quietly eststo Endline: proportion sba if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Birth attendant) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Birth Attendant for the last birth by Arm)
*/

dtable i.sba, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Birth Attendant response rate") ///
export(tablesba.xlsx, replace)
tabstat sba if ychld_tag0==1, stat(N)
tabstat sba if ychld_tag1==1, stat(N)
tabstat sba if ychld_tag2==1, stat(N)

* 3) C/S
tab newborn_cs if time_datacollect==0
tab newborn_cs if time_datacollect==0,nolabel
tab newborn_cs if time_datacollect==1
tab newborn_cs if time_datacollect==1,nolabel
tab newborn_cs if time_datacollect==2
tab newborn_cs if time_datacollect==2,nolabel

replace newborn_cs=0 if newborn_cs==2413
replace newborn_cs=1 if newborn_cs==3268
/*
quietly eststo Baseline: proportion newborn_cs if time_datacollect==0
quietly eststo Midline: proportion newborn_cs if time_datacollect==1
quietly eststo Endline: proportion newborn_cs if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(C/S) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Caesarean Birth)

quietly eststo Baseline: proportion newborn_cs if time_datacollect==0,over(arm)
quietly eststo Midline: proportion newborn_cs if time_datacollect==1,over(arm)
quietly eststo Endline: proportion newborn_cs if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(C/S) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Caesarean Birth by Arm)
tabstat newborn_cs if ychld_tag0==1, stat(N)
tabstat newborn_cs if ychld_tag1==1, stat(N)
tabstat newborn_cs if ychld_tag2==1, stat(N)
*/
* 4) Vaccination of the Younest Child
tab vacc_yesno time_datacollect, col
/*
* Atleast one vaccine
quietly eststo Baseline: proportion vacc_yesno if time_datacollect==0
quietly eststo Midline: proportion vacc_yesno if time_datacollect==1
quietly eststo Endline: proportion vacc_yesno if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Vaccination) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Received atleast one vaccine)

quietly eststo Baseline: proportion vacc_yesno if time_datacollect==0,over(arm)
quietly eststo Midline: proportion vacc_yesno if time_datacollect==1,over(arm)
quietly eststo Endline: proportion vacc_yesno if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Vaccination) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Received atleast one vaccine by Arm)
*/
dtable i.vacc_yesno, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Chilhood vaccination response rate") ///
export(tablevaccyesno.xlsx, replace)
tabstat vacc_yesno if ychld_tag0==1, stat(N)
tabstat vacc_yesno if ychld_tag1==1, stat(N)
tabstat vacc_yesno if ychld_tag2==1, stat(N)

 * Individual vaccines 
tab vacc_tb  arm,  col //BCG 
tab vacc_pol arm,  col //OPV 
tab vacc_pent arm,  col  //PENTA  
tab vacc_meas arm,  col  // Measles

tab vacc_pent_freq arm,  col   //Number of Penta vaccination received
tab vacc_pent_freq,nolabel
replace  vacc_pent_freq=2 if vacc_pent_freq==20
tab vacc_pent_freq arm,  col 
tab vacc_meas_freq arm,  col                      // Number of Measles vaccination received 
/*
graph bar if time_datacollect==0, over (vacc_tb) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("BCG_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g17,replace)  // overall
graph bar if time_datacollect==0, over (vacc_pol) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("OPV_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g18,replace)  // overall
graph bar if time_datacollect==0, over (vacc_pent) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("PENTA_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g19,replace)  // overall
graph bar if time_datacollect==0, over (vacc_meas) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("Measles_Baseline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g20,replace)  // overall

graph bar if time_datacollect==1, over (vacc_tb) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("BCG_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g21,replace)  // overall
graph bar if time_datacollect==1, over (vacc_pol) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("OPV_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g22,replace)  // overall
graph bar if time_datacollect==1, over (vacc_pent) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("PENTA_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g23,replace)  // overall
graph bar if time_datacollect==1, over (vacc_meas) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("Measles_Midline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g24,replace)  // overall

graph bar if time_datacollect==2, over (vacc_tb) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("BCG_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g25,replace)  // overall
graph bar if time_datacollect==2, over (vacc_pol) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("OPV_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g26,replace)  // overall
graph bar if time_datacollect==2, over (vacc_pent) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("PENTA_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g27,replace)  // overall
graph bar if time_datacollect==2, over (vacc_meas) bar(1,color(sand)) ytitle(Percentage of youngest chilren) title("Measles_Endline") blabel(bar,position(outside) format(%9.1f)color(black))  name(g28,replace)  // overall

graph combine g17 g18 g19 g20 g21 g22 g23 g24 g25 g26 g27 g28, ycommon altshrink

graph bar,over(vacc_tb) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand))bar(3,color(olive_teal))  ytitle(Percentage of youngest chilren) title("BCG by Arm") name(g17, replace) // by arm
graph bar,over(vacc_pol) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) ytitle(Percentage of youngest chilren) title("OPV by Arm") name(g18, replace) // by arm
graph bar,over(vacc_pent) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) ytitle(Percentage of youngest chilren) title("PENTA by Arm") name(g19, replace) // by arm
graph bar,over(vacc_meas) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(sienna)) bar(2,color(sand)) ytitle(Percentage of youngest chilren) title("Measles by Arm") name(g20, replace) // by arm

grc1leg g17 g18 g19 g20, legendfrom(g20) ycommon altshrink
*/

** Number of youngest children who received all 4 antigens irrepective of when they completed 
gen four_vacc_child= 1 if vacc_tb==1 & vacc_pol==1 & vacc_pent==1 & vacc_meas==1
replace four_vacc_child=0 if vacc_tb==0 | vacc_pol==0 | vacc_pent==0 | vacc_meas==0
label value four_vacc_child yesno
label variable four_vacc_child "U5 Children who received all 4 vaccines"

tab four_vacc_child
tab four_vacc_child time_datacollect, col
/*
quietly eststo Baseline: proportion four_vacc_child if time_datacollect==0
quietly eststo Midline: proportion four_vacc_child if time_datacollect==1
quietly eststo Endline: proportion four_vacc_child if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Vaccination) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Received atleast all four vaccines)
*/
* SBCC - For All Arms

* 7) Maternal knowledge, awareness and practices around health and IYCF
* (i) Initiation of b/feeding 
tab init_bfeeding_know if time_datacollect==1
tab init_bfeeding_know if time_datacollect==1, nolabel
tab init_bfeeding_know if time_datacollect==2
tab init_bfeeding_know if time_datacollect==2, nolabel
replace init_bfeeding_know=. if init_bfeeding_know==338
replace init_bfeeding_know=. if init_bfeeding_know==316
recode init_bfeeding_know (341=0 "Within 1hr") (318=0 "Within 1hr")(334=1 "Late Initiation") (314=1 "Late Initiation")(300=1 "Late Initiation") (315=1 "Late Initiation"), generate(init_bfding_know)
drop init_bfeeding_know
tab init_bfding_know time_datacollect, col

tab init_bfeeding_pract
tab init_bfeeding_pract if time_datacollect==1
tab init_bfeeding_pract if time_datacollect==1, nolabel
tab init_bfeeding_pract if time_datacollect==2
tab init_bfeeding_pract if time_datacollect==2, nolabel
replace init_bfeeding_pract=. if init_bfeeding_pract==1559
replace init_bfeeding_pract=. if init_bfeeding_pract==858

recode init_bfeeding_pract (1612=0 "Within 1hr")(884=0 "Within 1hr") (876=1 "Late Initiation") (1547=1 "Late Initiation") (609=1 "Late Initiation") (851=1 "Late Initiation"), generate(init_bfding_pract)
drop init_bfeeding_pract
tab init_bfding_pract arm, col
/*
quietly eststo Midline_Know: proportion init_bfding_know if time_datacollect==1
quietly eststo Midline_Pract: proportion init_bfding_pract if time_datacollect==1
quietly eststo Endline_Know: proportion init_bfding_know if time_datacollect==2
quietly eststo Endline_Pract: proportion init_bfding_pract if time_datacollect==2
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(B/feeding initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Breatfeeding Initiation_Knowledge and Practice)

quietly eststo Midline_Know: proportion init_bfding_know if time_datacollect==1,over(arm)
quietly eststo Midline_Pract: proportion init_bfding_pract if time_datacollect==1,over(arm)
quietly eststo Endline_Know: proportion init_bfding_know if time_datacollect==2,over(arm)
quietly eststo Endline_Pract: proportion init_bfding_pract if time_datacollect==2,over(arm)
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(B/feeding initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Breatfeeding Initiation_Knowledge and Practice by Arm)
*/

* (ii) Exclusive breastfeeding 
gen ex_bfeeding =.
replace ex_bfeeding=1 if exc_bfd_kno_bmk==1 & exc_bfd_kno_anmlk==0 & exc_bfd_kno_formk==0 & exc_bfd_kno_porr==0 & exc_bfd_kno_sou==0 & exc_bfd_kno_tea==0& exc_bfd_kno_wat==0& exc_bfd_kno_fru==0& exc_bfd_kno_veg==0& exc_bfd_kno_me==0& exc_bfd_kno_oth==0
replace ex_bfeeding=0 if exc_bfd_kno_anmlk==1 | exc_bfd_kno_formk==1 | exc_bfd_kno_porr==1 | exc_bfd_kno_sou==1 | exc_bfd_kno_tea==1 | exc_bfd_kno_wat==1 | exc_bfd_kno_fru==1 | exc_bfd_kno_veg==1 | exc_bfd_kno_me==1 | exc_bfd_kno_oth==1
tab ex_bfeeding
label value ex_bfeeding yesno

gen ex_bfeeding_prac=.
replace ex_bfeeding_prac=1 if exc_bfd_pract_bm==1 & exc_bfd_pract_am==0& exc_bfd_pract_form==0& exc_bfd_pract_porr==0& exc_bfd_pract_sou==0& exc_bfd_pract_tea==0& exc_bfd_pract_wat==0& exc_bfd_pract_fru==0& exc_bfd_pract_veg==0& exc_bfd_pract_meat==0& exc_bfd_pract_oth==0
replace ex_bfeeding_prac=0 if exc_bfd_pract_am==1 | exc_bfd_pract_form==1 | exc_bfd_pract_porr==1 | exc_bfd_pract_sou==1 | exc_bfd_pract_tea==1 | exc_bfd_pract_wat==1 | exc_bfd_pract_fru==1 | exc_bfd_pract_veg==1 | exc_bfd_pract_meat==1 | exc_bfd_pract_oth==1
label value ex_bfeeding_prac yesno
/*
quietly eststo Midline_Know: proportion ex_bfeeding if time_datacollect==1
quietly eststo Midline_Pract: proportion ex_bfeeding_prac if time_datacollect==1
quietly eststo Endline_Know: proportion ex_bfeeding if time_datacollect==2
quietly eststo Endline_Pract: proportion ex_bfeeding_prac if time_datacollect==2
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Exclusive B/feeding) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Exclusive Breatfeeding_Knowledge and Practice)

quietly eststo Midline_Know: proportion ex_bfeeding if time_datacollect==1,over(arm)
quietly eststo Midline_Pract: proportion ex_bfeeding_prac if time_datacollect==1,over(arm)
quietly eststo Endline_Know: proportion ex_bfeeding if time_datacollect==2,over(arm)
quietly eststo Endline_Pract: proportion ex_bfeeding_prac if time_datacollect==2,over(arm)
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Exclusive B/feeding) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Exclusive Breatfeeding_Knowledge and Practice by Arm)

graph bar exc_bfd_kno_bmk exc_bfd_kno_anmlk exc_bfd_kno_formk exc_bfd_kno_porr exc_bfd_kno_sou exc_bfd_kno_tea exc_bfd_kno_wat exc_bfd_kno_fru exc_bfd_kno_veg exc_bfd_kno_me exc_bfd_kno_oth, ytitle(Percentage of HHs) title("Excl_b/feeding_Know_Overall") blabel(bar,position(outside)format(%9.2f)color(black)) name(ebf1,replace)scheme(mrc)  // Overall
graph bar exc_bfd_kno_bmk exc_bfd_kno_anmlk exc_bfd_kno_formk exc_bfd_kno_porr exc_bfd_kno_sou exc_bfd_kno_tea exc_bfd_kno_wat exc_bfd_kno_fru exc_bfd_kno_veg exc_bfd_kno_me exc_bfd_kno_oth, over(arm) ytitle(Percentage of HHs) title("Excl_b/feeding_Know_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(ebf2,replace) scheme(mrc) //by arm

graph bar exc_bfd_pract_bm exc_bfd_pract_am exc_bfd_pract_form exc_bfd_pract_porr exc_bfd_pract_sou exc_bfd_pract_tea exc_bfd_pract_wat exc_bfd_pract_fru exc_bfd_pract_veg exc_bfd_pract_meat exc_bfd_pract_oth, ytitle(Percentage of HHs) title("Excl_b/feeding_Pract_Overall") blabel(bar,position(outside)format(%9.2f)color(black)) name(ebf3,replace)scheme(mrc)  // Overall
graph bar exc_bfd_pract_bm exc_bfd_pract_am exc_bfd_pract_form exc_bfd_pract_porr exc_bfd_pract_sou exc_bfd_pract_tea exc_bfd_pract_wat exc_bfd_pract_fru exc_bfd_pract_veg exc_bfd_pract_meat exc_bfd_pract_oth, over(arm) ytitle(Percentage of HHs) title("Excl_b/feeding_Pract_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(ebf4,replace) scheme(mrc) //by arm

grc1leg ebf1 ebf2, legendfrom(ebf2) ycommon altshrink
grc1leg ebf3 ebf4, legendfrom(ebf4) ycommon altshrink
*/
* (iii) Age for liquid food initiation 
 tab age_init_liq_kno
gen age_init_liq_know = 0 if age_init_liq_kno <6 
replace age_init_liq_know = 1 if age_init_liq_kno >=6 & age_init_liq_kno <=8
replace age_init_liq_know = 2 if age_init_liq_kno >8 
label variable age_init_liq_know "Age of liquid food init_Know"
label def corrwrong 0 "<6mths" 1 "Optimal(6-8mths)" 2 ">8mths"
label value age_init_liq_know  corrwrong
drop age_init_liq_kno
tab age_init_liq_know arm, col
replace age_init_liq_know=. if time_datacollect==0
tab age_init_liq_know time_datacollect, col

tab age_init_liq_pract
gen age_init_liq_prac = 0 if age_init_liq_pract <6 
replace age_init_liq_prac = 1 if age_init_liq_pract >=6 & age_init_liq_pract <=8
replace age_init_liq_prac = 2 if age_init_liq_pract >8 
label variable age_init_liq_prac "Age of liquid food init_Pract"
label def corrwrong2 0 "<6mths" 1 "Optimal(6-8mths)" 2 ">8mths"
label value age_init_liq_prac  corrwrong2
drop age_init_liq_pract
tab age_init_liq_prac arm, col
replace age_init_liq_prac=. if time_datacollect==0
tab age_init_liq_prac time_datacollect, col
/*
quietly eststo Midline_Know: proportion age_init_liq_know if time_datacollect==1
quietly eststo Midline_Pract: proportion age_init_liq_prac if time_datacollect==1
quietly eststo Endline_Know: proportion age_init_liq_know if time_datacollect==2
quietly eststo Endline_Pract: proportion age_init_liq_prac if time_datacollect==2
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Liq food initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Initiation of liquid foods Knowledge and Practice)


quietly eststo Midline_Know: proportion age_init_liq_know if time_datacollect==1,over(arm)
quietly eststo Midline_Pract: proportion age_init_liq_prac if time_datacollect==1,over(arm)
quietly eststo Endline_Know: proportion age_init_liq_know if time_datacollect==2,over(arm)
quietly eststo Endline_Pract: proportion age_init_liq_prac if time_datacollect==2,over(arm)
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Liq food initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Initiation of liquid foods Knowledge and Practice by Arm)
*/

* (iv) Age for solid food initiation 
tab age_init_sol_know
gen age_init_sol_knowge = 0 if age_init_sol_know <6 
replace age_init_sol_knowge = 1 if age_init_sol_know >=6 & age_init_sol_know <=8
replace age_init_sol_knowge = 2 if age_init_sol_know >8 
label variable age_init_sol_knowge "Age of solid food init_Know"
label def corrwrong3 0 "<6mths" 1 "Optimal(6-8mths)" 2 ">8mths"
label value age_init_sol_knowge  corrwrong3
drop age_init_sol_know
replace age_init_sol_knowge=. if time_datacollect==0
tab age_init_sol_knowge arm, col

tab age_init_sol_pract
gen age_init_sol_prac = 0 if  age_init_sol_pract <6 
replace age_init_sol_prac = 1 if age_init_sol_pract >=6 & age_init_sol_pract <=8
replace age_init_sol_prac = 2 if age_init_sol_pract >8 
label variable age_init_sol_prac "Age of solid food init_Pract"
label def corrwrong4 0 "<6mths" 1 "Optimal(6-8mths)" 2 ">8mths"
label value age_init_sol_prac  corrwrong4
drop age_init_sol_pract
replace age_init_sol_prac=. if time_datacollect==0
tab age_init_sol_prac arm, col

/*
quietly eststo Midline_Know: proportion age_init_sol_knowge if time_datacollect==1
quietly eststo Midline_Pract: proportion age_init_sol_prac if time_datacollect==1
quietly eststo Endline_Know: proportion age_init_sol_knowge if time_datacollect==2
quietly eststo Endline_Pract: proportion age_init_sol_prac if time_datacollect==2
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Solid food initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Initiation of solid foods Knowledge and Practice)

quietly eststo Midline_Know: proportion age_init_sol_knowge if time_datacollect==1,over(arm)
quietly eststo Midline_Pract: proportion age_init_sol_prac if time_datacollect==1,over(arm)
quietly eststo Endline_Know: proportion age_init_sol_knowge if time_datacollect==2,over(arm)
quietly eststo Endline_Pract: proportion age_init_sol_prac if time_datacollect==2,over(arm)
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Solid food initiation) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Initiation of solid foods Knowledge and Practice by Arm)
*/ 
 
* (v) Water treatment before drinking/consumption 
gen wt_trtknow=.
replace wt_trtknow=1 if wattrt_kno_boil==1 | wattrt_kno_chlo==1 | wattrt_kno_sun==1 | wattrt_kno_fil==1| wattrt_kno_aqua==1 | wattrt_kno_oth==1
replace wt_trtknow=0 if wattrt_kno_boil==0 & wattrt_kno_chlo==0 & wattrt_kno_sun==0 & wattrt_kno_fil==0 & wattrt_kno_aqua==0 & wattrt_kno_oth==0
label value wt_trtknow yesno
tab wt_trtknow time_datacollect
tab wt_trtknow time_datacollect,nolabel

gen wat_trtpract=.
replace wat_trtpract=1 if wattrt_prac_bo==1 | wattrt_prac_chlo==1 | wattrt_prac_sun==1 | wattrt_prac_filt==1| wattrt_prac_aqua==1| wattrt_prac_oth==1
replace wat_trtpract=0 if wattrt_prac_bo==0 & wattrt_prac_chlo==0 & wattrt_prac_sun==0 & wattrt_prac_filt==0 & wattrt_prac_aqua==0 & wattrt_prac_oth==0
label value wat_trtpract yesno
tab wat_trtpract time_datacollect
tab wat_trtpract time_datacollect,nolabel
/*
quietly eststo Midline_Know: proportion wt_trtknow if time_datacollect==1
quietly eststo Midline_Pract: proportion wat_trtpract if time_datacollect==1
quietly eststo Endline_Know: proportion wt_trtknow if time_datacollect==2
quietly eststo Endline_Pract: proportion wat_trtpract if time_datacollect==2
coefplot Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Water treatment) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Drinking water treatment Knowledge and Practice)
*/
dtable i.wt_trtknow, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Water Trt response rate") ///
export(tablewater trt.xlsx, replace)
tabstat wt_trtknow if ychld_tag0==1, stat(N)
tabstat wt_trtknow if ychld_tag1==1, stat(N)
tabstat wt_trtknow if ychld_tag2==1, stat(N)

/*
graph bar wattrt_kno_boil wattrt_kno_chlo wattrt_kno_sun wattrt_kno_fil wattrt_kno_aqua wattrt_kno_oth if time_datacollect==1, ytitle(Percentage of HHs) title("Water treatment_Knowdge_Midline") blabel(bar,position(outside)format(%9.2f)color(black)) name(wt1,replace)scheme(mrc)  // Overall
graph bar wattrt_kno_boil wattrt_kno_chlo wattrt_kno_sun wattrt_kno_fil wattrt_kno_aqua wattrt_kno_oth if time_datacollect==2, ytitle(Percentage of HHs) title("Water treatment_Knowdge_Endline") blabel(bar,position(outside)format(%9.2f)color(black)) name(wt2,replace)scheme(mrc)  // Overall

graph bar wattrt_kno_boil wattrt_kno_chlo wattrt_kno_sun wattrt_kno_fil wattrt_kno_aqua wattrt_kno_oth if time_datacollect==1, over(arm) ytitle(Percentage of HHs) title("Water treatment_Knowdge By Arm_Midline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(wt3,replace) scheme(mrc) //by arm
graph bar wattrt_kno_boil wattrt_kno_chlo wattrt_kno_sun wattrt_kno_fil wattrt_kno_aqua wattrt_kno_oth if time_datacollect==2, over(arm) ytitle(Percentage of HHs) title("Water treatment_Knowdge By Arm_Endline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(wt4,replace) scheme(mrc) //by arm

graph bar wattrt_prac_bo wattrt_prac_chlo wattrt_prac_sun wattrt_prac_filt wattrt_prac_aqua wattrt_prac_oth if time_datacollect==1, ytitle(Percentage of HHs) title("Water treatment_Pract_Midline") blabel(bar,position(outside)format(%9.2f)color(black)) name(wt5,replace)scheme(mrc)  // Overall
graph bar wattrt_prac_bo wattrt_prac_chlo wattrt_prac_sun wattrt_prac_filt wattrt_prac_aqua wattrt_prac_oth if time_datacollect==2, ytitle(Percentage of HHs) title("Water treatment_Pract_Endline") blabel(bar,position(outside)format(%9.2f)color(black)) name(wt6,replace)scheme(mrc)  // Overall

graph bar wattrt_prac_bo wattrt_prac_chlo wattrt_prac_sun wattrt_prac_filt wattrt_prac_aqua wattrt_prac_oth if time_datacollect==1, over(arm) ytitle(Percentage of HHs) title("Water treatment_Pract_By Arm_Midline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(wt7,replace) scheme(sb pastel) //by arm
graph bar wattrt_prac_bo wattrt_prac_chlo wattrt_prac_sun wattrt_prac_filt wattrt_prac_aqua wattrt_prac_oth if time_datacollect==2, over(arm) ytitle(Percentage of HHs) title("Water treatment_Pract_By Arm_Endline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(wt8,replace) scheme(sb pastel) //by arm

grc1leg wt1 wt2 wt5 wt6, legendfrom(wt6) ycommon altshrink
grc1leg wt3 wt4 wt7 wt8, legendfrom(wt8) ycommon altshrink
*/
 
 
* (Vi) Handwashing
gen hwashknow=.
replace hwashknow=1 if hw_mt_know_fprep==1 | hw_mt_know_eat==1| hw_mt_kno_fedchd==1| hw_mt_kno_chdstol==1| hw_mt_kno_lat==1
replace hwashknow=0 if hw_mt_know_fprep==0 & hw_mt_know_eat==0 & hw_mt_kno_fedchd==0& hw_mt_kno_chdstol==0& hw_mt_kno_lat==0
label values hwashknow yesno
tab hwashknow

gen hwashpract=.
replace hwashpract=1 if hwash_pract_fdprep==1 | hwash_pract_eat==1 | hwash_pract_fdchil==1 | hwash_pract_chdstool==1 | hwash_pract_lat==1
replace hwashpract=0 if hwash_pract_fdprep==0 & hwash_pract_eat==0 & hwash_pract_fdchil==0 & hwash_pract_chdstool==0 & hwash_pract_lat==0
label values hwashpract yesno

/*
quietly eststo Baseline_Know: proportion hwashknow if time_datacollect==0
quietly eststo Baseline_Pract: proportion hwashpract if time_datacollect==0
quietly eststo Midline_Know: proportion hwashknow if time_datacollect==1
quietly eststo Midline_Pract: proportion hwashpract if time_datacollect==1
quietly eststo Endline_Know: proportion hwashknow if time_datacollect==2
quietly eststo Endline_Pract: proportion hwashpract if time_datacollect==2
coefplot Baseline_Know Baseline_Pract Midline_Know Midline_Pract Endline_Know Endline_Pract, vertical xtitle(Handwashing) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Handwashing Knowledge and Practice)
*/
tabstat hwashknow if ychld_tag0==1, stat(N)
tabstat hwashknow if ychld_tag1==1, stat(N)
tabstat hwashknow if ychld_tag2==1, stat(N)

/*
graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==0, ytitle(Percentage of HHs) title("H/washing_Know_Baseline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw7,replace) scheme(mrc) //Overall
graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==1, ytitle(Percentage of HHs) title("H/washing_Know_Midline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw8,replace) scheme(mrc) //Overall
graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==2, ytitle(Percentage of HHs) title("H/washing_Know_Endline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw9,replace) scheme(mrc) //Overal

graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==0, ytitle(Percentage of HHs) title("H/washing Practices Baseline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw10,replace) scheme(mrc) //Overall
graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==1, ytitle(Percentage of HHs) title("H/washing Practices Midline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw11,replace) scheme(mrc) //Overall
graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==2,  ytitle(Percentage of HHs) title("H/washing Practices Endline") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw12,replace) scheme(mrc) //Overall

grc1leg hw7 hw8 hw9 hw10 hw11 hw12, legendfrom(hw12) ycommon altshrink

graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==0, over(arm) ytitle(Percentage of HHs) title("H/washing_Know_Baseline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw1,replace) scheme(mrc) //by arm
graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==1, over(arm) ytitle(Percentage of HHs) title("H/washing_Know_Midline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw2,replace) scheme(mrc) //by arm
graph bar hw_mt_know_fprep hw_mt_know_eat hw_mt_kno_fedchd hw_mt_kno_chdstol hw_mt_kno_lat if time_datacollect==2, over(arm) ytitle(Percentage of HHs) title("H/washing_Know_Endline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw3,replace) scheme(mrc) //by arm

graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==0, over(arm) ytitle(Percentage of HHs) title("H/washing Practices Baseline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw4,replace) scheme(mrc) //by arm
graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==1, over(arm) ytitle(Percentage of HHs) title("H/washing Practices Midline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw5,replace) scheme(mrc) //by arm
graph bar hwash_pract_fdprep hwash_pract_eat hwash_pract_fdchil hwash_pract_chdstool hwash_pract_lat if time_datacollect==2, over(arm) ytitle(Percentage of HHs) title("H/washing Practices Endline_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(hw6,replace) scheme(mrc) //by arm

grc1leg hw1 hw2 hw3 hw4 hw5 hw6, legendfrom(hw6) ycommon altshrink
 */
/* Note: 
* For liquid & solid foods initiation: Categorized 6-8 months answers and correct, otherwise wrong 
*/


** SBCC for Arm 3 only**
*Awareness if M2M support groups
tab m2m if arm==2
/*
quietly eststo Midline: proportion m2m if time_datacollect==1& arm==2
quietly eststo Endline: proportion m2m if time_datacollect==2& arm==2
coefplot Midline Endline , vertical xtitle(Presence of M2M groups) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Presence of M2M support group in the Area)
*/
** Attendance of M2M support group
tab m2m_attd if arm==2
/*
quietly eststo Midline: proportion m2m_attd if time_datacollect==1& arm==2
quietly eststo Endline: proportion m2m_attd if time_datacollect==2& arm==2
coefplot Midline Endline , vertical xtitle(M2M attendance) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Attended at least one M2M group sessions)
*/
* Usefulness of the messages 
tab m2m_changed_bfeeding if arm==2
tab m2m_changed_bfeeding if time_datacollect==1
tab m2m_changed_bfeeding if time_datacollect==1,nolabel
tab m2m_changed_bfeeding if time_datacollect==2
tab m2m_changed_bfeeding if time_datacollect==2,nolabel

replace m2m_changed_bfeeding=. if m2m_changed_bfeeding==387
recode m2m_changed_bfeeding (452=1 "Strongly Disagree") (379=1 "Strongly Disagree")(320=2 "Disagree") (306=2 "Disagree") ///
(56=3 "Agree")(38=3 "Agree")(451=4 "Strongly Agree")(378=4 "Strongly Agree"), generate(m2m_bfeding_changed)
drop m2m_changed_bfeeding
rename m2m_bfeding_changed m2m_changed_bfeeding
tab m2m_changed_bfeeding
/*
quietly eststo Midline: proportion m2m_changed_bfeeding if time_datacollect==1& arm==2
quietly eststo Endline: proportion m2m_changed_bfeeding if time_datacollect==2& arm==2
coefplot Midline Endline , vertical xtitle(Perception) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Perception of usefulness of M2M messages)
*/

** Sharing of information from M2M support groups
tab m2m_share if arm==2
/*
quietly eststo Midline: proportion m2m_share if time_datacollect==1& arm==2
quietly eststo Endline: proportion m2m_share if time_datacollect==2& arm==2
coefplot Midline Endline , vertical xtitle(Sharing messages) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Open to sharing messages from M2M session with neighbours)
*/
*------------------------------------------
*         HH charaterisitcs            *
*------------------------------------------

* 1) HH income /expenditure  
egen exp_monthly_total = rowtotal(exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month) /*generate total HH exp */
label variable exp_monthly_total "Total HH monthly exp"
format %9.2f exp_monthly_total
                                                                         
summ exp_monthly_total, detail    
tab exp_monthly_total
tabstat exp_monthly_total, statistics(count median  sd min max ) by(arm)  // Arm 3 has a higher median expenditure //
    hist exp_monthly_total
	hist exp_monthly_total, by(arm)
    graph box exp_monthly_total
	graph box exp_monthly_total, over (arm) mark(1,mlabel(exp_monthly_total))
	
	* logarithmic scale transformation 
	generate ln_exp_monthly_total = ln(exp_monthly_total) /*use the natura log of monthly income*/
   label variable ln_exp_monthly_total "Log(Total Expenditure)"
   hist ln_exp_monthly_total
    graph box ln_exp_monthly_total, over (arm) mark(1,mlabel(exp_monthly_total))

	replace exp_monthly_total = . if exp_monthly_total >500  // 25 obs changed to missing 
	replace exp_monthly_total=. if exp_monthly_total <=0
	
	

dtable if arm==1, by(time_datacollect, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures") ///
	export(table1exparm1.xlsx, replace) 
	
dtable if arm==2, by(time_datacollect, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50) ///
	export(table1exparm2.xlsx, replace) 
	
	dtable if arm==3, by(time_datacollect, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50) ///
	export(table1exparm3.xlsx, replace) 

ci mean exp_monthly_total if time_datacollect==0 &arm==1
ci mean exp_monthly_total if time_datacollect==0 &arm==2
ci mean exp_monthly_total if time_datacollect==0 &arm==3
ci mean exp_monthly_total if time_datacollect==1 &arm==1
ci mean exp_monthly_total if time_datacollect==1 &arm==2
ci mean exp_monthly_total if time_datacollect==1 &arm==3
ci mean exp_monthly_total if time_datacollect==2 &arm==1
ci mean exp_monthly_total if time_datacollect==2 &arm==2
ci mean exp_monthly_total if time_datacollect==2 &arm==3

** Comparing arms
dtable if time_datacollect==0, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expBase.xlsx, replace) 
	
	dtable if time_datacollect==1, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expMid.xlsx, replace)
	
	dtable if time_datacollect==2, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expEnd.xlsx, replace) 
	
ci mean exp_monthly_total if arm==1 &time_datacollect==0
ci mean exp_monthly_total if arm==1 &time_datacollect==1
ci mean exp_monthly_total if arm==1 &time_datacollect==2

ci mean exp_monthly_total if arm==2 &time_datacollect==0
ci mean exp_monthly_total if arm==2 &time_datacollect==1
ci mean exp_monthly_total if arm==2 &time_datacollect==2

ci mean exp_monthly_total if arm==3 &time_datacollect==0
ci mean exp_monthly_total if arm==3 &time_datacollect==1
ci mean exp_monthly_total if arm==3 &time_datacollect==2		

	* For Bay-Comparing Arm
dtable if time_datacollect==0 &region==0, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expBase_bay.xlsx, replace) 
	
	dtable if time_datacollect==1&region==0, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expMid_bay.xlsx, replace)
	
	dtable if time_datacollect==2&region==0, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expEnd_bay.xlsx, replace) 
	
ci mean exp_monthly_total if arm==1 &time_datacollect==0&region==0
ci mean exp_monthly_total if arm==1 &time_datacollect==1&region==0
ci mean exp_monthly_total if arm==1 &time_datacollect==2&region==0

ci mean exp_monthly_total if arm==2 &time_datacollect==0&region==0
ci mean exp_monthly_total if arm==2 &time_datacollect==1&region==0
ci mean exp_monthly_total if arm==2 &time_datacollect==2&region==0

ci mean exp_monthly_total if arm==3 &time_datacollect==0&region==0
ci mean exp_monthly_total if arm==3 &time_datacollect==1&region==0
ci mean exp_monthly_total if arm==3 &time_datacollect==2&region==0
	
	* For Bay-Comparing Arm
dtable if time_datacollect==0 &region==1, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expBase_hiran.xlsx, replace) 
	
	dtable if time_datacollect==1&region==1, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expMid_hiran.xlsx, replace)
	
	dtable if time_datacollect==2&region==1, by(arm, tests testnotes nototal) /// 
sample("Sample N(%)") ///
 continuous(exp_monthly_total, statistics( p50) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.2f p50 ) ///
 title("Median Monthly Expenditures_comparing arms") ///
	export(table1expEnd_hiran.xlsx, replace) 
	
ci mean exp_monthly_total if arm==1 &time_datacollect==0&region==1
ci mean exp_monthly_total if arm==1 &time_datacollect==1&region==1
ci mean exp_monthly_total if arm==1 &time_datacollect==2&region==1

ci mean exp_monthly_total if arm==2 &time_datacollect==0&region==1
ci mean exp_monthly_total if arm==2 &time_datacollect==1&region==1
ci mean exp_monthly_total if arm==2 &time_datacollect==2&region==1

ci mean exp_monthly_total if arm==3 &time_datacollect==0&region==1
ci mean exp_monthly_total if arm==3 &time_datacollect==1&region==1
ci mean exp_monthly_total if arm==3 &time_datacollect==2&region==1

** Exp on food as a proportion of total expenditue 

tab exp_monthly_total
tab exp_food_monthly
gen food_exp_prop= exp_food_monthly/exp_food_monthly*100

tab food_exp_prop arm if time_datacollect==0, col

*Note 
* Total exp ranges from $0 to $564. there is one HH reported $2,443.5 
* Replaced $2,443.5 as missing 
* Arm 3 has a higher monthly exp

** What do HH spend on:

/*
graph hbar exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month, over(time_datacollect,sort(1) descending)stack percent scheme(mrc) title("Expenditure by Category")

graph hbar exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month if time_datacollect!=0, over(time_datacollect,sort(1) descending)stack percent scheme(mrc) title("Expenditure by Category")

graph hbar exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month if time_datacollect==0, over(arm) stack percent scheme(mrc) title("Expenditure by Arm at Baseline")

graph hbar exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month if time_datacollect==1, over(arm) stack percent scheme(mrc) title("Expenditure by Arm at Midline")

graph hbar exp_food_monthly exp_hyg_month exp_trans_month exp_fuel_month exp_wat_month exp_elect_month exp_comm_month exp_rent_month exp_med_month exp_mch_month exp_cloths_month exp_school_month exp_agric_month exp_social_month exp_debt_month exp_save_month if time_datacollect==2, over(arm)stack percent scheme(mrc) title("Expenditure by Arm at Endline")
*/
* 2) Mother Education 
tab edu 
tab edu,nolabel

recode edu (1=1 "No Formal Edu") (2=2 "Madrasa") (3=3 "Primary&Secondary")(4=3 "Primary&Secondary"), generate(education)
drop edu
rename education edu
/*
quietly eststo Baseline: proportion edu if time_datacollect==0
quietly eststo Endline: proportion edu if time_datacollect==2
coefplot Baseline Endline, vertical xtitle(Mother Education) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.3) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Highest level of mother education)

quietly eststo Baseline: proportion edu if time_datacollect==0,over(arm)
quietly eststo Endline: proportion edu if time_datacollect==2,over(arm)
coefplot Baseline Endline, vertical xtitle(Mother Education) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.3) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Highest level of mother education by Arm)
*/
* 3) Mother empowerment (Decision making)
* income
tab decision_income
tab decision_income, nolabel

* healthcare
tab decision_healthcare
tab decision_healthcare, nolabel

* Purchases
tab decision_purchases
tab decision_purchases, nolabel

/*
* Income
quietly eststo Baseline: proportion decision_income if time_datacollect==0
quietly eststo Midline: proportion decision_income if time_datacollect==1
quietly eststo Endline: proportion decision_income if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Income)

quietly eststo Baseline: proportion decision_income if time_datacollect==0,over(arm)
quietly eststo Midline: proportion decision_income if time_datacollect==1,over(arm)
quietly eststo Endline: proportion decision_income if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Income by Arm)
*/
dtable i.decision_income, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Decision making response rate") ///
export(tabledecision.xlsx, replace)
tabstat decision_income if ychld_tag0==1, stat(N)
tabstat decision_income if ychld_tag1==1, stat(N)
tabstat decision_income if ychld_tag2==1, stat(N)
/*
* Healthcare
quietly eststo Baseline: proportion decision_healthcare if time_datacollect==0
quietly eststo Midline: proportion decision_healthcare if time_datacollect==1
quietly eststo Endline: proportion decision_healthcare if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Healthcare)

quietly eststo Baseline: proportion decision_healthcare if time_datacollect==0,over(arm)
quietly eststo Midline: proportion decision_healthcare if time_datacollect==1,over(arm)
quietly eststo Endline: proportion decision_healthcare if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Healthcare by Arm)


* Purchases
quietly eststo Midline: proportion decision_purchases if time_datacollect==1
quietly eststo Endline: proportion decision_purchases if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Purchases)

quietly eststo Midline: proportion decision_purchases if time_datacollect==1,over(arm)
quietly eststo Endline: proportion decision_purchases if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Decision Making) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(HH Decision Making on Purchases by Arm)
*/
/* Proportion of HH headed by mothers is similar accorss arms
* decision making on income is similar accross arms
* decicion making on healthcare is similar accross arms */

* 5) Age of the mother/caregiver                                              
summ mother_age, detail    
tab  mother_age
tabstat  mother_age, statistics(count mean sd median) by(arm) format(%9.1f)
    hist  mother_age
	hist  mother_age, by(arm)
    graph box  mother_age
	graph box  mother_age, over (arm) mark(1,mlabel(mother_age))
replace mother_age=. if mother_age <18      // 2 obs replace with missing 
* Note-
* Age of mother/caregiver range from 13 to 89
** Replace age <18 with missing.

	* Creat age-groups
	
recode mother_age (18/24= 1 "18-24 Yrs") (25/35=2 "25-35 Yrs") (36/50=3 "36-50 Yrs") (51/89 =4 "51+ Yrs"), generate(agecat_mother)

tab agecat_mother
tab agecat_mother arm, col
graph bar (count), over(agecat_mother)
graph bar, over(agecat_mother) over(arm) 

replace mothersage=. if mothersage<18
recode mothersage (18/34= 1 "18-34 Yrs") (35/89=2 "35+ Yrs"), generate(agecat2_mother)

/*
quietly eststo moth_age: proportion agecat_mother
coefplot moth_age, vertical xtitle(Maternal Age) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) ///
title("Maternal Age_Overall")

quietly eststo moth_age_arm: proportion agecat_mother, over(arm)
coefplot moth_age_arm, vertical xtitle(Maternal Age) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) ///
title("Maternal Age_By Arm")
*/

/*preserve 
collapse (mean) meanmothersage= mothersage (sd) sdmothersage=mothersage (count) n=mothersage, by(agecat_mother arm)
generate himothersage = meanmothersage + invttail(n-1,0.025)*(sdmothersage / sqrt(n))
generate lomothersage = meanmothersage - invttail(n-1,0.025)*(sdmothersage / sqrt(n))

label define agecat 1 "10-19" 2 "20-29" 3 "30-39" 4 "40-49" 5 "50-59" 
label values agecat_mother agecat

graph twoway ((bar meanmothersage agecat_mother) (rcap himothersage lomothersage agecat_mother), by(arm)), xtitle("Mother's Age") ytitle("Mean Mother's Age")*/

* 6) If Mother is the HoH

tab hoh
quietly eststo Baseline: proportion hoh if time_datacollect==0
coefplot Baseline , vertical xtitle(HoH) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Mother Head of Household)

* 7) Current prgenancy status 

tab preg
tab preg arm, col 
/*
quietly eststo Baseline: proportion preg if time_datacollect==0
quietly eststo Midline: proportion preg if time_datacollect==1
quietly eststo Endline: proportion preg if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(pregnant) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Pregnancy Status at time of data collection)

quietly eststo Baseline: proportion preg if time_datacollect==0,over(arm)
quietly eststo Midline: proportion preg if time_datacollect==1,over(arm)
quietly eststo Endline: proportion preg if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(pregnant) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Pregnancy Status at time of data collection by arm)
*/
tabstat preg if ychld_tag0==1, stat(N)
tabstat preg if ychld_tag1==1, stat(N)
tabstat preg if ychld_tag2==1, stat(N)

* 7) Number of U5 in HHs                                                           
 
tab num_u5_children if time_datacollect==0
tab num_u5_children if time_datacollect==0,nolabel
tab num_u5_children if time_datacollect==1
tab num_u5_children if time_datacollect==1,nolabel
tab num_u5_children if time_datacollect==2
tab num_u5_children if time_datacollect==2,nolabel

graph box num_u5_children, over (arm) mark(1,mlabel(num_u5_children)) 
tabstat  num_u5_children, statistics(count mean sd min max median) by(arm) format(%9.0f)

label def nch 1 "1 child" 2 "2 children" 3 "3 children" 4 "4 children"
label value num_u5_children nch
tab num_u5_children

/*
graph bar, over (num_u5_children) title("Number of u5 in HH_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) ytitle(Percentage of HH) name(u51, replace) // overall

graph bar,over(num_u5_children) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) ytitle(Percentage of HH) title("Number of u5 in HH_by Arm") name(u52, replace) // by arm

graph combine u51 u52, ycommon altshrink
*/
** Range between 1-4 children 

*------------------------------------------
*        Nutrition sensitive programming_ Assistnace received last 3 months 
*------------------------------------------


*--------------------------------------------------------------------
* Received any assitance duirng the last 3 months (qn didnt exclude BHA)
*--------------------------------------------------------------------
tab received_assitance_last3months if time_datacollect==1
tab received_assitance_last3months if time_datacollect==1,nolabel

recode received_assitance_last3months (4026= 0 "No") (2370/2377=1 "Yes") (2815/2817=1 "Yes"), generate(rec_assist_lt3mths)
tab rec_assist_lt3mths if time_datacollect==0
/*
graph bar, over (rec_assist_lt3mths) title("Received assistance last 3 months_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) ytitle(Percentage of HH) name(assist1, replace) // overall
graph bar,over(rec_assist_lt3mths) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) ytitle(Percentage of HH) title("Received assistance last 3 months_by Arm") name(assist2, replace) // by arm

graph combine assist1 assist2, ycommon altshrink
*/
** What kinds of assitance received 
gen assist_type=.
replace assist_type=0 if assist_lt3m_cash==1
replace assist_type=1 if assist_lt3m_food==1 | assist_lt3m_viata==1|assist_lt3m_snf==1|assist_lt3m_hyg==1|assist_lt3m_other==1
replace assist_type=2 if assist_lt3m_none==1
tab assist_type
label def assist 0 "Cash" 1 "others(Food/SNF/Schoolsupport)" 2 "None"
label val assist_type assist
/*
graph bar, over (assist_type) title("Type of assitance_Overall") blabel(bar,position(outside)format(%9.1f)color(black)) bar(1,color(eltblue)) ytitle(Percentage of HH) name(assist3, replace) // overall
graph bar,over(assist_type) over(arm) asyvars blabel(bar,position(outside)format(%9.1f)) percentages bar(1,color(edkblue)) bar(2,color(eltblue)) ytitle(Percentage of HH) title("Type of assitance_by Arm") name(assist4, replace) // by arm

graph combine assist3 assist4, ycommon altshrink


graph bar assist_lt3m_cash assist_lt3m_food assist_lt3m_viata assist_lt3m_snf assist_lt3m_hyg assist_lt3m_schol assist_lt3m_other assist_lt3m_none, ytitle(Percentage of HHs) title("Assist Received_lt3mths_Overall") blabel(bar,position(outside)format(%9.2f)color(black)) name(ast1,replace)scheme(mrc)  // Overall
graph bar assist_lt3m_cash assist_lt3m_food assist_lt3m_viata assist_lt3m_snf assist_lt3m_hyg assist_lt3m_schol assist_lt3m_other assist_lt3m_none, over(arm) ytitle(Percentage of HHs) title("Assist Received_lt3mths_By Arm") blabel(bar,position(outside)format(%9.2f)color(blue)) name(ast2,replace) scheme(mrc) //by arm

grc1leg ast1 ast2, legendfrom(ast2) ycommon altshrink

*/
*------------------------------------------------------
*              Household Environment              *
*------------------------------------------------------
* 1) HH crowding                                                  
tab hh_members  //Number of people range from 1 to 46 //
hist hh_members // heavilg right skewed 
replace hh_members=. if hh_members>20  // 7 obs replace with HH member more than 20 replace with missing 

tab no_room // Number of rooms range from 1-6 ( 3 recorded as zero room and 1 recorded as having 22 rooms )
replace no_room =. if no_room <1 |no_room>6 // 4 obs replaced as missing 

gen crowd_index = hh_members/no_room
tab crowd_index
graph bar, over(crowd_index)
graph box crowd_index
tabstat crowd_index,by (arm) statistics(mean sd min max iqr) nototal col(stat) format(%3.2f) long
label var crowd_index "Person per room"

**
* create HH crowding groups 
*  * DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
gen crowding_cat=.
replace crowding_cat=0 if hh_members<5
replace crowding_cat=1 if hh_members>=5
label variable crowding_cat "HH Crowding Category"

label define hhcrowed 0 "Not Crowded" 1 "Crowded"
label value crowding_cat hhcrowed
/*
quietly eststo Baseline: proportion crowding_cat if time_datacollect==0
quietly eststo Midline: proportion crowding_cat if time_datacollect==1
quietly eststo Endline: proportion crowding_cat if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Crowding) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Crowding Status)

quietly eststo Baseline: proportion crowding_cat if time_datacollect==0,over(arm)
quietly eststo Midline: proportion crowding_cat if time_datacollect==1,over(arm)
quietly eststo Endline: proportion crowding_cat if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Crowding) rescale(100) ytitle(Percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Household Crowding Status by Arm)
*/
* Note-
*On average 4 person per room

* 2) Handwashing
tab acc_handwash arm, col          // HH acess to handwahing facility with soap and water 
/*
quietly eststo Baseline: proportion acc_handwash if time_datacollect==0
quietly eststo Midline: proportion acc_handwash if time_datacollect==1
quietly eststo Endline: proportion acc_handwash if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Handwashing facility access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to handwashing facility with water and soap)

quietly eststo Baseline: proportion acc_handwash if time_datacollect==0,over(arm)
quietly eststo Midline: proportion acc_handwash if time_datacollect==1,over(arm)
quietly eststo Endline: proportion acc_handwash if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Handwashing facility access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to handwashing facility with water and soap by Arm)
*/

/*Notes
* Only 3% of HH have access to handwashing facility with soap and water 
*
*/

* 3) Latrine/toilet
tab toilet_type arm, col   // types of latrine used by HH 
tab toilet_type
tab toilet_type, nolabel
** DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
**(Created binary group based on WHO/UNICE guidelines: Improved =composting toilet, flush, pit-latrine ; Non-improved=open/bush/field, other )
recode toilet_type (1=0 "Open defecation") (4=0 "Open defecation") (2=1 "Flush/Latrine") (3=1 "Flush/Latrine")(5=1 "Flush/Latrine"), generate(toilet)
drop toilet_type
tab toilet
tab toilet arm, col
/*
quietly eststo Baseline: proportion toilet if time_datacollect==0
quietly eststo Midline: proportion toilet if time_datacollect==1
quietly eststo Endline: proportion toilet if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Sanitation facility) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to Sanitation Facility)

quietly eststo Baseline: proportion toilet if time_datacollect==0,over(arm)
quietly eststo Midline: proportion toilet if time_datacollect==1,over(arm)
quietly eststo Endline: proportion toilet if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Sanitation facility) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to Sanitation Facility by Arm)
*/

dtable i.toilet, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("sample size response rate") ///
export(tabletoilet.xlsx, replace)
tabstat toilet if ychld_tag0==1, stat(N)
tabstat toilet if ychld_tag1==1, stat(N)
tabstat toilet if ychld_tag2==1, stat(N)

/* NOte: dist. simialar across the arms
* Arm 2 has a higher latrine usage 
*/ 

* 4) Water
tab water_mainsource arm      // HH's main source of drinking water 
tab water_mainsource, nolabel
** DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
recode water_mainsource (5=0 "Unprotected Source")(7=0 "Unprotected Source")  (2=1 "Protected source")(3=1 "Protected source")(4=0 "Unprotected Source")(6=0 "Unprotected Source") , generate(water_source)
drop water_mainsource
tab water_source
tab water_source arm, col

/*
quietly eststo Baseline: proportion water_source if time_datacollect==0
quietly eststo Midline: proportion water_source if time_datacollect==1
quietly eststo Endline: proportion water_source if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Water Source) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to Water Source)

quietly eststo Baseline: proportion water_source if time_datacollect==0,over(arm)
quietly eststo Midline: proportion water_source if time_datacollect==1,over(arm)
quietly eststo Endline: proportion water_source if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Water Source) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Acess to Water Source by Arm)
*/
tabstat water_source if ychld_tag0==1, stat(N)
tabstat water_source if ychld_tag1==1, stat(N)
tabstat water_source if ychld_tag2==1, stat(N)


* Wealth/Asset Index 
/*Filmer and Pritchett (2001) popularized the use of PCA for estimating wealth levels using asset indicators to replace income or consumption data. Based on their analysis of household assets for India and the validation of their results using both household assets and consumption data for Indonesia, Pakistan, and Nepal, they concluded that PCA "provides plausible and defensible results.
Filmer and Pritchett (2001) note that asset-based measures depict an individual or a household's long-run economic status and therefore do not necessarily account for short-term fluctuations in economic well-being or economic shocks. 

The wealth index measures relative wealth and, unlike a poverty line, is not an absolute measure of poverty or wealth. When referring to the wealth of households based on the wealth index we can talk about poorer and wealthier households but we cannot conclude who is absolutely poor and wealthy. The wealth index quintiles divide the whole population into five equally large groups, based on their wealth rank. For example, in an area where only 10% of households fall below the poverty line, 40% of households will still fall into the two poorest quintiles and therefore be classified as the poorest.

For our analyses, the wealth index quintiles would be useful for cross-tabulation with other variables in the dataset. For example, cross-tabulating with regions can show areas with higher proportions of poor households or cross-tabulating with food consumption groups could determine what proportion of households with poor food consumption are also in the poorer groups. In addition, the wealth index can be used as a proxy for food access.
*/

 /*
 * Exloring potential variables to include in PCA analysis 
 
 * Step 1: Long list of variables to consider
 1) livestock ownership (camel, cattle, goats, donkey, horse, poultry,)
 2) Land ownership or Hectares of land
 3) Own bank acount
 4) HH items (electricity, radio, TV, telephone, computer, refrigerator, internet,air-condition) 
 5) HH assests (watch, mobile phone, bicycle, scooter, donkey cart,truck, canoe, tractor, oxplough, )
 6) Crowding status 
 7) Floor 
 8) Roof
 9) Wall
 10) Type of toilet
 11) Water source 
 */
 
 * Step 2 : Run frequency for each variables and recode to 1/0 variable 
 * (To select variables that are capable of distinguishing relatively "wealthy" households and relatively "poor" ones. The rule of thumb is that if a variable/asset is owned by more than 95% or less than 5% of the sample, it should be excluded from the analysis)

 * 1) Livestock 
 tab own_liv_cat  // Not include (96%, 4%)
 tab own_liv_goat // include (50% 50%)
 tab own_liv_don // include (93% 7%)
 tab own_liv_hor // not include (99%)
 tab own_liv_pou // not inlcude (97%)
 
 * 2) landwonership 
 tab own_agric_land  
 replace own_agric_land=0 if hec_land==0 | hec_land>10 & !missing(hec_land)
 tab own_agric_land // include (84% 16%)
 
 tab hec_land  // there are HH with zero and thise with over 10.
 replace hec_land=. if hec_land==0 | hec_land>10
 tab hec_land
 
 * 3) Own bank account 
 tab own_bankaccount if time_datacollect==1  
  tab own_bankaccount if time_datacollect==1,nolabel
   tab own_bankaccount if time_datacollect==2
  tab own_bankaccount if time_datacollect==2,nolabel
  replace own_bankaccount=0 if own_bankaccount==1341
  tab own_bankaccount  // not include (98%)
 
 * 4) HH items
 tab hh_item_elect // not include (97%)
 tab hh_item_rad  // include (70%, 30%)
 tab hh_item_tv   // not include (100%)
 tab hh_item_tel  // not include (97%, 3%)
 tab hh_item_com // not include (100%%)
 tab hh_item_ref // not include (100%)
 tab hh_item_ac // include (72%, 28%)
 
 * 5) HH assets 
 tab hh_asset_wat // include (81%, 19%)
 tab hh_asset_mphon // not include (96%, 4%)
 tab hh_asset_bisc // not include (99%)
 tab hh_asset_scot // not include (100%)
 tab hh_asset_doncar // not include (95%, 5%)
 tab hh_asset_tru  // not include (99%)
 tab hh_asset_canoe // not include (99%)
 tab hh_asset_tract // not include (99%)
 tab hh_asset_oxplou // not include (100%)
 
 *6) Crowding status
 tab crowding_cat // include (74%, 26%)
 
 *7) Floor (created binary group based on context: Poorer= earth, wood, bamboo; Wealthier=polished, asphalt, tiles, cement, carpet )
 * DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
 gen floor_binary=.
 replace floor_binary=0 if floor_earth==1| floor_dung==1| floor_wood==1| floor_bamboo==1
 replace floor_binary=1 if floor_polished==1| floor_asphalt==1| floor_tiles==1| floor_cement==1| floor_carpet==1
 label value floor_binary yesno
 tab floor_binary  // include (93%, 7%)

 * 8) Roof (created binary group based on context: Poorer= leaves, grass, rusted metal, bamboo, woodpanks, cardboard, clothes, tent; Wealthier= ceremic, cement, shingle)
  * DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
 gen roof_binary=.
 replace roof_binary=0 if roof_leaf==1| roof_grass==1| roof_rustmat==1| roof_bamboo==1| roof_wodplank==1| roof_cardb==1|roof_clothtent==1
 replace roof_binary=1 if roof_metal==1| roof_ceramic==1| roof_cement==1| roof_shing==1
 label value roof_binary yesno
 tab roof_binary    // include (78%, 22%)
 
 * 9) Wall (Created binary group based on context: Poorer=cane, dirt, bamboo-mud, stone-mud, uncovered, plywood, cardboard, wood,  ; Wealthier =cement, stones, bricks, cementblock, shingle, adobe )
   * DHS guidelines: https://dhsprogram.com/data/Guide-to-DHS-Statistics/index.cfm
  gen wall_binary=.
  replace wall_binary=0 if wall_cane==1| wall_dirt==1| wall_bambmud==1| wall_stonmud==1| wall_uncovadbobe==1| wall_plywood==1| wall_cardb==1| wall_reusewood==1
  replace wall_binary=1 if wall_cement==1| wall_stone==1| wall_brick==1| wall_cemblock==1| wall_covadobe==1| shing==1
  label value wall_binary yesno
  tab wall_binary  // include (78%, 22%)

 * 10) Type of toilet 
 tab toilet // include (22% 78%)
 
 * 11) Water source 
 tab water_source  // include (17%, 83%)

 ** 12 components make the criteeria of is being owned by more than 95% or less than 5% of the sample.
 
 ** principle analysis - same cutoff point for both midline and endline 
  ** Principle components for Midline 
* Step 1: 
factor own_liv_goat own_agric_land own_liv_don  hh_item_rad hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source, pcf 
estat kmo
// removed radio
* Mimimum acceptable KMO=0.5653

* Step 2: 
factor own_liv_goat own_agric_land own_liv_don hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==1, pcf 
estat kmo
* Remove agric land, donkey with KMO <0.5. Overall KMO=0.5335

* Step 3: 
factor own_liv_goat hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==1, pcf 
estat kmo 
* Remove wall and toilet

* Step 4: 
factor own_liv_goat hh_item_ac hh_asset_wat crowding_cat roof_binary water_source if time_datacollect==1, pcf 
estat kmo // All measure of sampling adequacy are all above 0.5

 screeplot 
 predict comp1
 rename comp1 asset_score
 hist asset_score
 tab asset_score
 xtile asset_index = asset_score, nq(5)
 tab asset_index
 label def asset_index 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest"
 label value asset_index asset_index
 label var asset_index "Asset Index"
  tab asset_index arm, col
  tab asset_index
  tab asset_index,nolabel
 /* 
  quietly eststo Midline: proportion asset_index if time_datacollect==1
quietly eststo Endline: proportion asset_index if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles at Midline)

quietly eststo Midline: proportion asset_index if time_datacollect==1,over(arm)
quietly eststo Endline: proportion asset_index if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles by Arm)
*/

 ** Principle components for Midline endline seperatley 
* Step 1: 
factor own_liv_goat own_agric_land own_liv_don  hh_item_rad hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==1, pcf 
estat kmo
// removed radio
* Mimimum acceptable KMO=0.5653

screeplot, mean
* Step 2: 
factor own_liv_goat own_agric_land own_liv_don hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==1, pcf 
estat kmo
* Remove agric land, donkey with KMO <0.5. Overall KMO=0.5335

* Step 3: 
factor own_liv_goat hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==1, pcf 
estat kmo 
* Remove wall and toilet

* Step 4: 
factor own_liv_goat hh_item_ac hh_asset_wat crowding_cat roof_binary water_source if time_datacollect==1, pcf 
estat kmo // All measure of sampling adequacy are all above 0.5


 predict comp1
 rename comp1 asset_score_Mid
 hist asset_score_Mid
 tab asset_score_Mid
 xtile asset_index_Midline = asset_score_Mid, nq(5)
 tab asset_index_Midline
 label def asset_index1 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest"
 label value asset_index_Midline asset_index1
 label var asset_index_Midline "Asset Index at Midline"
  tab asset_index_Midline arm, col
  tab asset_index_Midline
  tab asset_index_Midline,nolabel
 
 /*
  quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1
quietly eststo Endline: proportion asset_index_Midline if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles at Midline)

quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1,over(arm)
coefplot Midline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles by Arm at Midline)
*/
** Cut off point for midline
tab asset_score_Mid
tab asset_score_Mid if asset_index_Midline==1 // cutoff: <= -0.6238634
tab asset_score_Mid if asset_index_Midline==2 // cutoff:  -0.6038429 to -0.0398499
tab asset_score_Mid if asset_index_Midline==3 // cutoff:  -0.0198294 to 0.2514686
tab asset_score_Mid if asset_index_Midline==4 // cutoff:  0.2714891 to  0.8354821
tab asset_score_Mid if asset_index_Midline==5 // cutoff:   >=0.8555026 
  
  ** Principle components for Endline
* Step 1: 
factor own_liv_goat own_agric_land own_liv_don  hh_item_rad hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==2, pcf 
estat kmo
// removed goats, 
* Mimimum acceptable KMO=0.5653

* Step 2: 
factor own_agric_land own_liv_don  hh_item_rad hh_item_ac hh_asset_wat crowding_cat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==2, pcf 
estat kmo
* Remove cattle

* Step 3: 
factor own_agric_land own_liv_don  hh_item_rad hh_item_ac hh_asset_wat floor_binary roof_binary wall_binary toilet water_source if time_datacollect==2, pcf 
estat kmo
* Remove wall as it has

* Step 4:  
factor hh_item_rad hh_item_ac hh_asset_wat wall_binary toilet water_source if time_datacollect==2, pcf 
estat kmo
 screeplot 
 predict comp1
 rename comp1 asset_score_End
 hist asset_score_End
 tab asset_score_End
gen asset_index_Endline=.
replace asset_index_Endline=1 if asset_score_End <= -0.6238634
replace asset_index_Endline=2 if asset_score_End >= -0.6038429 & asset_score_End <= -0.0398499
replace asset_index_Endline=3 if asset_score_End >= -0.0198294 & asset_score_End <= 0.2514686
replace asset_index_Endline=4 if asset_score_End >= 0.2714891 & asset_score_End <= 0.8354821
replace asset_index_Endline=5 if asset_score_End >=0.8555026 &!missing(asset_score_End)
 label value asset_index_Endline asset_index1
 label var asset_index_Endline "Asset Index at Endline"
  tab asset_index_Endline arm, col
  tab asset_index_Endline

 /* 
quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1
quietly eststo Endline: proportion asset_index_Endline if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles_(same cutoff))

quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1,over(arm)
quietly eststo Endline: proportion asset_index_Endline if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.5) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles by Arm_(same cutoff))
*/
* For Bay
factor own_liv_goat hh_asset_wat floor_binary roof_binary water_source if region==0, pcf
estat kmo 
 screeplot 
 predict comp1
 rename comp1 asset_score_bay
 hist asset_score_bay
 tab asset_score_bay
 xtile asset_index_bay = asset_score_bay, nq(5)
 tab asset_index_bay
 
 label value asset_index_bay asset_index
 label var asset_index_bay "Asset Index for Bay"
  tab asset_index_bay arm, col
  tab asset_index_bay
  tab asset_index_bay,nolabel
/*
quietly eststo Midline: proportion asset_index_bay if time_datacollect==1
quietly eststo Endline: proportion asset_index_bay if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Bay)

quietly eststo Midline: proportion asset_index_bay if time_datacollect==1,over(arm)
quietly eststo Endline: proportion asset_index_bay if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Bay by Arm)

* same cutoff
quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1&region==0
quietly eststo Endline: proportion asset_index_Endline if time_datacollect==2&region==0
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Bay_(same cutoff))
*/
* For Hiran
factor own_liv_goat hh_asset_wat floor_binary roof_binary water_source if region==1, pcf
estat kmo 
 screeplot 
 predict comp1
 rename comp1 asset_score_hiran
 hist asset_score_hiran
 tab asset_score_hiran
 xtile asset_index_hiran = asset_score_bay, nq(5)
 tab asset_index_hiran
 
 label value asset_index_hiran asset_index
 label var asset_index_hiran "Asset Index for Hiran"
  tab asset_index_hiran arm, col
  tab asset_index_hiran
  tab asset_index_hiran,nolabel
/*
quietly eststo Midline: proportion asset_index_hiran if time_datacollect==1
quietly eststo Endline: proportion asset_index_hiran if time_datacollect==2
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Hiran)

quietly eststo Midline: proportion asset_index_hiran if time_datacollect==1,over(arm)
quietly eststo Endline: proportion asset_index_hiran if time_datacollect==2,over(arm)
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Hiran by Arm)

* same cutoff
quietly eststo Midline: proportion asset_index_Midline if time_datacollect==1&region==1
quietly eststo Endline: proportion asset_index_Endline if time_datacollect==2&region==1
coefplot Midline Endline, vertical xtitle(Quntiles) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Asset Index Quintiles for Hiran_(same cutoff))
*/
** Building blocks of wealth index
 
 tab own_liv_goat  asset_index 
 tab hh_asset_wat asset_index 
 tab floor_binary asset_index 
 tab roof_binary asset_index 
 tab water_source asset_index 
 
** Examining wealth with outcomes 

tab arm,nolabel
 tab asset_index

 tab wast_all asset_index, col
 
*--------------------------------------------------------------
*  Intergenerational_only for new births b'tn baseline & Midline 
*--------------------------------------------------------------
tab newborn_size
tab newborn_size if time_datacollect==0
tab newborn_size if time_datacollect==0, nolabel
tab newborn_size if time_datacollect==1
tab newborn_size if time_datacollect==1, nolabel
tab newborn_size if time_datacollect==2
tab newborn_size if time_datacollect==2, nolabel
tab newborn_size, nolabel
replace newborn_size=. if newborn_size==13

recode newborn_size (37=1 "Smaller than Avg") (34=1 "Smaller than Avg") (3121=1 "Smaller than Avg")(1772=1 "Smaller than Avg")(1262=1 "Smaller than Avg") (503=2 "Avg") (263=2 "Avg") ///
  (36=3 "Larger than Avg")(23=3 "Larger than Avg")(934=3 "Larger than Avg")(2981=3 "Larger than Avg") (395=3 "Larger than Avg"), generate(birth_size)
drop newborn_size
tab birth_size time_datacollect,col
tab birth_size arm, col
graph bar, over(birth_size)
graph bar, over(birth_size) over(arm)
/*
quietly eststo Baseline: proportion birth_size if time_datacollect==0
quietly eststo Midline: proportion birth_size if time_datacollect==1
quietly eststo Endline: proportion birth_size if time_datacollect==2
coefplot Baseline Midline Endline, vertical xtitle(Birth size) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Newborn size)

quietly eststo Baseline: proportion birth_size if time_datacollect==0,over(arm)
quietly eststo Midline: proportion birth_size if time_datacollect==1,over(arm)
quietly eststo Endline: proportion birth_size if time_datacollect==2,over(arm)
coefplot Baseline Midline Endline, vertical xtitle(Birth size) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Newborn size by Arm)
*/
tabstat birth_size if ychld_tag0==1, stat(N)
tabstat birth_size if ychld_tag1==1, stat(N)
tabstat birth_size if ychld_tag2==1, stat(N)

***
** Variable added at endline (related to recent floods)
tab hh_recently_disp
tab hh_recently_disp if arm==1
tab hh_recently_disp if arm==2
tab hh_recently_disp if arm==3
tab hh_recently_disp arm, col
tab hh_recently_disp region, col
label value hh_recently_disp yesno
/*
quietly eststo Endline: proportion hh_recently_disp if time_datacollect==2
coefplot Endline, vertical xtitle(recent displacement) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Recent Displacement)

quietly eststo Endline: proportion hh_recently_disp if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(recent displacement) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Recent Displacement by Arm)

quietly eststo Endline: proportion hh_recently_disp if time_datacollect==2,over(region)
coefplot Endline, vertical xtitle(recent displacement) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Recent Displacement by Region)
*/
** Reasons for displacement 
tab recent_disp_floods 
tab recent_disp_conflict // zero
tab recent_disp_lackoffood
tab recent_disp_other // zero

gen Floods = recent_disp_floods*100
gen Lack_of_food= recent_disp_lackoffood*100

graph bar Floods Lack_of_food if time_datacollect==2, ytitle(Percentage HH) title("Reason for recent displacement") blabel(bar,position(outside)format(%9.1f)color(black)) name(d1,replace)scheme(mrc)

* Impacts of recent displacement 
tab curr_disp_money_access
tab curr_disp_markt_access
tab curr_disp_jobs_access
tab curr_disp_food_access
tab curr_disp_educ_access
tab curr_disp_heath_access

/*
*Access to money
quietly eststo Endline: proportion curr_disp_money_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to money)

quietly eststo Endline: proportion curr_disp_money_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to money by Arm)


*Access to market
quietly eststo Endline: proportion curr_disp_markt_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to market)

quietly eststo Endline: proportion curr_disp_markt_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to market by Arm)

*Access to jobs
quietly eststo Endline: proportion curr_disp_jobs_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to jobs)

quietly eststo Endline: proportion curr_disp_jobs_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to jobs by Arm)

*Access to food
quietly eststo Endline: proportion curr_disp_food_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to food)

quietly eststo Endline: proportion curr_disp_food_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to food by Arm)

*Access to education
quietly eststo Endline: proportion curr_disp_educ_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to education)

quietly eststo Endline: proportion curr_disp_educ_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to education by Arm)

*Access to health
quietly eststo Endline: proportion curr_disp_heath_access if time_datacollect==2
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to health)

quietly eststo Endline: proportion curr_disp_heath_access if time_datacollect==2,over(arm)
coefplot Endline, vertical xtitle(Access) rescale(100) ytitle(percent) /// 
recast(bar) barwidth(0.25) fcolor(*.5) ciopts(recast(rcap)) citop citype(logit) title(Access to health by Arm)
*/
**--------------------------------
* Save clean dataset
*---------------------------------
save "R2HC_MainPaperData.dta", replace 


gen wated_child=1 if wast_2muac==1 | wast_2cat==1
replace wated_child=0 if wast_2muac==0 & wast_2cat==0
label def was 0 "not wasted" 1 "wasted"
label val wated_child was
tab wated_child time_datacollect

**# Bookmark #1 
**********************
* CREATING DIFFRENT ANALYSIS DATASETS
*********************
** Prevalence using ITT approach dataset 
use R2HC_MainPaperData.dta, clear 

** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 
tab wast_2cat time_datacollect, col

*Prevalence using PP approach dataset
use R2HC_MainPaperData.dta, clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect

duplicates tag id_child, g(endline_pp)
tab endline_pp        // 0= not repeated, 1= repeated once, 2 repeated twice

tab endline_pp if endline_pp==0 //279 obs only at baseline
tabstat age_chld if endline_pp==1, stat(N) // 300 obs repeated twice 
tabstat age_chld if endline_pp==1 & time_datacollect==2, stat(N) // 8 repeated twice at endline
tabstat age_chld if endline_pp==1 & time_datacollect!=2, stat(N) // 292 repeated twice but not at endline (means at midline)

by id_child, sort :drop if endline_pp<2 // dropped 579 observations 

tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)


tabstat id_child, by(time_datacollect) stat(N) nototal
tab id_child if endline_pp==2 & time_datacollect==0
tab id_child if endline_pp==2 & time_datacollect==1
tab id_child if endline_pp==2 & time_datacollect==2

tab wast_2cat time_datacollect, col

xtset id_child time_datacollect   // balanced dataset

save "R2HC_MainPaperData.dta_prev_pp", replace
use R2HC_MainPaperData.dta_prev_pp, clear 

*Incidence using ITT approach dataset
use R2HC_MainPaperData.dta, clear 


tab id_child

/*
tab oedema_chld if time_datacollect==0
tab wast_2muac if time_datacollect==0 
tab wast_2cat if time_datacollect==0 //15% wasted at baseline
tab wast_2cat if time_datacollect==1 // 12% wasted at midline 
tab wast_2cat if time_datacollect==2 // 14% wasted at endline
tab wt_2cat if time_datacollect==0
tab stunt_2cat if time_datacollect==0

by id_child, sort :gen wasted_muac_b=1 if wast_2muac==1 & time_datacollect==0
by id_child, sort :gen wasted_baseline=1 if wast_2cat==1 & time_datacollect==0
by id_child, sort :gen underwt_baseline=1 if wt_2cat==1 & time_datacollect==0
by id_child, sort :gen stunted_baseline=1 if stunt_2cat==1 & time_datacollect==0

by id_child, sort :gen wasted_muac_mid=1 if wast_2muac==1 & time_datacollect==1
by id_child, sort :gen wasted_mid=1 if wast_2cat==1 & time_datacollect==1
by id_child, sort :gen underwt_mid=1 if wt_2cat==1 & time_datacollect==1
by id_child, sort :gen stunted_mid=1 if stunt_2cat==1 & time_datacollect==1

tab id_child if wast_2muac==1 & time_datacollect==0 | wast_2cat==1 & time_datacollect==0 & wast_2muac==1 & time_datacollect==1 | wast_2cat==1 & time_datacollect==1

by id_child, sort : drop if wasted_muac_b==1 & time_datacollect==0
by id_child, sort : drop if wasted_baseline==1 & time_datacollect==0
by id_child, sort : drop if underwt_baseline==1 & time_datacollect==0
by id_child, sort : drop if stunted_baseline==1 & time_datacollect==0

tab matmuac_cat if time_datacollect==0 // 12.69% wasted at baseline
tab matmuac_cat if time_datacollect==1 // 9.39% wasted at midline
tab matmuac_cat if time_datacollect==2 // 12.16% wasted at endline

by id_child, sort :gen wasted_moth_bas=1 if matmuac_cat==1 & time_datacollect==0
by id_child, sort :gen wasted_moth_mid=1 if matmuac_cat==1 & time_datacollect==1

by id_child, sort : drop if wasted_moth_bas==1 & time_datacollect==0
*/

tab wast_2cat time_datacollect,col
tab id_child if wast_2cat==1 & time_datacollect==0

tab wast_2muac time_datacollect,col
tab wast_2cat time_datacollect,col
tab id_child if wated_child==1 & time_datacollect==0 | wated_child==1 & time_datacollect==1 
by id_child, sort :drop if wated_child==1 & time_datacollect==0

save "R2HC_MainPaperData.dta_Inc_ITT_baseline_child.dta", replace

* Drop at midline 
tab wast_2cat time_datacollect,col
tab wast_2muac time_datacollect,col
tab id_child if wated_child==1 & time_datacollect==1 
by id_child, sort :drop if wated_child==1 & time_datacollect==1 

save "R2HC_MainPaperData.dta_Inc_ITT_midline_child.dta", replace


* Mother 
use R2HC_MainPaperData.dta, clear
tab matmuac_cat time_datacollect, m
tab matmuac_cat time_datacollect, col
by id_child, sort: drop if matmuac_cat==1 & time_datacollect==0
by id_child, sort: drop if matmuac_cat==. & time_datacollect==0
save "R2HC_MainPaperData.dta_Inc_ITT_baseline_mother.dta", replace


* Drop at midline 
use R2HC_MainPaperData.dta, clear
tab matmuac_cat time_datacollect, col
by id_child, sort : drop if matmuac_cat==1 & time_datacollect==0
by id_child, sort :drop if matmuac_cat==1 & time_datacollect==1

save "R2HC_MainPaperData.dta_Inc_ITT_midline_mother.dta", replace


** Incidence using PP approach dataset
use R2HC_MainPaperData.dta_Inc_ITT_baseline.dta, clear

duplicates tag id_child, g(endline_inc_pp)
tab endline_inc_pp        // 0= not repeated, 1= repeated once, 2 repeated twice

tab endline_inc_pp if endline_inc_pp==0 //258 obs only at baseline
tabstat age_chld if endline_inc_pp==1, stat(N) // 618 obs repeated twice 
tabstat age_chld if endline_inc_pp==1 & time_datacollect==2, stat(N) // 8 repeated twice at endline
tabstat age_chld if endline_inc_pp==1 & time_datacollect!=2, stat(N) // 292 repeated twice but not at endline (means at midline)

drop if endline_inc_pp<2 // dropped 579 observations 

tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)


tabstat id_child, by(time_datacollect) stat(N) nototal
tab id_child if endline_inc_pp==2 & time_datacollect==0
tab id_child if endline_inc_pp==2 & time_datacollect==1
tab id_child if endline_inc_pp==2 & time_datacollect==2

xtset id_child time_datacollect   // balanced dataset

save "R2HC_MainPaperData.dta_Inc_PP_bas_nowasting.dta", replace

use R2HC_MainPaperData.dta_Inc_ITT_midline.dta, clear

duplicates tag id_child, g(endline_inc_pp)
tab endline_inc_pp        // 0= not repeated, 1= repeated once, 2 repeated twice

tab endline_inc_pp if endline_inc_pp==0 //258 obs only at baseline
tabstat age_chld if endline_inc_pp==1, stat(N) // 618 obs repeated twice 
tabstat age_chld if endline_inc_pp==1 & time_datacollect==2, stat(N) // 8 repeated twice at endline
tabstat age_chld if endline_inc_pp==1 & time_datacollect!=2, stat(N) // 292 repeated twice but not at endline (means at midline)

drop if endline_inc_pp<2 // dropped 579 observations 

tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)


tabstat id_child, by(time_datacollect) stat(N) nototal
tab id_child if endline_inc_pp==2 & time_datacollect==0
tab id_child if endline_inc_pp==2 & time_datacollect==1
tab id_child if endline_inc_pp==2 & time_datacollect==2

xtset id_child time_datacollect   // balanced dataset

save "R2HC_MainPaperData.dta_Inc_PP_mid_nowasting.dta", replace

* Mother 
use R2HC_MainPaperData.dta_Inc_ITT_baseline_mother.dta, replace

duplicates tag id_child, g(endline_inc_pp)
tab endline_inc_pp        // 0= not repeated, 1= repeated once, 2 repeated twice

tab endline_inc_pp if endline_inc_pp==0 //258 obs only at baseline
tabstat age_chld if endline_inc_pp==1, stat(N) // 618 obs repeated twice 
tabstat age_chld if endline_inc_pp==1 & time_datacollect==2, stat(N) // 8 repeated twice at endline
tabstat age_chld if endline_inc_pp==1 & time_datacollect!=2, stat(N) // 292 repeated twice but not at endline (means at midline)

drop if endline_inc_pp<2 // dropped 579 observations 

tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)


tabstat id_child, by(time_datacollect) stat(N) nototal
tab id_child if endline_inc_pp==2 & time_datacollect==0
tab id_child if endline_inc_pp==2 & time_datacollect==1
tab id_child if endline_inc_pp==2 & time_datacollect==2

xtset id_child time_datacollect   // balanced dataset

save "R2HC_MainPaperData.dta_Inc_PP_bas_nowasting_mother.dta", replace

use R2HC_MainPaperData.dta_Inc_ITT_midline_mother.dta, replace
duplicates tag id_child, g(endline_inc_pp)
tab endline_inc_pp        // 0= not repeated, 1= repeated once, 2 repeated twice

tab endline_inc_pp if endline_inc_pp==0 //258 obs only at baseline
tabstat age_chld if endline_inc_pp==1, stat(N) // 618 obs repeated twice 
tabstat age_chld if endline_inc_pp==1 & time_datacollect==2, stat(N) // 8 repeated twice at endline
tabstat age_chld if endline_inc_pp==1 & time_datacollect!=2, stat(N) // 292 repeated twice but not at endline (means at midline)

drop if endline_inc_pp<2 // dropped 579 observations 

tabstat hhid, by(time_datacollect) stat(N)
tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)


tabstat id_child, by(time_datacollect) stat(N) nototal
tab id_child if endline_inc_pp==2 & time_datacollect==0
tab id_child if endline_inc_pp==2 & time_datacollect==1
tab id_child if endline_inc_pp==2 & time_datacollect==2

xtset id_child time_datacollect   // balanced dataset

save "R2HC_MainPaperData.dta_Inc_PP_mid_nowasting_mother.dta", replace


*********************
*  MAIN PAPER TABLES
*******************
use R2HC_MainPaperData.dta, clear  // using prevalence by ITT dataset

** Characteristics at baseline (Table 1)
* 1) Location
dtable i.region i.displaced i.recent_disp_floods if time_datacollect==0, by(arm, tests testnotes nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Study location") ///
export(Mainpaper_Location.xlsx, replace)

oneway region arm if time_datacollect==0, tabulate 
oneway displaced arm if time_datacollect==0, tabulate 


dtable, by(arm, tests nototal) /// 
sample(, statistic(frequency proportion)) ///
 factor(region displaced recent_disp_floods, statistics(fvfrequency) test(kwallis)) ///
 sformat("(%s)" fvproportion) nformat(%6.1f mean min max)

dtable, by(arm, tests nototal) /// 
sample(, statistic(frequency proportion)) ///
 continuous(age, statistics( mean min max) test(anova)) ///
 factor(needle, statistics(fvfrequency fvproportion)) ///
 factor(jail inject, statistics(fvfrequency) test(fisher)) ///
 sformat("(%s)" fvproportion) nformat(%6.1f mean min max)

* 2) Child x-tics
dtable i.sex_chld age_chld i.age_chld_2gps muac_chld whz waz haz i.wast_2cat i.wast_2muac i.wt_2cat i.stunt_2cat i.bfedchild i.vacc_yesno i.illness_last2wks i.mdd_c i.mdd_animalprotein if time_datacollect==0, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children") ///
export(Mainpaper_Childx-tics.xlsx, replace)

oneway sex_chld arm if time_datacollect==0
oneway age_chld arm if time_datacollect==0
oneway age_chld_2gps arm if time_datacollect==0
oneway muac_chld arm if time_datacollect==0
oneway whz arm if time_datacollect==0
oneway waz arm if time_datacollect==0
oneway haz arm if time_datacollect==0
oneway bfedchild arm if time_datacollect==0
oneway vacc_yesno arm if time_datacollect==0
oneway illness_last2wks arm if time_datacollect==0
oneway mdd_c arm if time_datacollect==0
oneway mdd_animalprotein arm if time_datacollect==0
oneway wast_2cat arm if time_datacollect==0
oneway wast_2muac arm if time_datacollect==0
oneway wt_2cat arm if time_datacollect==0
oneway stunt_2cat arm if time_datacollect==0


* 3) Maternal x-tics
dtable mothersage i.agecat2_mother wt_mother muac_mother i.matmuac_cat i.preg i.edu if time_datacollect==0, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mother at baseline") ///
export(Mainpaper_Motherx-tics.xlsx, replace)


oneway mothersage arm if time_datacollect==0
oneway agecat2_mother arm if time_datacollect==0
oneway wt_mother arm if time_datacollect==0
oneway muac_mother arm if time_datacollect==0
oneway matmuac_cat arm if time_datacollect==0
oneway preg arm if time_datacollect==0
oneway edu arm if time_datacollect==0

* 4) HH x-tics
tab num_u5_children if time_datacollect==0
tab num_u5_children if time_datacollect==0,nolabel
recode num_u5_children (1=0 "1 child") (2/4=1 "2+ children")(8=1 "2+ children") (12=1 "2+ children")(30=1 "2+ children") (32=1 "2+ children")(60=1 "2+ children"), generate(num_u5_child)
drop init_bfeeding_know
tab num_u5_child if time_datacollect==0

dtable i.hoh i.decision_income i.decision_healthcare i.num_u5_child i.hhs_cat i.fcs_cat rCSI exp_monthly_total exp_food_monthly i.crowding_cat i.toilet i.water_source if time_datacollect==0, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of households") ///
export(Mainpaper_Householdx-tics.xlsx, replace)

oneway hoh arm if time_datacollect==0
oneway decision_income arm if time_datacollect==0
oneway decision_healthcare arm if time_datacollect==0
oneway num_u5_child arm if time_datacollect==0
oneway hhs_cat arm if time_datacollect==0
oneway fcs_cat arm if time_datacollect==0
oneway rCSI arm if time_datacollect==0
oneway exp_monthly_total arm if time_datacollect==0
oneway exp_food_monthly arm if time_datacollect==0
oneway acc_handwash arm if time_datacollect==0
oneway crowding_cat arm if time_datacollect==0
oneway toilet arm if time_datacollect==0
oneway water_source arm if time_datacollect==0

prtesti 100 0.632 100 0.74 100 0.708

tabi 100 63 \100 74 \100 71, chi2
tabi 100 48 \100 54 \100 52, chi2
tabi 100 60 \100 58 \100 67, chi2



** Characteristics at midline  (For annex table 2)
* 1) Location
dtable i.region i.displaced i.recent_disp_floods if time_datacollect==1, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Study location") ///
export(Mainpaper_Location_mid.xlsx, replace)

* 2) Child x-tics
dtable i.sex_chld age_chld i.age_chld_2gps muac_chld whz waz haz i.wast_2cat i.wast_2muac i.wt_2cat i.stunt_2cat i.bfedchild i.vacc_yesno i.illness_last2wks i.mdd_c i.mdd_animalprotein if time_datacollect==1, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children") ///
export(Mainpaper_Childx-tics_mid.xlsx, replace)


* 3) Maternal x-tics
dtable mothersage i.agecat2_mother wt_mother muac_mother i.matmuac_cat i.preg i.edu if time_datacollect==1, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mother at baseline") ///
export(Mainpaper_Motherx-tics_mid.xlsx, replace)

* 4) HH x-tics
tab num_u5_children if time_datacollect==0
tab num_u5_children if time_datacollect==0,nolabel
recode num_u5_children (1=0 "1 child") (2/4=1 "2+ children")(8=1 "2+ children") (12=1 "2+ children")(30=1 "2+ children") (32=1 "2+ children")(60=1 "2+ children"), generate(num_u5_child)
drop init_bfeeding_know
tab num_u5_child if time_datacollect==0


dtable i.hoh i.decision_income i.decision_healthcare i.num_u5_child i.hhs_cat i.fcs_cat rCSI exp_monthly_total exp_food_monthly i.crowding_cat i.toilet i.water_source if time_datacollect==1, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of households") ///
export(Mainpaper_Householdx-tics_mid.xlsx, replace)


** Characteristics at Endline (For Annex Table 2)
* 1) Location
dtable i.region i.displaced i.recent_disp_floods if time_datacollect==2, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Study location") ///
export(Mainpaper_Location_end.xlsx, replace)

* 2) Child x-tics
dtable i.sex_chld age_chld i.age_chld_2gps muac_chld whz waz haz i.wast_2cat i.wast_2muac i.wt_2cat i.stunt_2cat i.bfedchild i.vacc_yesno i.illness_last2wks i.mdd_c i.mdd_animalprotein if time_datacollect==2, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of children") ///
export(Mainpaper_Childx-tics_end.xlsx, replace)


* 3) Maternal x-tics
dtable mothersage i.agecat2_mother wt_mother muac_mother i.matmuac_cat i.preg i.edu if time_datacollect==2, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of Mother at baseline") ///
export(Mainpaper_Motherx-tics_end.xlsx, replace)

* 4) HH x-tics
tab num_u5_children if time_datacollect==0
tab num_u5_children if time_datacollect==0,nolabel
recode num_u5_children (1=0 "1 child") (2/4=1 "2+ children")(8=1 "2+ children") (12=1 "2+ children")(30=1 "2+ children") (32=1 "2+ children")(60=1 "2+ children"), generate(num_u5_child2)

tab num_u5_child2 if time_datacollect==0


dtable i.hoh i.decision_income i.decision_healthcare i.num_u5_child i.hhs_cat i.fcs_cat rCSI exp_monthly_total exp_food_monthly i.crowding_cat i.toilet i.water_source if time_datacollect==2, by(arm, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("Characteristics of households") ///
export(Mainpaper_Householdx-tics_end.xlsx, replace)


** For Annex Table 1: Characteristics by Attrition 

** Child Characteristics
dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0, by(midline, tests nototal) sample("Sample freq(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("X-tics of Children at Baseline by Attrition at Midline") ///
note("pearson test") ///
export(Mainpaper_Attri_childxticsmid.xlsx, replace)

dtable i.sex_chld age_chld wt_chld ht_chld muac_chld if time_datacollect==0, by(endline, tests nototal) sample("Sample freq(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("X-tics of Children at Baseline by Attrition at Endline") ///
note("pearson test") ///
export(Mainpaper_Attri_childxticsend.xlsx, replace)

** Child Z scores
dtable whz waz haz if time_datacollect==0, by(midline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Midline") ///
note("pearson test") ///
export(Mainpaper_Attri_zscoremid.xlsx, replace)

dtable whz waz haz if time_datacollect==0, by(endline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Endline") ///
note("pearson test") ///
export(Mainpaper_Attri_zscoreend.xlsx, replace)

** Outcome 
dtable i.wast_2cat i.wt_2cat if time_datacollect==0, by(midline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Midline") ///
export(Mainpaper_Attri_outcomemid.xlsx, replace)

dtable i.wast_2cat i.wt_2cat if time_datacollect==0, by(endline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("Outcomes of Children at Baseline by Attrition at Endline") ///
export(Mainpaper_Attri_outcomeend.xlsx, replace)

* Household food security indicators 

/*Note from Sydney's Review, need to replace household values that may hold data from multiple children*/
replace hhs_cat=. if ychld_tag0==0 & time_datacollect==0
replace hhs_cat=. if ychld_tag1==0 & time_datacollect==1
replace hhs_cat=. if ychld_tag2==0 & time_datacollect==2

replace fcs_cat_alt=. if ychld_tag0==0 & time_datacollect==0
replace fcs_cat_alt=. if ychld_tag1==0 & time_datacollect==1
replace fcs_cat_alt=. if ychld_tag2==0 & time_datacollect==2

replace rCSI=. if ychld_tag0==0 & time_datacollect==0
replace rCSI=. if ychld_tag1==0 & time_datacollect==1
replace rCSI=. if ychld_tag2==0 & time_datacollect==2

dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0, by(midline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("HH Food Security at Baseline by Attrition at Midline") ///
export(Mainpaper_Attri_foodsecuritymid.xlsx, replace)

dtable i.hhs_cat i.fcs_cat_alt rCSI if time_datacollect==0, by(endline, nototal tests nototal) sample("Sample N(%)") nformat(%6.2f proportions) column(by(hide)) title("HH Food Security at Baseline by Attrition at Endline") ///
export(Mainpaper_Attri_foodsecurityend.xlsx, replace)


** Table 2: Prevalence by ITT analysis 
**# Bookmark #1
use R2HC_MainPaperData.dta, clear

** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect  
xtdescribe
** Tagging panel observations and their patterns
by id_child (time_datacollect), sort: gen obs_counts = _N
tab id_child if obs_counts ==3 // this will list those with less than 2 observations 

xtreg whz     // using whz as a continous variable 
* Rho p-value is not significant (0.56)- means there is a panel effect 
* Use panel analysis 

* Choosing between random vs fixed effect model 
/* •H0-random effect model is consistent. 
•	Ha- fixed effect model is consistent. 
•	If p-val >0.05 we accept H0 & random effect is consistent 
•	If p-val <0.05 we reject H0 and use fixed effect
*/
xtreg whz i.time_datacollect i.arm,fe // F test prpb= <0.001 means fixed effect test is appropriate 
estimates store FE

xtreg whz i.time_datacollect i.arm,re
estimates store RE
xttest0 // (Breusch and Pagan Lagrangian multiplier test for random effects)p-value 0.0000 meaning random effect is also appropriate (refused polled OLS)

* Test to choose fixed or random
hausman FE RE // p-value = 0.6786. On this basis, it means random effect model is appropriate (variations across the samples have some effect on the observed results)


 ** child outcome
xtreg whz i.time_datacollect, re robust
margins time_datacollect
marginsplot

xtreg whz i.time_datacollect i.arm, re robust
margins time_datacollect#arm
marginsplot

xtreg whz i.time_datacollect i.arm i.region, re robust
margins time_datacollect#arm#region
marginsplot, by(region)

xtreg whz i.time_datacollect region##arm, re robust
margins time_datacollect#arm#region
marginsplot,by(region)

*** WHZ-Unadjusted continous 
bysort id_child (time_datacollect): gen dd_eb1 = whz[_n]-whz[_n-2] // Endline-baseline 
regress dd_eb1 ibn.arm, noconstant cformat(%6.3f)
pwmean dd_eb1, over(arm) mcompare(tukey) effects

bysort id_child (time_datacollect): gen dd_mb1 = whz[_n-1]-whz[_n-2]  // Midline-baseline
regress dd_mb1 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_em1 = whz[_n]-whz[_n-1]  // Endline-Midline
regress dd_em1 ibn.arm, noconstant cformat(%6.3f)


/** WHZ - By region
oneway dd_eb1 arm if region==0, tabulate
oneway dd_mb1 arm if region==0, tabulate
oneway dd_em1 arm if region==0, tabulate


oneway dd_eb1 arm if region==1, tabulate
oneway dd_mb1 arm if region==1, tabulate
oneway dd_em1 arm if region==1, tabulate

anova dd_em1 i.arm if region==1
** WHZ - By age group
tab age_chld_2gps
tab age_chld_2gps,nolabel

oneway dd_eb1 arm if age_chld_2gps==0, tabulate
oneway dd_mb1 arm if age_chld_2gps==0, tabulate
oneway dd_em1 arm if age_chld_2gps==0, tabulate

oneway dd_eb1 arm if age_chld_2gps==1, tabulate
oneway dd_mb1 arm if age_chld_2gps==1, tabulate
oneway dd_em1 arm if age_chld_2gps==1, tabulate

regress,baselevels
*/

*** WAZ-Unadjusted 
bysort id_child (time_datacollect): gen dd_eb3 = waz[_n]-waz[_n-2]  // Endline-baseline 
regress dd_eb3 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_mb3 = waz[_n-1]-waz[_n-2]  // Midline-baseline
regress dd_mb3 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_em3 = waz[_n]-waz[_n-1]  // Endline-Midline
regress dd_em3 ibn.arm, noconstant cformat(%6.3f)

*** HAZ-Unadjusted 
bysort id_child (time_datacollect): gen dd_eb4 = haz[_n]-haz[_n-2]  // Endline-baseline 
regress dd_eb4 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_mb4 = haz[_n-1]-haz[_n-2]  // Midline-baseline
regress dd_mb4 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_em4 = haz[_n]-haz[_n-1]  // Endline-Midline
regress dd_em4 ibn.arm, noconstant cformat(%6.3f)

*** MUAC-Unadjusted 
bysort id_child (time_datacollect): gen dd_eb2 = muac_chld[_n]-muac_chld[_n-2]  // Endline-baseline 
regress dd_eb2 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_mb2 = muac_chld[_n-1]-muac_chld[_n-2]  // Midline-baseline
regress dd_mb2 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_em2 = muac_chld[_n]-muac_chld[_n-1]  // Endline-Midline
regress dd_em2 ibn.arm, noconstant cformat(%6.3f)

*** MUAC Mother-Unadjusted 
tab muac_mother

bysort id_child (time_datacollect): gen dd_eb5 = muac_mother[_n]-muac_mother[_n-2]  // Endline-baseline 
regress dd_eb5 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_mb5 = muac_mother[_n-1]-muac_mother[_n-2]  // Midline-baseline
regress dd_mb5 ibn.arm, noconstant cformat(%6.3f)

bysort id_child (time_datacollect): gen dd_em5 = muac_mother[_n]-muac_mother[_n-1]  // Endline-Midline
regress dd_em5 ibn.arm, noconstant cformat(%6.3f)


* Child outcome ITT analysis with partial adjustment for child age, sex, cluster, baseline wasting by whz

** Continous 
bysort id_child (time_datacollect):gen whz_baseline= whz if time_datacollect==0
replace whz_baseline = whz_baseline[_n-1] if missing(whz_baseline) 

bysort id_child (time_datacollect):gen wast_2cat_baseline= wast_2cat if time_datacollect==0
replace wast_2cat_baseline = wast_2cat_baseline[_n-1] if missing(wast_2cat_baseline) 

* whz
regress dd_eb1 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_mb1 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_em1 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)

* waz
regress dd_eb3 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_mb3 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_em3 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)

* haz
regress dd_eb4 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_mb4 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_em4 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)

* muac
regress dd_eb2 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_mb2 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_em2 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_mb5 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)
regress dd_em5 c.age_chld cluster i.sex_chld ibn.arm wast_2cat_baseline, noconstant cformat(%6.3f)


* Child outcome ITT analysis with full adjustment for child age, sex, cluster, baseline wasting by whz, IDP, HAZ, WAZ, Mother education, Monthly expenditure, sanitation and drinking water source 

* Displacement
tab displaced if time_datacollect==0
tab displaced,nolabel
replace displaced=. if displaced==1206
replace displaced = displaced[_n-1] if missing(displaced) 

* Baseline WAZ
bysort id_child (time_datacollect):gen wt_2cat_baseline= wt_2cat if time_datacollect==0
replace wt_2cat_baseline = wt_2cat_baseline[_n-1] if missing(wt_2cat_baseline) 

* Baseline HAZ
bysort id_child (time_datacollect):gen stunt_2cat_baseline= stunt_2cat if time_datacollect==0
replace stunt_2cat_baseline = stunt_2cat_baseline[_n-1] if missing(stunt_2cat_baseline)

* Mother education 
tab edu if time_datacollect==0
bysort id_child (time_datacollect):gen edu_baseline= edu if time_datacollect==0
replace edu_baseline = edu_baseline[_n-1] if missing(edu_baseline) 

* Mothly expenditure 
tab exp_monthly_total if time_datacollect==0
bysort id_child (time_datacollect):gen exp_monthly_total_baseline= exp_monthly_total if time_datacollect==0
replace exp_monthly_total_baseline = exp_monthly_total_baseline[_n-1] if missing(exp_monthly_total_baseline)

* Sanitation (toilet)
tab toilet
bysort id_child (time_datacollect):gen toilet_baseline= toilet if time_datacollect==0
replace toilet_baseline = toilet_baseline[_n-1] if missing(toilet_baseline)

* Water source 
tab water_source
bysort id_child (time_datacollect):gen water_source_baseline= water_source if time_datacollect==0
replace water_source_baseline = water_source_baseline[_n-1] if missing(water_source_baseline)


* whz
regress dd_eb1 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_mb1 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_em1 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)

* waz
regress dd_eb3 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_mb3 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_em3 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)

* haz
regress dd_eb4 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_mb4 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_em4 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)

* muac
regress dd_eb2 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_mb2 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_em2 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_mb5 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)
regress dd_em5 c.age_chld cluster i.sex_chld ibn.arm i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline, noconstant cformat(%6.3f)

/*
xtdidregress dd_eb1 arm age_chld sex_chld
coefplot, xline(0) mlabel format(%9.2g) mlabposition(12) mlabgap(*2) coeflabel(, wrap(20)) drop(_cons)
margins arm, dydx(time_datacollect) pwcompare
marginsplot, by(arm)

xtdidregress (dd_eb1 arm age_chld sex_chld cluster)(id_child,continuous), group(arm) time(time_datacollect)

anova dd_eb1 arm age_chld sex_chld cluster
regress 

xtdidregress (recid) (did), group(id_child) time(time_datacollect)

regress dd_eb1 c.age_chld cluster i.sex_chld ibn.arm, noconstant
margins arm, pwcompare
marginsplot, by(arm)

margins arm

mixed whz i.arm age_chld sex_chld cluster || id_child:


anova y a##b c.x

anova dd_eb1 i.arm c.age_chld

oneway dd_eb1 i.arm c.age_chld, tabulate

xtmixed dd_eb1 arm##time_datacollect || id_child:, var reml

anova dd_eb1 arm / id_child|arm time_datacollect arm#time_datacollect, repeated(time_datacollect)


bysort id_child (time_datacollect): gen dd_mb11 = whz-L2.whz 
 gen diffHEMPE = ln_HEMPE - L20.ln_HEMPE
 
 by PanelID (Year), sort: gen diffHEMPE = ln_HEMPE - ln_HEMPE[_n-20]

bysort country: gen DD=variable1-variable1[_n-1]
*/
*****
**# Bookmark #1
********
* Figure 2(a) Child wasting by WHZ score over time using ITT (Table for the figure)
* Prevalence using ITT
use R2HC_MainPaperData.dta, clear 

** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

tab wated_child time_datacollect, col
ci proportions wated_child if time_datacollect==0 
ci proportions wated_child if time_datacollect==1 
ci proportions wated_child if time_datacollect==2 

**  Figure 2(b) Maternal wasting by MUAC over time by ITT (Table for the figure)
tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2

** Annex Figures 1a, b, c
* Child MUAC binary using ITT
tab wast_2muac time_datacollect, col
ci proportions wast_2muac if time_datacollect==0 
ci proportions wast_2muac if time_datacollect==1 
ci proportions wast_2muac if time_datacollect==2 

* Child Underweight binary using ITT
tab wt_2cat time_datacollect, col
ci proportions wt_2cat if time_datacollect==0 
ci proportions wt_2cat if time_datacollect==1 
ci proportions wt_2cat if time_datacollect==2 

* Child Stunting binary using ITT
tab stunt_2cat time_datacollect, col
ci proportions stunt_2cat if time_datacollect==0 
ci proportions stunt_2cat if time_datacollect==1 
ci proportions stunt_2cat if time_datacollect==2 

* Prevalence using PP:
use R2HC_MainPaperData.dta_prev_pp, clear
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect  

** Figure 2(a) Child wasting by WHZ PP
tab wated_child time_datacollect, col
ci proportions wated_child if time_datacollect==0 
ci proportions wated_child if time_datacollect==1 
ci proportions wated_child if time_datacollect==2 

**  Figure 2(b) Maternal wasting by MUAC
tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2

** Annex Figures 1
* Child MUAC binary
tab wast_2muac time_datacollect, col
ci proportions wast_2muac if time_datacollect==0 
ci proportions wast_2muac if time_datacollect==1 
ci proportions wast_2muac if time_datacollect==2 

* Child Underweight binary
tab wt_2cat time_datacollect, col
ci proportions wt_2cat if time_datacollect==0 
ci proportions wt_2cat if time_datacollect==1 
ci proportions wt_2cat if time_datacollect==2 

* Child Stunting binary
tab stunt_2cat time_datacollect, col
ci proportions stunt_2cat if time_datacollect==0 
ci proportions stunt_2cat if time_datacollect==1 
ci proportions stunt_2cat if time_datacollect==2 

* Incidence at midline using ITT approach--part A
use R2HC_MainPaperData.dta_Inc_ITT_baseline_child.dta, clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

** Figure 2(a) Child wasting by WHZ ITT_incidence at midline 
tab wast_2cat time_datacollect, col
ci proportions wast_2cat if time_datacollect==0 
ci proportions wast_2cat if time_datacollect==1 
ci proportions wast_2cat if time_datacollect==2 

* Incidence at midline using ITT approach-part B
use R2HC_MainPaperData.dta_Inc_ITT_midline_child.dta, replace
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

** Figure 2(a) Child wasting by WHZ ITT_incidence at endline 
tab wast_2cat time_datacollect, col
ci proportions wast_2cat if time_datacollect==0 
ci proportions wast_2cat if time_datacollect==1 
ci proportions wast_2cat if time_datacollect==2

**  Figure 2(b) Maternal wasting by MUAC ITT- Baseline 
use R2HC_MainPaperData.dta_Inc_ITT_baseline_mother.dta, clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2


**  Figure 2(b) Maternal wasting by MUAC ITT- Midline 
use R2HC_MainPaperData.dta_Inc_ITT_midline_mother.dta, clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2

** Annex Figures 1
* Child MUAC binary
tab wast_2muac time_datacollect, col
ci proportions wast_2muac if time_datacollect==0 
ci proportions wast_2muac if time_datacollect==1 
ci proportions wast_2muac if time_datacollect==2 

* Child Underweight binary
tab wt_2cat time_datacollect, col
ci proportions wt_2cat if time_datacollect==0 
ci proportions wt_2cat if time_datacollect==1 
ci proportions wt_2cat if time_datacollect==2 

* Child Stunting binary
tab stunt_2cat time_datacollect, col
ci proportions stunt_2cat if time_datacollect==0 
ci proportions stunt_2cat if time_datacollect==1 
ci proportions stunt_2cat if time_datacollect==2 

* Incidence using PP approach-Baseline
use R2HC_MainPaperData.dta_Inc_PP_bas_nowasting.dta,clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

** Figure 2(a) Child wasting by WHZ PP-baseline
tab wast_2cat time_datacollect, col
ci proportions wast_2cat if time_datacollect==0 
ci proportions wast_2cat if time_datacollect==1 
ci proportions wast_2cat if time_datacollect==2 



* Incidence using PP approach-Midline 
use R2HC_MainPaperData.dta_Inc_PP_mid_nowasting.dta, clear 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect 

** Figure 2(a) Child wasting by WHZ PP-midline 
tab wast_2cat time_datacollect, col
ci proportions wast_2cat if time_datacollect==0 
ci proportions wast_2cat if time_datacollect==1 
ci proportions wast_2cat if time_datacollect==2 



**  Figure 2(b) Maternal wasting by MUAC

use R2HC_MainPaperData.dta_Inc_PP_bas_nowasting_mother.dta, clear // baseline 
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect

tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2

use R2HC_MainPaperData.dta_Inc_PP_mid_nowasting_mother.dta, clear // Midline
** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect

tab matmuac_cat time_datacollect, col
ci proportions matmuac_cat if time_datacollect==0 
ci proportions matmuac_cat if time_datacollect==1 
ci proportions matmuac_cat if time_datacollect==2


** Annex Figures 1
* Child MUAC binary
tab wast_2muac time_datacollect, col
ci proportions wast_2muac if time_datacollect==0 
ci proportions wast_2muac if time_datacollect==1 
ci proportions wast_2muac if time_datacollect==2 

* Child Underweight binary
tab wt_2cat time_datacollect, col
ci proportions wt_2cat if time_datacollect==0 
ci proportions wt_2cat if time_datacollect==1 
ci proportions wt_2cat if time_datacollect==2 

* Child Stunting binary
tab stunt_2cat time_datacollect, col
ci proportions stunt_2cat if time_datacollect==0 
ci proportions stunt_2cat if time_datacollect==1 
ci proportions stunt_2cat if time_datacollect==2 


**# Bookmark #1
**# Bookmark #1


*******
** Figure 3 (a) Child wasting prevalence by arm over time by WHZ score (ITT)
use R2HC_MainPaperData.dta, clear 
tab wast_2cat time_datacollect if arm==1, col
ci proportions wast_2cat if time_datacollect==0 &arm==1
ci proportions wast_2cat if time_datacollect==1 &arm==1
ci proportions wast_2cat if time_datacollect==2 &arm==1

tab wast_2cat time_datacollect if arm==2, col
ci proportions wast_2cat if time_datacollect==0 &arm==2
ci proportions wast_2cat if time_datacollect==1 &arm==2
ci proportions wast_2cat if time_datacollect==2 &arm==2

tab wast_2cat time_datacollect if arm==3, col
ci proportions wast_2cat if time_datacollect==0 &arm==3
ci proportions wast_2cat if time_datacollect==1 &arm==3
ci proportions wast_2cat if time_datacollect==2 &arm==3

ci proportions wast_2cat wast_2muac if time_datacollect==0 & arm==3
  ci proportions wast_2cat wast_2muac if time_datacollect==1 & arm==3
   ci proportions wast_2cat wast_2muac if time_datacollect==2 & arm==3
 
 ** additional analysis:
** Figure 3 (b) Child wasting Incidence by arm over time by WHZ score (ITT)

use R2HC_MainPaperData.dta_Inc_PP_bas_nowasting.dta,clear 
xtset id_child time_datacollect 

tab wast_2cat time_datacollect if arm==1, col
tab wast_2cat time_datacollect if arm==2, col
tab wast_2cat time_datacollect if arm==3, col

ci proportions wast_2cat if time_datacollect==1 &arm==1
ci proportions wast_2cat if time_datacollect==1 &arm==2
ci proportions wast_2cat if time_datacollect==1 &arm==3

tabi 382 31 \ 405 29, chi2
tabi 382 31 \ 358 33, chi2
tabi 405 29 \ 358 33, chi2

**

use R2HC_MainPaperData.dta_Inc_PP_mid_nowasting.dta, clear 
xtset id_child time_datacollect 
tab wast_2cat time_datacollect if arm==1, col
tab wast_2cat time_datacollect if arm==2, col
tab wast_2cat time_datacollect if arm==3, col

ci proportions wast_2cat if time_datacollect==2 &arm==1
ci proportions wast_2cat if time_datacollect==2 &arm==2
ci proportions wast_2cat if time_datacollect==2 &arm==3

tabi 216 19 \ 231 14, chi2
tabi 216 19 \ 156 18, chi2
tabi 231 14 \ 156 18, chi2

** Figure 3 (b) Mother Wasting prevalence by MUAC score over time using ITT

format matmuac_cat %6.3f
tab matmuac_cat time_datacollect if arm==1, col
ci proportions matmuac_cat if time_datacollect==0 &arm==1
ci proportions matmuac_cat if time_datacollect==1 &arm==1
ci proportions matmuac_cat if time_datacollect==2 &arm==1

tab matmuac_cat time_datacollect if arm==2, col
ci proportions matmuac_cat if time_datacollect==0 &arm==2
ci proportions matmuac_cat if time_datacollect==1 &arm==2
ci proportions matmuac_cat if time_datacollect==2 &arm==2

tab matmuac_cat time_datacollect if arm==3, col
ci proportions matmuac_cat if time_datacollect==0 &arm==3
ci proportions matmuac_cat if time_datacollect==1 &arm==3
ci proportions matmuac_cat if time_datacollect==2 &arm==3


dtable whz muac_chld waz haz  muac_mother if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.1f mean sd min max) column(by(hide)) title("Z-score") ///
export(PrevalenceITT_Arm1.xlsx, replace)

dtable whz muac_chld waz haz  muac_mother if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.1f mean sd min max) column(by(hide)) title("Z-score") ///
export(PrevalenceITT_Arm2.xlsx, replace)

dtable whz muac_chld waz haz  muac_mother if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.1f mean sd min max) column(by(hide)) title("Z-score") ///
export(PrevalenceITT_Arm3.xlsx, replace)

tabi 552 80 \ 546 69, chi2
tabi 552 80 \ 450 76, chi2
tabi 546 69 \ 450 76, chi2

format whz waz haz %9.3f
ci mean whz waz haz if time_datacollect==0 
ci mean whz waz haz if time_datacollect==1
ci mean whz waz haz if time_datacollect==2


tabstat  muac_chld, statistics( count mean sd min max) by(time_datacollect) format(%3.2f) 
    hist  muac_chld, normal color(gray)
	hist muac_chld, by(time_datacollect)
    graph box   muac_chld
	graph box   muac_chld, over (time_datacollect) 
	
****************
* Table 3: Difference in differences of child and maternal wasting outcomes (Prevalence analysis using ITT Approach)
use R2HC_MainPaperData.dta, clear

/*Note from Sydney's Analysis: to have the correct mother values, we need to drop any duplicate mother records stored under multiple children in the same household*/
replace muac_mother=. if ychld_tag0==0 & time_datacollect==0
replace muac_mother=. if ychld_tag1==0 & time_datacollect==1
replace muac_mother=. if ychld_tag2==0 & time_datacollect==2

replace matmuac_cat=. if ychld_tag0==0 & time_datacollect==0
replace matmuac_cat=. if ychld_tag1==0 & time_datacollect==1
replace matmuac_cat=. if ychld_tag2==0 & time_datacollect==2

** xtset
isid id_child time_datacollect 
xtset id_child time_datacollect  
xtdescribe

* Unadjusted model
xtlogit wast_2cat arm##time_datacollect,or
xtlogit wt_2cat arm##time_datacollect,or
xtlogit stunt_2cat arm##time_datacollect,or
xtlogit wast_2muac arm##time_datacollect,or
xtlogit matmuac_cat arm##time_datacollect,or

dtable i.wast_2cat, by(time_datacollect, tests testnotes nototal) 
dtable i.wt_2cat, by(time_datacollect, tests testnotes nototal)
dtable  i.stunt_2cat, by(time_datacollect, tests testnotes nototal)
dtable i.wast_2muac, by(time_datacollect, tests testnotes nototal)
dtable i.matmuac_cat, by(time_datacollect, tests testnotes nototal)

** WHZ- Categorical (partially adjusted model)
xtlogit wast_2cat arm##time_datacollect age_chld cluster sex_chld wast_2cat_baseline,or
xtlogit wt_2cat arm##time_datacollect age_chld cluster sex_chld wast_2cat_baseline,or
xtlogit stunt_2cat arm##time_datacollect age_chld cluster sex_chld wast_2cat_baseline,or
xtlogit wast_2muac arm##time_datacollect age_chld cluster sex_chld wast_2cat_baseline,or
xtlogit matmuac_cat arm##time_datacollect age_chld cluster sex_chld wast_2cat_baseline,or

** WHZ- Categorical (Fully adjusted)
xtlogit wast_2cat arm##time_datacollect age_chld cluster sex_chld i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline,or

xtlogit wt_2cat arm##time_datacollect age_chld cluster sex_chld i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline,or

xtlogit stunt_2cat arm##time_datacollect age_chld cluster sex_chld i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline,or

xtlogit wast_2muac arm##time_datacollect age_chld cluster sex_chld i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline,or

xtlogit matmuac_cat arm##time_datacollect age_chld cluster sex_chld i.wast_2cat_baseline i.displaced i.wt_2cat_baseline i.stunt_2cat_baseline i.edu_baseline c.exp_monthly_total_baseline i.toilet_baseline i.water_source_baseline,or


* Table 4: Wasting Drivers over time 
use R2HC_MainPaperData.dta, clear
isid id_child time_datacollect 
xtset id_child time_datacollect  

* Immediate Indicators 
dtable i.mdd_c i.mdd_animalprotein i.illness_last2wks if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Immediate Factors") ///
export(Immediate_arm1.xlsx, replace)
proportion mdd_c mdd_animalprotein illness_last2wks if arm==1 & time_datacollect==0
proportion mdd_c mdd_animalprotein illness_last2wks if arm==1 & time_datacollect==1
proportion mdd_c mdd_animalprotein illness_last2wks if arm==1 & time_datacollect==2

dtable i.mdd_c i.mdd_animalprotein i.illness_last2wks if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Immediate Factors") ///
export(Immediatefactors_arm2.xlsx, replace)
proportion mdd_c mdd_animalprotein illness_last2wks if arm==2 & time_datacollect==0
proportion mdd_c mdd_animalprotein illness_last2wks if arm==2 & time_datacollect==1
proportion mdd_c mdd_animalprotein illness_last2wks if arm==2 & time_datacollect==2

dtable i.mdd_c i.mdd_animalprotein i.illness_last2wks if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Immediate Factors") ///
export(Immediatefactors_arm3.xlsx, replace)
proportion mdd_c mdd_animalprotein illness_last2wks if arm==3 & time_datacollect==0
proportion mdd_c mdd_animalprotein illness_last2wks if arm==3 & time_datacollect==1
proportion mdd_c mdd_animalprotein illness_last2wks if arm==3 & time_datacollect==2


sort hhid 
tabstat mdd_c mdd_animalprotein illness_last2wks if ychld_tag0==1, stat(N)
tabstat mdd_c mdd_animalprotein illness_last2wks if ychld_tag1==1, stat(N)
tabstat mdd_c mdd_animalprotein illness_last2wks if ychld_tag2==1, stat(N)

tabstat hhid if ychld_tag0==1, stat(N)
tabstat hhid if ychld_tag1==1, stat(N)
tabstat hhid if ychld_tag2==1, stat(N)

** Underlying Factors 

tab hhs_cat
tab hhs_cat,nolabel
recode hhs_cat (0=0 "litte to No Hunger") (1=1 "Moderate to Severe Hunger") (2=1 "Moderate to Severe Hunger"), generate(hhs_cat_2gps)

tab fcs_cat_alt
tab fcs_cat_alt,nolabel
recode fcs_cat_alt (0=0 "Poor or Borderline") (1=0 "Poor or Borderline") (2=1 "Acceptable"), generate(fcs_cat_2gps)

dtable i.hhs_cat_2gps i.fcs_cat_2gps rCSI i.vacc_yesno i.crowding_cat i.toilet i.water_source i.acc_handwash i.init_bfding_know i.init_bfding_pract  i.ex_bfeeding i.ex_bfeeding_prac i.age_init_sol_knowge i.age_init_sol_prac if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Underlying Factors") ///
export(Underlying_arm1.xlsx, replace)

proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash if arm==1 & time_datacollect==0
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==1 & time_datacollect==1
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==1 & time_datacollect==2

ci mean rCSI if arm==1 & time_datacollect==0
ci mean rCSI if arm==1 & time_datacollect==1
ci mean rCSI if arm==1 & time_datacollect==2

dtable i.hhs_cat_2gps i.fcs_cat_2gps rCSI i.vacc_yesno i.crowding_cat i.toilet i.water_source i.acc_handwash i.init_bfding_know i.init_bfding_pract  i.ex_bfeeding i.ex_bfeeding_prac i.age_init_sol_knowge i.age_init_sol_prac if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Underlying Factors") ///
export(Underlying_arm2.xlsx, replace)

proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash if arm==2 & time_datacollect==0
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==2 & time_datacollect==1
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==2 & time_datacollect==2

ci mean rCSI if arm==2 & time_datacollect==0
ci mean rCSI if arm==2 & time_datacollect==1
ci mean rCSI if arm==2 & time_datacollect==2

dtable i.hhs_cat_2gps i.fcs_cat_2gps rCSI i.vacc_yesno i.crowding_cat i.toilet i.water_source i.acc_handwash i.init_bfding_know i.init_bfding_pract  i.ex_bfeeding i.ex_bfeeding_prac i.age_init_sol_knowge i.age_init_sol_prac if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f mean proportions sd) column(by(hide)) title("Underlying Factors") ///
export(Underlying_arm3.xlsx, replace)

proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash if arm==3 & time_datacollect==0
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==3 & time_datacollect==1
proportion hhs_cat_2gps fcs_cat_2gps vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if arm==3 & time_datacollect==2

ci mean rCSI if arm==3 & time_datacollect==0
ci mean rCSI if arm==3 & time_datacollect==1
ci mean rCSI if arm==3 & time_datacollect==2


tab hhs_cat time_datacollect, col
tab fcs_cat time_datacollect, col
tab rCSI time_datacollect, col
tab vacc_yesno time_datacollect, col
tab crowding_cat time_datacollect, col
tab toilet time_datacollect, col
tab water_source time_datacollect, col
tab acc_handwash time_datacollect, col
tab init_bfding_know time_datacollect, col
tab init_bfding_pract time_datacollect, col
tab ex_bfeeding time_datacollect, col
tab ex_bfeeding_prac time_datacollect, col
tab age_init_sol_knowge time_datacollect, col
tab age_init_sol_prac time_datacollect, col

tabstat hhs_cat_2gps fcs_cat_2gps rCSI vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract  ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac, by(time_datacollect) stat(N)

sort hhid 
tabstat hhs_cat_2gps fcs_cat_2gps rCSI vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract  ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if ychld_tag0==1, stat(N)
tabstat hhs_cat_2gps fcs_cat_2gps rCSI vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract  ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if ychld_tag1==1, stat(N)
tabstat hhs_cat_2gps fcs_cat_2gps rCSI vacc_yesno crowding_cat toilet water_source acc_handwash init_bfding_know init_bfding_pract  ex_bfeeding ex_bfeeding_prac age_init_sol_knowge age_init_sol_prac if ychld_tag2==1, stat(N)

** Basic factors 
tab decision_income
tab decision_income, nolabel
recode decision_income (1=1 "Mother or Jointly") (2=1 "Mother or Jointly") (3=2 "Father"), generate(decision_income_2gps)
tab decision_income_2gps

tab decision_healthcare
tab decision_healthcare,nolabel
recode decision_healthcare (1=1 "Mother or Jointly") (2=1 "Mother or Jointly") (3=2 "Father"), generate(decision_healthcare_2gps)


bysort id_child (time_datacollect): gen Exp_foodpercent = (exp_food_monthly/exp_monthly_total)*100
tab Exp_foodpercent


dtable Exp_foodpercent i.edu i.decision_income_2gps i.decision_healthcare_2gps i.num_u5_child2 if arm==1, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f median proportions sd) column(by(hide)) title("Basic Factors") ///
export(basic_arm1.xlsx, replace)
tabstat exp_monthly_total if arm==1, by(time_datacollect) stat(N median mean min max) nototal // to get median instead of mean

bysort time_datacollect: centile exp_monthly_total if arm==1, centile(50)
bysort time_datacollect: ci mean Exp_foodpercent if arm==1

proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==1 & time_datacollect==0
proportion decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==1 & time_datacollect==1
proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==1 & time_datacollect==2

dtable Exp_foodpercent i.edu i.decision_income_2gps i.decision_healthcare_2gps i.num_u5_child2 if arm==2, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f median proportions sd) column(by(hide)) title("Basic Factors") ///
export(basic_arm2.xlsx, replace)
tabstat exp_monthly_total if arm==2, by(time_datacollect) stat(N median mean min max) nototal // to get median instead of mean

bysort time_datacollect: centile exp_monthly_total if arm==2, centile(50)
bysort time_datacollect: ci mean Exp_foodpercent if arm==2

proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==2 & time_datacollect==0
proportion decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==2 & time_datacollect==1
proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==2 & time_datacollect==2

dtable Exp_foodpercent i.edu i.decision_income_2gps i.decision_healthcare_2gps i.num_u5_child2 if arm==3, by(time_datacollect, nototal tests) sample("Sample N(%)") nformat(%6.2f median proportions sd) column(by(hide)) title("Basic Factors") ///
export(basic_arm3.xlsx, replace)
tabstat exp_monthly_total if arm==3, by(time_datacollect) stat(N median mean min max) nototal // to get median instead of mean

bysort time_datacollect: centile exp_monthly_total if arm==3, centile(50)
bysort time_datacollect: ci mean Exp_foodpercent if arm==3

proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==3 & time_datacollect==0
proportion decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==3 & time_datacollect==1
proportion edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if arm==3 & time_datacollect==2

tabstat Exp_foodpercent, by(time_datacollect) stats (N, mean p50)

tab exp_monthly_total time_datacollect, col
tab edu time_datacollect, col
tab decision_income_2gps time_datacollect, col
tab decision_healthcare_2gps time_datacollect, col
tab num_u5_child2 time_datacollect, col

sort hhid 
tabstat exp_food_monthly Exp_foodpercent edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if ychld_tag0==1, stat(N)
tabstat exp_food_monthly Exp_foodpercent edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if ychld_tag1==1, stat(N)
tabstat exp_food_monthly Exp_foodpercent edu decision_income_2gps decision_healthcare_2gps num_u5_child2 if ychld_tag2==1, stat(N)

** Annex Table 3

** Bay
* whz
regress dd_eb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==0, noconstant cformat(%6.3f)

** Hiran
* whz
regress dd_eb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==1, noconstant cformat(%6.3f)

* Age <2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* Age >=2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

**////////////////////
** Annex Table 4
use R2HC_MainPaperData.dta_prev_pp.dta, clear 

* WHZ
bysort id_child (time_datacollect): gen dd_eb1 = whz[_n]-whz[_n-2] // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb1 = whz[_n-1]-whz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em1 = whz[_n]-whz[_n-1]  // Endline-Midline

* WAZ

bysort id_child (time_datacollect): gen dd_eb3 = waz[_n]-waz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb3 = waz[_n-1]-waz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em3 = waz[_n]-waz[_n-1]  // Endline-Midline

* HAZ
bysort id_child (time_datacollect): gen dd_eb4 = haz[_n]-haz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb4 = haz[_n-1]-haz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em4 = haz[_n]-haz[_n-1]  // Endline-Midline

* MUAC
bysort id_child (time_datacollect): gen dd_eb2 = muac_chld[_n]-muac_chld[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb2 = muac_chld[_n-1]-muac_chld[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em2 = muac_chld[_n]-muac_chld[_n-1]  // Endline-Midline

* MUAC Mother
bysort id_child (time_datacollect): gen dd_eb5 = muac_mother[_n]-muac_mother[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb5 = muac_mother[_n-1]-muac_mother[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em5 = muac_mother[_n]-muac_mother[_n-1]  // Endline-Midline


****
* Overall
* WHZ
regress dd_eb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm, noconstant cformat(%6.3f)
*WAZ
regress dd_eb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm, noconstant cformat(%6.3f)
*HAZ
regress dd_eb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm, noconstant cformat(%6.3f)
*MUAC
regress dd_eb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm, noconstant cformat(%6.3f)
*MUAC Mother
regress dd_eb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm, noconstant cformat(%6.3f)

** Bay
* whz
regress dd_eb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==0, noconstant cformat(%6.3f)

** Hiran
* whz
regress dd_eb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==1, noconstant cformat(%6.3f)

* Age <2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* Age >=2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

**////////////////////
** Annex Table 5
use R2HC_MainPaperData.dta_Inc_ITT.dta, clear 

* WHZ
bysort id_child (time_datacollect): gen dd_eb1 = whz[_n]-whz[_n-2] // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb1 = whz[_n-1]-whz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em1 = whz[_n]-whz[_n-1]  // Endline-Midline

* WAZ

bysort id_child (time_datacollect): gen dd_eb3 = waz[_n]-waz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb3 = waz[_n-1]-waz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em3 = waz[_n]-waz[_n-1]  // Endline-Midline

* HAZ
bysort id_child (time_datacollect): gen dd_eb4 = haz[_n]-haz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb4 = haz[_n-1]-haz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em4 = haz[_n]-haz[_n-1]  // Endline-Midline

* MUAC
bysort id_child (time_datacollect): gen dd_eb2 = muac_chld[_n]-muac_chld[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb2 = muac_chld[_n-1]-muac_chld[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em2 = muac_chld[_n]-muac_chld[_n-1]  // Endline-Midline

* MUAC Mother
bysort id_child (time_datacollect): gen dd_eb5 = muac_mother[_n]-muac_mother[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb5 = muac_mother[_n-1]-muac_mother[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em5 = muac_mother[_n]-muac_mother[_n-1]  // Endline-Midline


****
* Overall
* WHZ
regress dd_eb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm, noconstant cformat(%6.3f)
*WAZ
regress dd_eb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm, noconstant cformat(%6.3f)
*HAZ
regress dd_eb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm, noconstant cformat(%6.3f)
*MUAC
regress dd_eb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm, noconstant cformat(%6.3f)
*MUAC Mother
regress dd_eb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm, noconstant cformat(%6.3f)

** Bay
* whz
regress dd_eb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==0, noconstant cformat(%6.3f)

** Hiran
* whz
regress dd_eb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==1, noconstant cformat(%6.3f)

* Age <2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* Age >=2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)


**////////////////////
** Annex Table 6
use R2HC_MainPaperData.dta_Inc_PP.dta, clear 

* WHZ
bysort id_child (time_datacollect): gen dd_eb1 = whz[_n]-whz[_n-2] // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb1 = whz[_n-1]-whz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em1 = whz[_n]-whz[_n-1]  // Endline-Midline

* WAZ

bysort id_child (time_datacollect): gen dd_eb3 = waz[_n]-waz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb3 = waz[_n-1]-waz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em3 = waz[_n]-waz[_n-1]  // Endline-Midline

* HAZ
bysort id_child (time_datacollect): gen dd_eb4 = haz[_n]-haz[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb4 = haz[_n-1]-haz[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em4 = haz[_n]-haz[_n-1]  // Endline-Midline

* MUAC
bysort id_child (time_datacollect): gen dd_eb2 = muac_chld[_n]-muac_chld[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb2 = muac_chld[_n-1]-muac_chld[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em2 = muac_chld[_n]-muac_chld[_n-1]  // Endline-Midline

* MUAC Mother
bysort id_child (time_datacollect): gen dd_eb5 = muac_mother[_n]-muac_mother[_n-2]  // Endline-baseline 
bysort id_child (time_datacollect): gen dd_mb5 = muac_mother[_n-1]-muac_mother[_n-2]  // Midline-baseline
bysort id_child (time_datacollect): gen dd_em5 = muac_mother[_n]-muac_mother[_n-1]  // Endline-Midline


****
* Overall
* WHZ
regress dd_eb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm, noconstant cformat(%6.3f)
*WAZ
regress dd_eb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm, noconstant cformat(%6.3f)
*HAZ
regress dd_eb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm, noconstant cformat(%6.3f)
*MUAC
regress dd_eb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm, noconstant cformat(%6.3f)
*MUAC Mother
regress dd_eb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm, noconstant cformat(%6.3f)

** Bay
* whz
regress dd_eb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==0, noconstant cformat(%6.3f)

** Hiran
* whz
regress dd_eb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if region==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if region==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if region==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if region==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if region==1, noconstant cformat(%6.3f)

* Age <2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==0, noconstant cformat(%6.3f)

* Age >=2 years
* whz
regress dd_eb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em1 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* waz
regress dd_eb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em3 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* haz
regress dd_eb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em4 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac
regress dd_eb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em2 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

* muac mother
regress dd_eb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_mb5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)
regress dd_em5 ibn.arm if age_chld_2gps==1, noconstant cformat(%6.3f)

** Annex Table 7

** By region
* Bay
xtlogit wast_2cat arm##time_datacollect if region==0, or
xtlogit wt_2cat arm##time_datacollect if region==0, or
xtlogit stunt_2cat arm##time_datacollect if region==0, or
xtlogit wast_2muac arm##time_datacollect if region==0, or
xtlogit matmuac_cat arm##time_datacollect if region==0, or

*Hiran
xtlogit wast_2cat arm##time_datacollect if region==1, or
xtlogit wt_2cat arm##time_datacollect if region==1, or
xtlogit stunt_2cat arm##time_datacollect if region==1, or
xtlogit wast_2muac arm##time_datacollect if region==1, or
xtlogit matmuac_cat arm##time_datacollect if region==1, or

** By age
* <2 years 
xtlogit wast_2cat arm##time_datacollect if age_chld_2gps==0, or
xtlogit wt_2cat arm##time_datacollect if age_chld_2gps==0, or
xtlogit stunt_2cat arm##time_datacollect if age_chld_2gps==0, or
xtlogit wast_2muac arm##time_datacollect if age_chld_2gps==0, or
xtlogit matmuac_cat arm##time_datacollect if age_chld_2gps==0, or
*>= 2 years
xtlogit wast_2cat arm##time_datacollect if age_chld_2gps==1, or
xtlogit wt_2cat arm##time_datacollect if age_chld_2gps==1, or
xtlogit stunt_2cat arm##time_datacollect if age_chld_2gps==1, or
xtlogit wast_2muac arm##time_datacollect if age_chld_2gps==1, or
xtlogit matmuac_cat arm##time_datacollect if age_chld_2gps==1, or




*////////////
Other codes 
* UNADJUSTED Binary 
dtable i.wast_2cat i.wt_2cat i.stunt_2cat i.wast_2muac i.matmuac_cat if arm==1, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("WHZ_Arm1") ///
export(Mainpaper_WHZ_Arm1.xlsx, replace)

dtable i.wast_2cat i.wt_2cat i.stunt_2cat i.wast_2muac i.matmuac_cat if arm==2, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("WHZ_Arm2") ///
export(Mainpaper_WHZ_Arm2.xlsx, replace)

dtable i.wast_2cat i.wt_2cat i.stunt_2cat i.wast_2muac i.matmuac_cat if arm==3, by(time_datacollect, tests nototal) sample("Sample: freq(%)") nformat(%6.1f mean proportions sd) title("WHZ_Arm3") ///
export(Mainpaper_WHZ_Arm3.xlsx, replace)

* Arm 1
prtesti 100 0.15 100 0.147
prtesti 100 0.13 100 0.147
prtesti 100 0.15 100 0.13

* Arm 2
prtesti 100 0.101 100 0.15
prtesti 100 0.091 100 0.15
prtesti 100 0.101 100 0.091

* Arm 3
prtesti 100 0.174 100 0.155
prtesti 100 0.151 100 0.155
prtesti 100 0.174 100 0.151




