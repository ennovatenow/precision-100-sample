-- File -- File Name           : cu1_upload.sql
-- File Created for    : Upload file for CU1
-- Created By          : Kumaresan.B
-- Client              : ABK
-- Created On          : 19-05-2016
-------------------------------------------------------------------

truncate table CU1_O_TABLE;
insert into CU1_O_TABLE
select 
--   ORGKEY
    trim(gfpf.gfcus)||trim(gfpf.gfcpnc),               -- Done
--   v_CIF_ID                  CHAR(32)
     trim(gfpf.gfcus)||trim(gfpf.gfcpnc),           -- Done
--   v_ENTITYTYPE              CHAR(50)
        'CUSTOMER',                   -- DEFAULT SET TO 'CUSTOMER'
--   v_CUST_TYPE_CODE             CHAR(5)        -- Mapping Table Required
        --'INDIV',                                    --Values to be derived from BPD
        to_char(gfctp),
--   v_SALUTATION_CODE             CHAR(5)      -- Mapping Table Required       
--case when trim(g3pf.G3TICP) is null and trim(bgpf.BGGEND) is not null then case when convert_codes('GENDER',upper(regexp_replace(trim(bgpf.BGGEND),'[`]','')))='M' then 'MR.'  else 'MS.' end
--when trim(g3pf.G3TICP) in('ACC','DR.','ENG','LWR','MIS','MNR','MSR','PRF')  and trim(bgpf.BGGEND) is not null then case when convert_codes('GENDER',upper(regexp_replace(trim(bgpf.BGGEND),'[`]','')))='M' then 'MR.'
--else 'MS.' end else nvl(convert_codes('CUST_TITLE',trim(g3pf.G3TICP)),'ZZZ') end,
'MR', ---- changed on 21-03-2017 based on Vijay mail confirmation dt 19-03-2017.
--   v_CUST_FIRST_NAME             CHAR(80)     
    --case when trim(case when trim(g3nm1)is not null then to_char(trim(g3nm1)||' ') else to_char('') end ||
      --      case when trim(g3nm3)is not null then to_char(trim(g3nm3)||' ') else to_char('') end||
        --    case when trim(g3nm4)is not null then to_char(trim(g3nm4)||' ') else to_char('') end||
          --  nvl(trim(g3nm2),''))=trim(gfcun) then to_char(trim(g3nm1))     
            --when trim(gfcun) is not null then to_char(REGEXP_SUBSTR(trim(gfcun), '[^ ]+', 1, 1)) --- added based on discussion with vijay on 17-08-2017.(if g3pf is null then gfcun)            else 'ZZZ' end,--fisrt_name                   
gfpf.gfcun,            
-- v_CUST_MIDDLE_NAME              CHAR(80)     
    --case when trim(case when trim(g3nm1)is not null then to_char(trim(g3nm1)||' ') else to_char('') end ||
      --      case when trim(g3nm3)is not null then to_char(trim(g3nm3)||' ') else to_char('') end||
        --    case when trim(g3nm4)is not null then to_char(trim(g3nm4)||' ') else to_char('') end||
          --  nvl(trim(g3nm2),''))=trim(gfcun) then to_char(nvl(trim(g3nm4),''))     
            --when trim(gfcun) is not null then to_char(substr(trim(gfcun),length(REGEXP_SUBSTR(trim(gfcun), '[^ ]+', 1, 1))+1,length(trim(gfcun))-(length(REGEXP_SUBSTR(trim(gfcun), '[^ ]+', 1, 1))+length(SUBSTR(trim(gfcun), INSTRC(trim(gfcun),' ',-1)+1))))) --- added based on discussion with vijay on 17-08-2017.(if g3pf is null then gfcun)   else '' end,--Grandfather's name
'',            
--   v_CUST_LAST_NAME              CHAR(80)     
    --case when trim(case when trim(g3nm1)is not null then to_char(trim(g3nm1)||' ') else to_char('') end ||
      --      case when trim(g3nm3)is not null then to_char(trim(g3nm3)||' ') else to_char('') end||
        --    case when trim(g3nm4)is not null then to_char(trim(g3nm4)||' ') else to_char('') end||
          --  nvl(trim(g3nm2),''))=trim(gfcun) then to_char(nvl(trim(g3nm2),'ZZZ'))     
            --when trim(gfcun) is not null then to_char(SUBSTR(trim(gfcun), INSTRC(trim(gfcun),' ',-1) + 1))--- added based on discussion with vijay on 17-08-2017.(if g3pf is null then gfcun)     else 'ZZZ' end,--Family name
    case when trim(gfcun) is not null then to_char(replace(SUBSTR(trim(gfcun), INSTRC(trim(gfcun),' ',-1) + 1),'&',' and '))--- added based on discussion with vijay on 17-08-2017.(if g3pf is null then gfcun) 
    else 'ZZZ' end,            
--   v_PREFERREDNAME             CHAR(50)        
            to_char(nvl(gfpf.GFCUN,'ZZZ')),       
-- v_SHORT_NAME                 CHAR(10)        
            trim(gfpf.GFDAS),
--   v_CUST_DOB                 CHAR(17)         --Changed on 27-12-2015
trim(gfpf.gfstmp),
--   v_GENDER                   CHAR(10)        
      --bgpf.BGGEND,
      --nvl(convert_codes('GENDER',bgpf.BGGEND),'ZZZ'),
     'M',
-- v_OCCUPATION_CODE              CHAR(5)        -- Transformation logic to be written based on the LOV values setup in BPD
            '',                                         
--   v_NATIONALITY              CHAR(50)        -- Done, please cross check Alavudeen
        --nvl(gfpf.GFCNAP,'.'),        
gfpf.GFCNAP,
--   v_NATIVELANG_TITLE            CHAR(5)        -- Default Blank    
            '',                                         
--   v_NATIVELANG_NAME            CHAR(80)        -- Default Blank    
            '',                                         
-- v_DOCUMENT_RECIEVED            CHAR(1)        -- Default Blank    
            'N',                                        
-- v_STAFF_FLAG                 CHAR(25)        -- Defaulted to N but we need to get the table with Emp id, Cif id mapping and write the transformation logic
'N',
--   v_STAFFEMPLOYEEID             CHAR(50)        -- MAPPING TABLE REQUIRED
'',                           
--   v_MANAGER                 CHAR(100)                  
gfpf.gfaco,
--   v_CUSTOMERNRE_FLAG            CHAR(1)        -- Changed on 17-09-2015
         CASE WHEN gfpf.GFCNAL = 'IN' then 'N' else 'Y' end,
-- v_DATEOFBECOMINGNRE            CHAR(17)       --Changed on 27-10-2015
gfpf.GFCOD, --- changed as per vijay mail confirmation on 20-01-2017
--   v_CUSTOMER_MINOR            CHAR(1)        -- Completed
'N',
--   v_CUSTOMER_GUARDIAN_ID        CHAR(50)        -- Need to check value in BPD
--        case when  bgpf.BGDTOB<>0 and  length(bgpf.BGDTOB)=8
--       and to_number(substr(bgpf.BGDTOB,1,4)) between 1900 and 2017
--       and to_number(substr(bgpf.BGDTOB,5,2)) between 1 and 12
--       and to_number(substr(bgpf.BGDTOB,7,2)) between 1 and 31 
--         and check_minor(to_date(bgpf.BGDTOB,'YYYYMMDD')) = 'Y' then 'GAURDIAN'                 
--       else ''  
--       end,
        '',        
--   v_MINOR_GUARD_CODE            CHAR(1)        -- Need to check value in BPD
'',                                 
--   v_MINOR_GUARD_NAME            CHAR(40)        -- Need to check value in BPD    
'',         
--   v_REGION                 CHAR(50)            -- Done, 
        '999',--BPD ITEM
 --   v_PRIMARY_SERVICE_CENTRE        CHAR(5)    -- Done
       1234,
--   v_RELATIONSHIPOPENINGDATE        CHAR(17)    -- Done
gfpf.GFCOD,
--   v_STATUS_CODE            CHAR(5)            -- Done
        --case when trim(GFCUD)='Y' then 'DCSED' else 'ACTVE' end,
'ACTVE', -- changed As per Vijay mail confirmation on 20-03-2017
--  v_CUSTSTATUSCHGDATE            CHAR(17)        -- Done
            '',                                    
--   v_HOUSEHOLD_ID            CHAR(50)            -- DEFAULT BLANK
            '',                                     
--   v_HOUSEHOLD_NAME            CHAR(50)        -- DEFAULT BLANK    
            '',                                     
--  v_CRNCY_CODE_RETAIL            CHAR(3)        -- DEFAULT to AED, need to check if CIF with different Currency
         'KWD',                                   -- DEFAULT 'INR'
--   v_RATING_CODE            CHAR(5)            -- DEFAULT BLANK
 '',-- based on edwin mail dt 30-04-2017 script changed.                                  
--   v_RATING_DATE            CHAR(17)            -- DEFAULT BLANK
            '',                                      
--   v_CUST_PREF_TILL_DATE        CHAR(17)        -- DEFAULT BLANK    
            '',                                      
--   v_TDS_TBL_CODE            CHAR(5)            -- DEFAULT ZERO Table code from BPD value
            '999',--As per Sandeep confirmation default to 999                                    
--   v_INTRODUCER_ID            CHAR(50)        -- DEFAULT BLANK
            '',                                      
--   v_INTRODUCER_SALUTATION        CHAR(5)        -- DEFAULT BLANK
            '',                                      
--   v_INTRODUCER_NAME            CHAR(40)        -- DEFAULT BLANK
            '',                             
--   v_INTRODUCER_STATUS_CODE        CHAR(100)    -- DEFAULT BLANK
            '',                                      
--   v_OFFLINE_CUM_DEBIT_LIMIT        CHAR(25)    -- DEFAULT BLANK
            '',                                      
--   v_CUST_TOT_TOD_ALWD_TIMES        CHAR(5)    -- DEFAULT BLANK
            '',                                      
--   v_CUST_COMMU_CODE            CHAR(5)        -- DEFAULT BLANK
            '',                                      
--   v_CARD_HOLDER            CHAR(1)
 'N' ,
--  v_CUST_HLTH                 CHAR(200)
'1',-----BASED ON VIJAY MAIL DATED 10-07-2017 script changed
--   v_CUST_HLTH_CODE            CHAR(5)
        '',                                      -- DEFAULT BLANK
--   v_TFPARTYFLAG            CHAR(1)
            --case when GFYTRI='Y' then  'Y' else 'N' end,--need to check with santhos
'N',
--   v_PRIMARY_SOL_ID            CHAR(8)             -- Done    
1234,                               
--   v_CONSTITUTION_REF_CODE        CHAR(5)             -- DEFAULT BLANK
gfpf.gfca2, --changed on  28-02-2017 as per uae changes
--  v_CUSTOTHERBANKCODE            CHAR(6)             -- DEFAULT BLANK
            '',                                      
--   v_CUST_FIRST_ACCT_DATE        CHAR(17)             -- DEFAULT BLANK
          '',    
--  v_CHARGE_LEVEL_CODE            CHAR(5)             -- DEFAULT BLANK
            '',
--   v_CHRG_DR_FORACID            CHAR(16)             -- DEFAULT BLANK
            '',                                      
--   v_CHRG_DR_SOL_ID            CHAR(8)             -- DEFAULT BLANK
            '',                                      
--   v_CUST_CHRG_HISTORY_FLG        CHAR(1)             -- DEFAULT 'N'
            'N',                                     
-- v_COMBINED_STMT_REQD            CHAR(1)             -- DEFAULT 'N'    
            case when trim(gfpf.GFCS) is not null then to_char(gfpf.GFCS) else ''
            end,--TO BE CHECK WITH ABK TECH TEAM                                     
--   v_LOANS_STMT_TYPE            CHAR(1)             -- DEFAULT BLANK
            '',                                      
--   v_TD_STMT_TYPE            CHAR(1)                 -- DEFAULT BLANK    
            '',                                      
--   v_COMB_STMT_CHRG_CODE        CHAR(5)             -- DEFAULT BLANK     
            '',                                      
--   v_DESPATCH_MODE            CHAR(1)                 -- DEFAULT BLANK
            trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM                                      
--   v_CS_LAST_PRINTED_DATE        CHAR(17)             -- DEFAULT BLANK
            '',                                      
--   v_CS_NEXT_DUE_DATE            CHAR(17)             -- DEFAULT BLANK    
            '',                                      
--   v_ALLOW_SWEEPS            CHAR(1)                 -- DEFAULT SET TO 'Y'
            'Y',--as per sanddep confirmation on mock3b upload changed from 'N' to 'Y'
--   v_PS_FREQ_TYPE            CHAR(1)                 -- DEFAULT BLANK
            trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM                                      
--   v_PS_FREQ_WEEK_NUM            CHAR(1)             -- DEFAULT BLANK
            trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM
--   v_PS_FREQ_WEEK_DAY            CHAR(1)             -- DEFAULT BLANK    
           trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM
--   v_PS_FREQ_START_DD            CHAR(2)             -- DEFAULT BLANK
            trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM
--  v_PS_FREQ_HLDY_STAT            CHAR(1)             -- DEFAULT BLANK
            trim(gfpf.GFCFRQ),--TO BE CHECK WITH ABK TECH TEAM
--   v_ENTITY_TYPE            CHAR(30)                 -- DEFAULT SET TO 'CUSTOMER'    
            'Customer',                              
--   v_LINKEDRETAILCIF            CHAR(32)            -- DEFAULT BLANK
            '',                                      
--   v_HSHLDU_FLAG            CHAR(1)
            '',                                      -- DEFAULT SET TO 'N'
-- v_SMALL_STR1                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR2                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR3                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR4                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR5                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR6                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR7                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR8                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SMALL_STR9                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_SMALL_STR10            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR1                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR2                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR3                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR4                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR5                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR6                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR7                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR8                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MED_STR9                 CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_MED_STR10                 CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_LARGE_STR1                 CHAR(250)
            '',                                      -- DEFAULT BLANK
-- v_LARGE_STR2                 CHAR(250)
            '',                                      -- DEFAULT BLANK
-- v_LARGE_STR3                 CHAR(250)
            '',                                      -- DEFAULT BLANK
-- v_LARGE_STR4                 CHAR(250)
            '',                                      -- DEFAULT BLANK
-- v_LARGE_STR5                 CHAR(250)
            '',                                      -- DEFAULT BLANK
--   v_DATE1                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE2                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE3                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE4                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE5                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE6                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE7                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE8                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE9                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_DATE10                 CHAR(17)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER1                CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER2                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER3                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER4                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER5                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER6                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER7                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER8                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER9                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_NUMBER10                 CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL1                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL2                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL3                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL4                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL5                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL6                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL7                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL8                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_DECIMAL9                 CHAR(25)
            '',                                      -- DEFAULT BLANK
-- v_DECIMAL10                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_CORE_CUST_ID            CHAR(9)
            '',
--   v_PERSON_TYPE            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_CUST_LANGUAGE            CHAR(50)
         'INFENG',                               -- DEFAULT SET TO 'ENGLISH'
-- v_CUST_STAFF_STATUS            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_PHONE                 CHAR(25)
            '',                                      -- DEFAULT BLANK
-- v_EXTENSION                 CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_FAX                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_FAX_HOME                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_PHONE_HOME                 CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_PHONE_HOME2            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_PHONE_CELL                 CHAR(25)
            '',                                      -- DEFAULT BLANK
-- v_EMAIL_HOME                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_EMAIL_PALM                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_EMAIL                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_CITY                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_PREFERRED_CHANNEL_ID        CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_CUSTOMER_RELATIONSHIP_no        CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_RELATIONSHIP_VALUE            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_CATEGORY                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_NUMBEROFPRODUCTS            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_MANAGER_ID        CHAR(38)
            '',                                      -- MAPPING TABLE REQUIRED
-- v_RELATIONSHIP_CREATED_BY_ID        CHAR(38)
            '',                                  -- DEFAULT  SET TO BLANK
--   v_URL                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_STATUS                 CHAR(50)
       --case when GFCUZ='Y' then 'DCSED' else 'ACTVE' end,                                      -- MAPPING TABLE REQUIRED
'ACTVE',--- as per discusssion with sandeep on 11-04-2017 and movk3b observation changed
--   v_INDUSTRY                 CHAR(50)
            '',                                      -- Need clarification
-- v_PARENTORG                 CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_COMPETITOR                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_SIC_CODE                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_CIN                 CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_DESIGNATION            CHAR(50)
            '',                                      -- Confirmation required from Business
-- v_ASSISTANT                 CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_INTERNAL_SCORE            CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_CREDIT_BUREAU_SCORE_VALIDITY    CHAR(10)
            '',                                      -- DEFAULT BLANK
--       v_CREDIT_BUREAU_SCORE        CHAR(20)
          '', 
-- v_CREDIT_BUREAU_REQUEST_DATE        CHAR(10)
          '',        
-- v_CREDIT_BUREAU_DESCRIPTION        CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_MAIDEN_MOTHER_NAME            CHAR(50)
           '',                              -- CHECK IT    -- CHECKED -- OK 
--   v_ANNUAL_REVENUE            CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_REVENUE_UNITS            CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_TICKER_SYMBOL            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_AUTO_APRPOVAL            CHAR(5)
            '',                                      -- DEFAULT SET TO 'N'
--   v_FREEZE_PRODUCT_SALE        CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_FIELD_1        CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_FIELD_2        CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_FIELD_3        CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_DELINQUENCY_FLAG            CHAR(1)
            '',                                      -- DEFAULT BLANK
-- v_CUSTOMER_NRE_FLAG            CHAR(1)
        CASE WHEN gfpf.GFCNAL <> 'IN' then 'Y' else 'N' end,  
-- v_COMBINED_STMT_FLAG            CHAR(1)
            'N',                                      -- Business confirmation
--   v_CUSTOMER_TRADE            CHAR(1)
            '',                                      -- DEFAULT BLANK
--   v_PLACE_OF_BIRTH            CHAR(50)
gfpf.GFCNAP,
--   v_COUNTRY_OF_BIRTH            CHAR(50)
--         nvl(gfpf.GFCNAL,'ZZZ'),
gfpf.GFCNAL,
-- v_PROOF_OF_AGE_FLAG            CHAR(1)
            '',                                      -- DEFAULT BLANK
--   v_PROOF_OF_AGE_DOCUMENT        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_NAME_SUFFIX            CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_MAIDEN_NAME            CHAR(50)
            '',               -- CHECK IT   
--   v_CUSTOMER_PROFITABILITY        CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_CURRENT_CR_EXPOSURE        CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_TOTAL_CREDIT_EXOPSURE        CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_POTENTIAL_CREDIT_LINE        CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_AVAILABLE_CREDI_LIMIT        CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_CREDIT_SCORE_REQUESTED_FLAG    CHAR(1)
            '',                                      -- DEFAULT BLANK
--   v_CREDIRT_HISTORY_REQUESTED_FL    CHAR(2)
            '',                                      -- DEFAULT BLANK
--   v_GROUP_ID                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_FLG1                 CHAR(10)
'N', ------changed on 07-03-2017 as per vijay mail dt on 07-03-2017
--   v_FLG2                 CHAR(10)
            'N',                                      --  changed on 10-01-2017 as per sandeep and vijaya confirmation
--   v_FLG3                 CHAR(10)
            'Y',--defaulted to 'Y' based on the email from vijay on 04/06/2017                                      -- DEFAULT BLANK
--   v_ALERT1                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_ALERT2                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_ALERT3                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_OFFICER_1        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_RELATIONSHIP_OFFICER_2        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE1                CHAR(10)
--          case when length(trim(BGCODT))=8 and conv_to_valid_date(BGCODT,'YYYYMMDD') is not null then to_char(to_date(BGCODT,'YYYYMMDD'),'DD-MON-YYYY')
--when gfpf.GFCOD <> 0  and get_date_fm_btrv(gfpf.GFCOD) <> 'ERROR' then  to_char(to_date(get_date_fm_btrv(gfpf.GFCOD),'YYYYMMDD'),'DD-MON-YYYY')else '0' end, --- changed as per vijay mail confirmation on 20-01-2017            
'',--   v_DTDATE2                CHAR(10)
      --  case when scj7.scaij7='Y' then to_char(add_months(to_date(get_param('EOD_DATE'),'DD-MM-YYYY'),12),'DD-MON-YYYY') else to_char(add_months(to_date(get_param('EOD_DATE'),'DD-MM-YYYY'),36),'DD-MON-YYYY') end,
'',  -- As per Vijay confirmation on 04-04-2017 script has been changed.
--   v_DTDATE3                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE4                CHAR(10)
'',-- DEFAULT BLANK
--   v_DTDATE5                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE6                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE7                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE8                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_DTDATE9                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_Amount1                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount2                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount3                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount4                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount5                CHAR(20)
            '',                                      -- DEFAULT BLANK
-- v_strfield1                CHAR(100)
         '',                                      
-- v_strfield2                CHAR(100)
         '',
-- v_strfield3                CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_strfield4                CHAR(100)
            'N',                                      -- DEFAULT BLANK
--  v_strfield5                CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_strfield6                CHAR(50)
            '',                                      -- DEFAULT BLANK
--  v_strfield7                CHAR(50)
            --case  when GFCNAP   in ('BH', 'KW','OM','QA','AE') then'GCCNT'                    
              --     when GFCNAP='KW'  then'NATIONAL'
               --else 'EXPAT' end,                                      -- DEFAULT BLANK
               'ZZZ',
--  v_strfield8                CHAR(50)
'Y',
--  v_strfield9                CHAR(50)
'N', 
-- v_strfield10                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_strfield11                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_strfield12                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_strfield13                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_strfield14                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_strfield15                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_UserFlag1                CHAR(1)
            'N',                                      -- changed on 10-01-2017 as per sandeep and vijaya confirmation
-- v_UserFlag2                CHAR(1)
            'N',                                      -- changed on 10-01-2017 as per sandeep and vijaya confirmation
-- v_UserFlag3                CHAR(1)
            'N',                                      -- changed on 10-01-2017 as per sandeep and vijaya confirmation
-- v_UserFlag4                CHAR(1)
            'N',                                      -- changed on 10-01-2017 as per sandeep and vijaya confirmation
--   v_MLUserField1            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField2            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField3            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField4            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField5            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField6            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField7            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField8            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField9            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField10            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_MLUserField11            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_Notes                CHAR(1000)
            '',                                      -- DEFAULT BLANK
--   v_Priority_Code            CHAR(50)
            '',
--   v_Created_From            CHAR(1)
            '',                                      -- DEFAULT BLANK
--  v_Constitution_Code            CHAR(200)
            --convert_codes('CONSTITUTION_CODE',gfpf.GFCTP),
            nvl(trim(gfpf.gfca2),'99'), --changed on  28-02-2017 as per uae changes
-- v_StrField16                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_StrField17                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_StrField18                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_StrField19                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_StrField20                CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_StrField21                CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_StrField22                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_Amount6                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount7                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount8                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount9                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount10                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount11                CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_Amount12                CHAR(20)
            '',                                      -- DEFAULT BLANK
-- v_IntField1                CHAR(38)
            '',                                      -- DEFAULT BLANK
--  v_IntField2                CHAR(38)
            '',                                      -- DEFAULT BLANK
-- v_IntField3                CHAR(38)
            '',                                      -- DEFAULT BLANK
--  v_IntField4                CHAR(38)
            '',                                      -- DEFAULT BLANK
--  v_IntField5                CHAR(38)
            '',                                      -- DEFAULT BLANK
--  v_nick_name                CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_mother_name            CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_father_husband_name        CHAR(20)
    --case when trim(case when trim(g3nm1)is not null then to_char(trim(g3nm1)||' ') else to_char('') end ||
    --        case when trim(g3nm3)is not null then to_char(trim(g3nm3)||' ') else to_char('') end||
    --        case when trim(g3nm4)is not null then to_char(trim(g3nm4)||' ') else to_char('') end||
    --        nvl(trim(g3nm2),''))=trim(gfcun) then to_char(nvl(trim(g3nm3),''))     else '' end,--Father's name ---commented on 17-08-2017 based on discussion with vijay. gfcun matching is wrong
'',
--   v_previous_name            CHAR(20)
            '',                                      -- DEFAULT BLANK
--   v_lead_source            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_relationship_type            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_rm_group_id            CHAR(5)
            '',                                      -- DEFAULT BLANK
-- v_relationship_level            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_DSA_ID                CHAR(12)
            '',                                      -- DEFAULT BLANK
--   v_photograph_id            CHAR(10)
            '',                                      -- DEFAULT BLANK
-- v_Secure_id                CHAR(10)
            '',                                      -- DEFAULT BLANK
--  v_Deliquency_Period            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_AddName1                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_AddName2                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_AddName3                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_AddName4                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_AddName5                CHAR(50)
            '',                                      -- DEFAULT BLANK
 -- v_OldEntityCreatedOn            CHAR(10)
            '',                                      -- DEFAULT BLANK
--   v_OldEntityType            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_OldEntityID            CHAR(20)
            '',                                      -- DEFAULT BLANK
--  v_Document_Received            CHAR(1)
            'N',                                      -- DEFAULT BLANK
--   v_Suspend_Notes            CHAR(500)
            '',                                      -- DEFAULT BLANK
--   v_Suspend_Reason            CHAR(250)
     --case when trim(gfc5r)is not null and trim(gfc5r) in('BL', 'BM', 'BN','BP', 'BW', 'CF', 'DC', 'DD', 'DE', 'DF', 'DG', 'DL', 'DT', 'DW', 'IF', 'LA', 'LC', 'LD', 'LE', 'LG', 'LH', 'LI', 'LP', 'LR', 'NL', 'PL', 'RA', 'RB', 'RC', 'SL', 'UL', 'UM', 'US', 'UT', 'UV', 'UX', 'WA', 'WC', 'WL', 'XX')
     --then convert_codes('GFC5R',trim(gfc5r))    
     --else '' end,                                      -- DEFAULT BLANK
'',
--   v_Blacklist_Notes            CHAR(500)
            '',                                      -- DEFAULT BLANK
--   v_Blacklist_Reason            CHAR(250)
            '',                                      -- DEFAULT BLANK
--   v_Negated_Notes            CHAR(500)
            '',                                      -- DEFAULT BLANK
--   v_Negated_Reason            CHAR(250)
            '',                                      -- DEFAULT BLANK
-- v_Segmentation_Class            CHAR(100)
  --case when trim(SEG_CODE) is null then 'ZZZ' else convert_codes('SEGMENT',trim(wmtype)) end,--- changed on 12-06-2017 based mk4a observation.--commented on 28-01-2017 based on vijay confirmation
'3001',--   v_Name                 CHAR(100)
           '', 
--   v_Manager_Opinion            CHAR(240)
            '',                                      -- DEFAULT BLANK
--   v_Introd_Status            CHAR(50)
            '',                                      -- DEFAULT BLANK 
--   v_NativeLangCode            CHAR(10) 
            'INFENG',                               -- DEFAULT SET TO 'ENGLISH'
--   v_MinorAttainMajorDate        CHAR(11)
          '',     
-- v_NREBecomingOrdDate            CHAR(11)
            '',                                      -- DEFAULT BLANK
-- v_Start_Date                CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_Add1_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add1_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add1_Last_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add2_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add2_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add2_Last_Name            CHAR(80)
            '',                                     -- DEFAULT BLANK
--   v_Add3_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add3_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add3_Last_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add4_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add4_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add4_Last_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add5_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add5_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Add5_Last_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Dual_First_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Dual_Middle_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Dual_Last_Name            CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_Cust_Community            CHAR(50)
            'OTHR',     ----- As per sandeep confirmation on 11-04-2017 mock3b observation changed                                
--   v_Core_introd_cust_id        CHAR(9)
            '',                                      -- DEFAULT BLANK
--   v_Introd_Salutation_code        CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_Tds_cust_id            CHAR(9)
            '',                                      -- DEFAULT BLANK
--   v_Nat_id_card_num            CHAR(16)
'',--   v_Psprt_issue_date            CHAR(10)
            '',                                      -- DEFAULT BLANK
-- v_Psprt_det                CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_Psprt_exp_date            CHAR(10)
            '',                                      -- DEFAULT BLANK
-- v_Crncy_code                CHAR(3)
            'KWD',                                  -- DEFAULT SET TO 'SAR'
-- v_Pref_code                CHAR(15)
            'NOPRF',                                      -- DEFAULT BLANK
-- v_Introd_Status_Code            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_NativeLangTitle_code        CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_Groupid_code            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_Sector                CHAR(50)
            --gfpf.GFCA2,--DATA CLEANSING AND BUSINESS OWNERS
gfpf.GFC2R,
-- v_SubSector                CHAR(50)
            --gfpf.GFCA2,--DATA CLEANSING AND BUSINESS OWNERS
            --convert_codes('SUB_SECTOR_CODE',''),
            nvl(trim(gfpf.GFC2R),'ZZZ'),
--   v_CustCreationMode            CHAR(1)
            '',                                      -- DEFAULT BLANK
--   v_First_Product_Processor        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_Interface_Reference_ID        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_cust_health_ref_code        CHAR(5)
            '',                                      -- DEFAULT BLANK
-- v_TDS_CIFID                CHAR(50)
            '',                      -- DEFAULT SET TO CIF_ID
--   v_PREF_CODE_RCODE            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_CUST_SWIFT_CODE_DESC        CHAR(50)
'',                                      -- DEFAULT BLANK
--   v_IS_SWIFT_CODE_OF_BANK        CHAR(1)
'N',                                           -- DEFAULT BLANK
--   v_NATIVELANGCODE_CODE        CHAR(5)
            '',                               -- DEFAULT SET TO 'ENGLISH'
---- Size is 5 and throwing 7 characters... how it is possible...?
-- v_CreatedBySystemID            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_PreferredEmailType            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_PreferredPhone            CHAR(25)
            '',                                      -- DEFAULT BLANK
--   v_CUST_FIRST_NAME_NATIVE        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_MIDDLE_NAME_NATIVE        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_LAST_NAME_NATIVE        CHAR(80)
            '',                                      -- DEFAULT BLANK
-- v_SHORT_NAME_NATIVE            CHAR(50) This is reported by Infy as 10 characters but in upload sheet says 50
            '',                                      -- DEFAULT BLANK
--   v_CUST_FIRST_NAME_NATIVE1        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_MIDDLE_NAME_NATIVE1        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_LAST_NAME_NATIVE1        CHAR(80)
            '',                                      -- DEFAULT BLANK
-- v_SHORT_NAME_NATIVE1            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_SecondaryRM_ID            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_TertiaryRM_ID            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_SUBSEGMENT                CHAR(50)
 '',--NEED TO CHECK BPD AND LOV MAPPING
--   v_ACCESSOWNERGROUP            CHAR(38)
            '',                                      -- DEFAULT BLANK
-- v_ACCESSOWNERSEGMENT            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_ACCESSOWNERBC            CHAR(38)
            '',                                -- DEFAULT SET TO RETAIL
--   v_ACCESSOWNERAGENT            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_ACCESSASSIGNEEAGENT        CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_CHARGELEVELCODE            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_IntUserField1            CHAR(38)
'', 
--   v_IntUserField2            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_IntUserField3            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_IntUserField4            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_IntUserField5            CHAR(38)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField1            CHAR(100)
'003',  ---as per vijay mapping by mail on 09-03-2017. changed.
--   v_StrUserField2            CHAR(100)
'00339',---- Changed on 18-07-2017 as per discussion with anegha,sandeep and vijay 00300 to 00339 as per mis dimension sheet. ability to customer field need to considered.
---as per vijay mapping by mail on 09-03-2017. changed.
--   v_StrUserField3            CHAR(100)
            --case when regexp_replace(fa.SVNA4,'[A-Z,a-z,., ,-]','') is not null and regexp_replace(fa.SVNA4,'[A-Z,a-z,., ,-]','')<>0
            --then 'Y' else 'N' end,
'',                                     -- DEFAULT BLANK
--   v_StrUserField4            CHAR(100)
            --case 
            --when trim(fin_value) is not null then to_char(fin_value)
            --when trim(salary.cif) is not null then 'SALARY'  -- changed on 9 april based on vijays mail dated 12 March
            --when sal_cif is not null then 'SALARY'
            --when busi_cif is not null then 'BUSINESS'
            --when savi_cif is not null then 'SAVINGS'  ----changed on 25-04-2017 based on vijay mail dt 24-04-2017.
            --else 'ZZZ' end, 
'ZZZ', ---- CHANGED AS PER SANDEEP MAIL DT ON 11-07-2017
--   v_StrUserField5            CHAR(100)
            --'CURRENT ACCOUNT',                                      -- DEFAULT BLANK
'CA', --Based on sandeep mail confirmation script changed on 22-01-2017.-- Based on Vijay and nagi discussed with hiyam on 29-08-2017 'EF' passed for AL amil customer
--   v_StrUserField6            CHAR(100)
gfpf.GFSAC,                                      -- DEFAULT BLANK
--   v_StrUserField7            CHAR(100)
           --'IN PERSON',
'InPerson' , --Based on sandeep mail confirmation script changed on 22-01-2017.
--   v_StrUserField8            CHAR(100)
           '',
--   v_StrUserField9            CHAR(100)
            '',
--   v_StrUserField10            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField11            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField12            CHAR(100)
             --'Branches',                                      -- DEFAULT BLANK
            '001', --Based on sandeep mail confirmation script changed on 22-01-2017.
--   v_StrUserField13            CHAR(100)
        '',
--   v_StrUserField14            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField15            CHAR(100)
1234,                                      -- DEFAULT BLANK            
--   v_StrUserField16            CHAR(100)
--case when trim(ias24.Status)='Associate' then 'A' when trim(ias24.Status)='Chairman' then  'B' when trim(ias24.Status)='Director' then 'D' when trim(ias24.Status)='EXECUTIVE' then 'F'
--when trim(ias24.Status)='Related Party - Associate' then 'G' when trim(ias24.Status)='Related Party - Chairman' then 'I' when trim(ias24.Status)='Related Party - Director' then 'J'
--when trim(ias24.Status)='Shareholder' then 'M' else '' end,   ----IAS24 condition added as per sandeep mail dt 03-07-2017
'',---CHANGED ON 10-08-2017 -- BASED ON uat ISSUE
--   v_StrUserField17            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField18            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField19            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField20            CHAR(100)
            '',                  -- Not Required need to chk
--   v_StrUserField21            CHAR(100)
       '',                                      -- DEFAULT BLANK
--   v_StrUserField22            CHAR(100)
            'N',                                      -- DEFAULT BLANK
--   v_StrUserField23            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField24            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField25            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField26            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField27            CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_StrUserField28            CHAR(100)
          '',
--   v_StrUserField29            CHAR(100)--CBK secret no
          '',
--   v_StrUserField30            CHAR(100)
'',                                    -- DEFAULT BLANK
--   v_DateUserField1            CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_DateUserField2            CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_DateUserField3            CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_DateUserField4            CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_DateUserField5            CHAR(11)
            '',                                      -- DEFAULT BLANK
--   v_Back_End_ID            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_RISK_PROFILE_SCORE            CHAR(38)
            '',                                      -- MAPPING TABLE REQUIRED
--   v_RISK_PROFILE_EXPIRY_DATE        CHAR(17)
            '',                                      -- DEFAULT BLANK
-- v_PreferredPhoneType            CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_PreferredEmail            CHAR(150)
            '',                                      -- DEFAULT BLANK
--   v_NoOfCreditCards            CHAR(38)
            '',                                      -- DEFAULT BLANK
-- v_ReasonForMovingOut            CHAR(5)
            '',                                      -- DEFAULT BLANK
--   v_CompetitorProductID        CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_OCCUPATION_TYPE            CHAR(50)
            '',                                      -- MAPPING TABLE REQUIRED
--   v_BANK_ID                CHAR(8)
'01',                                      -- DEFAULT BLANK, But given 01 in XLS RC001 sheet.
--   v_ZAKAT_DEDUCTION            CHAR(2)
            'N',                                      -- DEFAULT BLANK
--   v_ASSET_CLASSIFICATION        CHAR(1)
            'S', --- as per mail dt 26-03-2017 by sandeep and spira ticket number 5525.
--   v_CUSTOMER_LEVEL_PROVISIONING    CHAR(1)
            '',                                      -- DEFAULT BLANK
--   v_ISLAMIC_BANKING_CUSTOMER        CHAR(1)
            'N',                                      -- DEFAULT BLANK
-- v_PREFERREDCALENDER            CHAR(50)
            --'GREGORIAN',                                      -- DEFAULT BLANK
            '00',
--   v_IDTYPER1                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_IDTYPER2                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_IDTYPER3                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_IDTYPER4                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_IDTYPER5                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_CUST_LAST_NAME_ALT1        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_FIRST_NAME_ALT1        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_CUST_MIDDLE_NAME_ALT1        CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_STRFIELD6_ALT1            CHAR(50)
            '',                                      -- DEFAULT BLANK
-- v_NAME_ALT1                CHAR(80)
            '',                                      -- DEFAULT BLANK
--   v_SHORT_NAME_ALT1            CHAR(10)
            '',                                      -- DEFAULT BLANK
-- v_ISEBANKINGENABLED            CHAR(1)
            'Y',                                      -- DEFAULT SET TO 'Y'
-- v_PURGEFLAG                CHAR(1)
            'N',                                      -- DEFAULT SET TO 'N'
--  v_SUSPENDED                CHAR(1)
--case when trim(gfc5r)is not null and trim(gfc5r) = 'BL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'BM' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'BN' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'BP' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'BW' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'CF' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DC' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DD' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DE' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DF' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DG' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DT' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'DW' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'IF' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LA' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LC' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LD' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LE' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LG' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LH' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LI' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LP' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'LR' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'NL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'PL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'RA' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'RB' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'RC' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'SL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'UL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'UM' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'US' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'UT' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'UV' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'UX' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'WA' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'WC' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'WL' then  'Y'
--     when trim(gfc5r)is not null and trim(gfc5r) = 'XX' then  'Y'
--     else 'N' end,                                      -- DEFAULT SET TO 'N'
'N', 
--   v_BLACKLISTED            CHAR(1)
            '',                                      -- DEFAULT SET TO 'N'
--   v_NEGATED                 CHAR(1)
            '',                                      -- DEFAULT SET TO 'N'
--  v_ACCOUNTID                CHAR(50)
            '',                                      -- DEFAULT BLANK
--   v_ADDRESS_LINE1            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_ADDRESS_LINE2            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_ADDRESS_LINE3            CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_STATE                CHAR(200)
            '',                                      -- DEFAULT BLANK
--   v_COUNTRY                CHAR(100)
            '',                                      -- DEFAULT BLANK
--   v_ZIP                CHAR(100)
            '',                                      -- DEFAULT BLANK
-- v_BOCREATEDBYLOGINID            CHAR(50)
         '',
-- date_of_death        NVARCHAR2(11) NULL,
--case when trim(GFCUD)='Y' then to_char(to_date(get_param('EOD_DATE'),'DD-MM-YYYY'),'DD-MON-YYYY') else '' end,
'',  --- changed as per vijay mail confirmation on 20-01-2017
-- date_of_notifi        NVARCHAR2(11) NULL,
--case when trim(GFCUD)='Y' then to_char(to_date(get_param('EOD_DATE'),'DD-MM-YYYY'),'DD-MON-YYYY') else '' end,
'',  --- changed as per vijay mail confirmation on 20-01-2017
--riskrating            NVARCHAR2(11) NULL         
'HIGH' 
from gfpf;
commit;
-------------------------------------------------POA and Guarantor new cif_id------------------------------

exit; 
