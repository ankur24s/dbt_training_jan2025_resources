select distinct zcc.CCDESC_Description,iimloc.ILENTY_Entity_Code
from `prod`.`silver_bpcse`.`src_iimloc_bpcse` as iimloc
    join `prod`.`silver_bpcse`.`src_iim_bpcse` as iim
        on iimloc.ILLSKU_Local_SKU = iim.IPROD_Item_Number
    join `prod`.`silver_bpcse`.`src_zcc_bpcse` as zcc
	    on --iimloc.ILENTY_Entity_Code = zcc.CCDESC_Description and 
	     zcc.CCTABL_Table_ID ='DATAWHSE'
	    and zcc.CCCODE_Primary_Code = 'ENTITY01'
		where zcc.CCNOT1_Note_1 = '01' and iimloc.ILLSKU_Local_SKU in (
		'26961',
		'665723',
		'15416',
		'750045',
		'020-00279',
		'15116',
		'2697',
		'644880',
		'77885',
		'9893607',
		'GCP04523',
		'6121706',
		'020-00286',
		'2796',
		'99089',
		'88960',
		'678212-10',
		'77792',
		'669501',
		'688102',
		'2698',
		'79362',
		'27971',
		'669502',
		'80529',
		'27961',
		'26941',
		'850810',
		'27981')
		
		------------------main query
		
		select zcc.CCDESC_Description,iimloc.ILENTY_Entity_Code, 
 'BPCSE' 																				as SourceSystemName,
		concat('BPCSE_',zcc.CCNOT1_Note_1, '_', iimloc.ILLSKU_Local_SKU) 						as LocalProductBK,
		zcc.CCNOT1_Note_1 																		as CompanyCode,
		iimloc.ILLSKU_Local_SKU 																as LocalSKUCode,
		iim.IDESC_Item_Description 																as LocalSKUDesc,
		iimloc.ILGSKU_Global_SKU 																as GlobalSKUCode,
		iim.ICLAS_Item_Class 																	as ItemGroupCode,
      	iim.IITYP_Item_Type 																	as ItemTypeCode,
		iim.IITYP_Item_Type 																	as MaterialTypeCode,
      	iim.IMNNWU_Item_Net_Net_Weight_Stk_UOM 													as NetWeight,
		iim.IUMS_Stocking_Unit_of_Measure 														as UnitOfMeasure,
		iimloc.ILUMCN_UOM_Conv 																	as UnitOfMeasureFactor,
		case when iim.IPROD_Item_Number is null then 0 else 1 end 								as LocalSKUStatusCode,
		-- DO6824: 4 additional fields below
		IIM.IITYP_Item_Type                                               						as MaterialCategoryCode,  
	--	ZPA.DATA_Parameter_file_data                                              				as MaterialCategoryDesc,
		IIM.ICLAS_Item_Class                                                       				as MaterialClassification,
/*		concat(
		    CASE 
		        WHEN HPO.PONIIT_Non_Inventory_Item0No_1Yes = '1' THEN 'Indirect'
		        ELSE 'Direct'
		    END,
        ' (',coalesce (TRIM(HPO.PONIIT_Non_Inventory_Item0No_1Yes), ''),')')              		as ProductSpendCategory,         -- D = Direct / I = Indirect. (Direct material is raw materials used in production.)
*/
		current_timestamp() as SourceReplicationTime,
		to_timestamp(concat(to_date(cast(cast(iimloc.ILDATE_Date_Created as bigint) as string), "yyyyMMdd"), ' ', 
        concat(left(case when length(cast(cast(iimloc.ILTIME_Time_Created as bigint) as string)) = 5 
		then concat('0', cast(cast(iimloc.ILTIME_Time_Created as bigint) as string)) 
            else cast(cast(iimloc.ILTIME_Time_Created as bigint) as string) end, 2), ':', 
			left(right(cast(iimloc.ILTIME_Time_Created as bigint), 4), 2), ':', right(cast(iimloc.ILTIME_Time_Created as bigint), 2)))) 				as SourceCreatedDateTime,
   		to_timestamp(concat(to_date(cast(cast(iimloc.ILDATE_Date_Created as bigint) as string), "yyyyMMdd"), ' ', 
        concat(left(case when length(cast(cast(iimloc.ILTIME_Time_Created as bigint) as string)) = 5 
		then concat('0', cast(cast(iimloc.ILTIME_Time_Created as bigint) as string)) 
            else cast(cast(iimloc.ILTIME_Time_Created as bigint) as string) end, 2), ':', 
			left(right(cast(iimloc.ILTIME_Time_Created as bigint), 4), 2), ':', right(cast(iimloc.ILTIME_Time_Created as bigint), 2)))) 				as SourceModifiedDateTime,
    	current_timestamp()                                             						as IngestedDateTime,   --To do
    	current_timestamp()                                             						as DwModifiedDateTime
	from `prod`.`silver_bpcse`.`src_iimloc_bpcse` as iimloc
    join `prod`.`silver_bpcse`.`src_iim_bpcse` as iim
        on iimloc.ILLSKU_Local_SKU = iim.IPROD_Item_Number 
    join `prod`.`silver_bpcse`.`src_zcc_bpcse` as zcc
	    on --iimloc.ILENTY_Entity_Code = zcc.CCDESC_Description and 
	     zcc.CCTABL_Table_ID ='DATAWHSE'
	    and zcc.CCCODE_Primary_Code = 'ENTITY01'
/*	left outer join `prod`.`silver_bpcse`.`src_zpa_bpcse` as ZPA 
		on ZPA.PKEY_Parameter_File_Key = CONCAT('ITEMTYP' ,  ifnull(IIM.IITYP_Item_Type,''))
	left outer join `prod`.`silver_bpcse`.`src_hpo_bpcse` as HPO
		on IIM.IPROD_Item_Number = HPO.PPROD_Item_Number
		and zcc.CCCODE_Primary_Code = HPO.PBUYC_Buyer_Planner */
where zcc.CCNOT1_Note_1 = '01' and iimloc.ILLSKU_Local_SKU in (
'26961',
'665723',
'15416',
'750045',
'020-00279',
'15116',
'2697',
'644880',
'77885',
'9893607',
'GCP04523',
'6121706',
'020-00286',
'2796',
'99089',
'88960',
'678212-10',
'77792',
'669501',
'688102',
'2698',
'79362',
'27971',
'669502',
'80529',
'27961',
'26941',
'850810',
'27981')


