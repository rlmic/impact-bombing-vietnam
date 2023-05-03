
clear
set more off
set mem 60m
#delimit ;

log using war_may04, t replace;


cd DSCA;
use DSCAdata;
sort district;
save DSCAdata, replace;
clear;


cd ..;
cd IFPRI;
insheet using SES-data.csv;

cd ..;
cd DSCA;
sort district;
merge district using DSCAdata;

drop _merge*;

cd ..;


/* GENERATE PROPORTIONS */
gen lit_rate = literate_15plus/pop_15plus;
gen elec_rate = hh_elec/no_hh;
gen tv_rate = hh_tv/no_hh;
gen radio_rate = hh_radio/no_hh;


/* GENERATE PROVINCE FE */;
tab province, gen(Iprovince);
drop Iprovince1;


/* ORDNANCE */;
global ord1 = "Cannon_Artillery Cluster_Bomb Fuel_Air_Explosive General_Purpose Missile Rocket";
global ord2 = "Grenade Mine Submunition";
global ord3 = "Chemical Incendiary W WP";
global ord4 = "A AAC AC ACC";
global ord5 = "HC HCC HCP HCPD HCVT HE HECVT HEPD HP HVTF";
global ord6 = "ILL ILLUM ILUM";
global ord7 = "MK MK07 MK10 MK12 MK7 MK70 MK8";
global ord8 = "RAGON RAP SHRKE VC VT VTN VTNSD VTSD";


summ;


foreach var in
	poverty_p0 poverty_p1 poverty_p2
	lit_rate elect_rate tv_rate radio_rate
{;
regress `var' $ord1 $ord2 $ord3, robust cluster(province);
regress `var' $ord1 $ord2 $ord3 Iprovince*, robust cluster(province);

regress `var' $ord1 $ord2 $ord3 $ord4 $ord5 $ord8, robust cluster(province);
regress `var' $ord1 $ord2 $ord3 $ord4 $ord5 $ord8 Iprovince*, robust cluster(province);
};


log c;
