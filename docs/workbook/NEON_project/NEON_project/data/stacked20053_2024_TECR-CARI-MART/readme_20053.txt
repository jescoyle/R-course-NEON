###################################

########### Disclaimer ############

This is the most recent readme publication based on all site-date combinations used during stackByTable.
Information specific to the query, including sites and dates, has been removed. The remaining content reflects general metadata for the data product.

##################################



funded by the National Science Foundation (Awards 0653461, 0752017, 1029808, 1138160, 1246537, 1638695, 1638696,
1724433) and managed cooperatively by Battelle. These data are provided under the terms of the NEON data policy at
https://www.neonscience.org/data-policy.
DATA PRODUCT INFORMATION
------------------------
ID: NEON.DOM.SITE.DP1.20053.001
Name: Temperature (PRT) in surface water
Description: Surface water temperature, available as one-, five-, and thirty-minute  averages, measured by a platinum resistance thermometer at the sensor location in lakes, wadeable and non-wadeable streams
NEON Science Team Supplier: Aquatic Instrument System
Abstract: This data product contains quality-controlled continuous surface water temperature readings from a sensor within each of NEON's wade-able stream sensor sets.
Latency:
Data collected in any given month are published during the second full week of the following month.
Brief Design Description: Surface water temperature is measured using a platinum resistance thermometer that acquires resistance readings at 1 Hz. NEON coverts the raw resistance data product into temperature and reports at 1 minute intervals.
Brief Study Area Description: All wadeable stream sites monitor stream water temperature at both the upstream and downstream sensor set locations.
Sensor(s): Thermometrics -- R032-00000048
Keywords: aquatic, biogeochemistry, ecohydrology, hydrology, metabolism, stream, surface water, water quality, water temperature
Domain: D16
DATA PACKAGE CONTENTS
---------------------
This folder contains the following documentation files:
This data product contains up to 3 data tables:
- Machine-readable metadata file describing the data package: NEON.D16.MART.DP1.20053.001.EML.20240101-20240201.20260123T000749Z.xml.
ais_maintenance - Information related to aquatic sensor and infrastructure maintenance
TSW_5min - Temperature of surface water from PRT summarized over 5 minutes
TSW_30min - Temperature of surface water from PRT summarized over 30 minutes
If data are unavailable for the particular sites and dates queried, some tables may be absent.
Basic download package definition: Includes the data product, summary statistics, expanded uncertainty, and final quality flag.
Expanded download package definition: Includes the basic package information plus quality metrics for all of the quality assessment and quality control analyses.
FILE NAMING CONVENTIONS
-----------------------
NEON data files are named using a series of component abbreviations separated by periods. File naming conventions
for NEON data files differ between NEON science teams. A file will have the same name whether it is accessed via
NEON's data portal or API. Please visit https://www.neonscience.org/data-formats-conventions for a full description
of the naming conventions.
ISSUE LOG
----------
This log provides a list of issues identified during data collection or processing, prior to publication
of this data package. For a more recent log, please visit this data product's detail page at
https://data.neonscience.org/data-products/DP1.20053.001.
Issue Date: 2023-11-14
Issue: Lack of flagging thresholds
    Date Range: 2016-01-01 to 2024-05-02
    Location(s) Affected: All locations
Resolution Date: 2024-05-02
Resolution: Update to flagging thresholds: Range adjusted to better capture data outliers.  Persistence tests adjusted to prevent the overflagging of ~0C water at cold weather sites.
Issue Date: 2020-11-03
Issue: Low flow conditions resulting in exposed sensors.
    Date Range: 2020-10-06 to 2021-04-18
    Location(s) Affected: KING (HOR.VER: 101.100; 102.100)
    Date Range: 2020-10-19 to 2021-04-30
    Location(s) Affected: SYCA (HOR.VER: 101.100; 102.100)
    Date Range: 2022-07-01 to 2022-10-17
    Location(s) Affected: ARIK (HOR.VER: 101.100; 102.100)
Resolution Date: 2023-10-31
Resolution: Affected data were flagged.
Issue Date: 2022-09-12
Issue: Severe flooding destroyed several roads into Yellowstone National Park in June 2022, making the YELL and BLDE sites inaccessible to NEON staff. Preventive and corrective maintenance were not able to be performed, nor was the annual exchange of sensors for calibration and validation. While automated quality control routines are likely to detect and flag most issues, users are advised to review data carefully.
    Date Range: 2022-06-12 to 2022-10-31
    Location(s) Affected: BLDE
Resolution Date: 2022-10-31
Resolution: Normal operations resumed on October 31, 2022, when the National Park Service opened a newly constructed road from Gardiner, MT to Mammoth, WY with minimal restrictions. For more details about data impacts, see Data Notification https://www.neonscience.org/impact/observatory-blog/data-impacts-neons-yellowstone-sites-yell-blde-due-catastrophic-flooding-0
Issue Date: 2022-07-20
Issue: Study reach shifted upstream.  Old upstream location became new downstream location.
    Date Range: 2022-02-01 to 2022-02-01
    Location(s) Affected: SYCA
Resolution Date: 2022-07-20
Resolution: Named location database updated.
Issue Date: 2022-04-13
Issue: Sensor received erroneous calibration
    Date Range: 2021-09-14 to 2022-02-01
    Location(s) Affected: COMO (HOR.VER: 101.100)
Resolution Date: 2022-02-01
Resolution: Sensor replaced.
Issue Date: 2022-01-18
Issue: Data were reprocessed to incorporate minor and/or isolated corrections to quality control thresholds, sensor installation periods, geolocation data, and manual quality flags.
    Date Range: 2013-01-01 to 2021-10-01
    Location(s) Affected: All
Resolution Date: 2022-01-01
Resolution: Reprocessed provisional data are available now.  Reprocess data previously included in RELEASE-2021 will become available when RELEASE-2022 is issued.
Issue Date: 2021-01-14
Issue: Safety measures to protect personnel during the COVID-19 pandemic resulted in reduced or canceled maintenance activities for extended periods at NEON sites. Data availability and/or quality may be negatively impacted during this time.
In addition, the annual refresh of sensors and data acquisition systems (DAS) did not occur according to the typical 1-year schedule for many sites. The annual refresh is where freshly calibrated and verified sensors and DAS replace the units in the field.
    Date Range: 2020-03-23 to 2021-12-31
    Location(s) Affected: ALL
Resolution Date: 2021-12-31
Resolution: NEON reviewed data from all sites and time periods potentially impacted by COVID-19 safety precautions to identify and manually flag suspect data that escaped automated quality tests. Suspect data are indicated by the final quality flag in the data files, which should be used to inform data filtering prior to use. 
Currently, there are no quality flags indicating lack of conformance to an annual sensor refresh interval, but these are in development. Data during this time period should be treated as valid unless marked suspect by other quality flags.
Issue Date: 2021-03-19
Issue: Sensor malfunction resulted in bad data
    Date Range: 2020-02-03 to 2020-10-29
    Location(s) Affected: TECR (HOR:VER: 102.100)
    Date Range: 2020-12-03 to 2021-02-05
    Location(s) Affected: Pose (HOR.VER: 101.100)
    Date Range: 2021-03-30 to 2021-08-05
    Location(s) Affected: REDB (HOR:VER: 101.100)
    Date Range: 2021-10-08 to 2021-10-12
    Location(s) Affected: BIGC (HOR.VER: 102.100)
    Date Range: 2021-11-02 to 2021-12-15
    Location(s) Affected: CUPE (HOR.VER: 101.100)
    Date Range: 2022-05-30 to 2022-08-17
    Location(s) Affected: LECO (HOR:VER: 101.100)
Resolution Date: 2021-08-17
Resolution: Sensor replaced.
Issue Date: 2021-06-23
Issue: Temperature sensor exposed to air.
    Date Range: 2021-06-20 to 2021-06-22
    Location(s) Affected: KING (HOR.VER: 102.100)
    Date Range: 2023-01-05 to 2023-01-05
    Location(s) Affected: LECO (HOR.VER: 101.100)
Resolution Date: 2021-06-22
Resolution: Sensor resubmerged.
Issue Date: 2021-03-12
Issue: Sensor exposed to air
    Date Range: 2020-07-27 to 2020-11-06
    Location(s) Affected: MCRA (HOR.VER: 101.100)
Resolution Date: 2021-03-12
Resolution: Sensor submerged
Issue Date: 2020-06-10
Issue: All data were reprocessed with the most recent algorithms, quality control thresholds, and/or other metadata to improve overall data coverage and quality. Notes have been added to the logs of previously identified issues that have been corrected.
    Date Range: 2013-01-01 to 2020-06-10
    Location(s) Affected: All
Resolution Date: 2020-06-10
Resolution: Informational log only.
Issue Date: 2020-06-01
Issue: PRT encased in ice
    Date Range: 2019-10-31 to 2020-05-01
    Location(s) Affected: CARI (HOR.VER: 101.100, 102.100)
    Date Range: 2020-11-22 to 2020-12-17
    Location(s) Affected: WLOU (HOR.VER: 101.100; 102.100)
Resolution Date: 2020-06-01
Resolution: Sensor released from ice.
Issue Date: 2020-05-22
Issue: Faulty temperature sensor installed at 101.100.
    Date Range: 2019-06-10 to 2020-07-29
    Location(s) Affected: MART (HOR.VER: 101.100)
    Date Range: 2019-09-23 to 2020-08-12
    Location(s) Affected: COMO (HOR.VER: 101.100)
Resolution Date: 2020-05-22
Resolution: New sensor installed
Issue Date: 2020-01-22
Issue: High water event pushed sensors out of water
    Date Range: 2020-01-10 to 2020-01-11
    Location(s) Affected: BLUE (HOR.VER:112.100)
Resolution Date: 2020-01-11
Resolution: Sensors submerged after flow decreased
Issue Date: 2020-03-26
Issue: Coefficients used in IS data processing to compute the uncertainty contributed by resistance or voltage readings made by the field data acquisition system (FDAS) were updated. The updated coefficients are based on a larger FDAS sample and are larger than previous estimates. Although the difference between previous uncertainty estimates and updated estimates is small, there may be periods for which the FDAS uncertainty represents the largest source of uncertainty. Data produced after the resolution date have been produced with the updated coefficients. Data prior to the resolution date will be reprocessed prior to the first NEON data release. An additional changelog comment will be entered at that time.
    Date Range: 2019-12-11 to 2019-12-11
    Location(s) Affected: All
Resolution Date: 2019-12-11
Resolution: 2019-12-11: Updated coefficients used in processing.
2020-06-10: All data reprocessed with correct coefficients.
Issue Date: 2019-10-02
Issue: Sensor buried under sediment
    Date Range: 2018-10-13 to 2019-11-15
    Location(s) Affected: PRIN (HOR.VER: 101.100)
    Date Range: 2019-08-30 to 2019-09-04
    Location(s) Affected: KING (HOR.VER: 101.100)
    Date Range: 2019-09-23 to 2019-10-08
    Location(s) Affected: SYCA (HOR.VER: 102.100, 101.100)
    Date Range: 2019-09-27 to 2019-10-10
    Location(s) Affected: CUPE (HOR.VER: 102.100)
    Date Range: 2019-11-29 to 2019-12-16
    Location(s) Affected: SYCA (HOR.VER: 102.100)
    Date Range: 2020-02-14 to 2020-02-27
    Location(s) Affected: PRIN (HOR.VER: 101.100)
    Date Range: 2020-03-05 to 2020-03-09
    Location(s) Affected: PRIN (HOR.VER: 101.100)
Resolution Date: 2019-09-04
Resolution: Sensor unburied, manual flagging applied
Issue Date: 2019-06-24
Issue: Sensor damage caused erroneous data
    Date Range: 2019-05-22 to 2019-06-21
    Location(s) Affected: BLDE (HOR.VER: 101.100)
    Date Range: 2020-02-06 to 2020-06-01
    Location(s) Affected: LECO (HOR.VER: 112.100)
    Date Range: 2020-07-30 to 2020-11-19
    Location(s) Affected: CUPE (HOR.VER: 101.100)
    Date Range: 2020-08-20 to 2020-12-29
    Location(s) Affected: MAYF (HOR.VER: 101.100)
Resolution Date: 2019-06-21
Resolution: Sensor replaced, manual flagging applied.
Issue Date: 2019-05-21
Issue: Sensor out of water
    Date Range: 2018-10-29 to 2018-11-22
    Location(s) Affected: MCRA (HOR.VER: 101.100)
    Date Range: 2019-02-15 to 2019-03-15
    Location(s) Affected: SYCA (HOR.VER: 102.100)
    Date Range: 2019-05-21 to 2019-05-23
    Location(s) Affected: HOPB (HOR.VER: 102.100)
Resolution Date: 2019-03-07
Resolution: Sensor submerged. Manual flagging applied
Issue Date: 2019-02-19
Issue: Incorrect calibration information was applied to data for some sites and time periods.
    Date Range: 2018-01-01 to 2018-10-31
    Location(s) Affected: All locations.
Resolution Date: 2019-02-19
Resolution: Data reprocessed with correct calibration information.
Issue Date: 2018-12-04
Issue: PRT became at 101.100 was least partially exposed. PRT at 102.100 has incorrect calibration coefficients.
    Date Range: 2017-09-01 to 2018-09-01
    Location(s) Affected: ARIK (HOR.VER: 101.100 and 102.100)
Resolution Date: 2018-12-04
Resolution: Manual flagging applied.
Issue Date: 2018-12-02
Issue: PRT became at least partially exposed.
    Date Range: 2017-04-01 to 2018-11-01
    Location(s) Affected: MCDI (HOR.VER: 101.100)
    Date Range: 2018-02-01 to 2018-08-01
    Location(s) Affected: SYCA (HOR.VER: 101.100 and 102.100)
    Date Range: 2018-06-14 to 2018-09-02
    Location(s) Affected: MART(HOR.VER: 101.100)
    Date Range: 2018-10-10 to 2018-11-01
    Location(s) Affected: KING (HOR.VER: 101.100 and 102.100)
    Date Range: 2019-07-24 to 2019-11-21
    Location(s) Affected: WLOU (HOR.VER: 101.100)
    Date Range: 2019-08-11 to 2019-08-23
    Location(s) Affected: PRIN (HOR.VER: 101.100 and 102.100)
    Date Range: 2019-08-24 to 2019-08-25
    Location(s) Affected: BLUE  (HOR.VER: 112.100)
    Date Range: 2019-09-15 to 2019-10-12
    Location(s) Affected: ARIK (HOR.VER: 101.100)
    Date Range: 2019-12-11 to 2019-12-11
    Location(s) Affected: WLOU (HOR.VER: 102.100)
    Date Range: 2020-06-25 to 2020-11-02
    Location(s) Affected: ARIK (HOR.VER: 101.100)
    Date Range: 2020-09-11 to 2020-11-02
    Location(s) Affected: ARIK (HOR.VER: 102.100)
Resolution Date: 2018-12-02
Resolution: Manual flagging applied.
Issue Date: 2018-11-30
Issue: PRT became at least partially exposed as water receded and sensors were not yet lowered.
    Date Range: 2018-05-04 to 2018-06-04
    Location(s) Affected: HOPB (HOR.VER: 101.100)
    Date Range: 2018-05-16 to 2018-09-01
    Location(s) Affected: PRIN (HOR.VER: 102.100)
    Date Range: 2018-06-23 to 2018-06-26
    Location(s) Affected: PRIN (HOR.VER: 101.100)
    Date Range: 2020-05-01 to 2020-06-03
    Location(s) Affected: CARI (HOR.VER: 102.100, 101.100)
Resolution Date: 2018-11-30
Resolution: Manual flagging applied.
Issue Date: 2018-06-13
Issue: PRT became partially exposed as water receded and sensors were not yet lowered.
    Date Range: 2018-04-26 to 2018-06-14
    Location(s) Affected: MART (HOR.VER: 101.100)
    Date Range: 2019-05-31 to 2020-08-27
    Location(s) Affected: POSE (HOR.VER: 101.100)
Resolution Date: 2018-06-13
Resolution: Manual flagging applied. Sensors to be lowered back into water.
Issue Date: 2018-04-05
Issue: infrastructure were damaged due to flooding.
    Date Range: 2018-03-27 to 2018-03-28
    Location(s) Affected: CUPE (101.100; 102.100)
    Date Range: 2018-10-13 to 2018-10-18
    Location(s) Affected: PRIN (HOR.VER: 102.100)
Resolution Date: 2018-04-05
Resolution: Manual flagging applied. Sensor offline while site awaits repair.
Issue Date: 2018-03-27
Issue: Infrastructure damage to S1 from high flow event and calibration not verified prior to site repair.
    Date Range: 2018-02-21 to 2018-02-26
    Location(s) Affected: PRIN (101.100)
Resolution Date: 2018-03-27
Resolution: Manual flagging applied. Sensor offline while site awaits repair.
Issue Date: 2018-03-27
Issue: Infrastructure damage to S2 from high flow event and calibration not verified prior to site repair.
    Date Range: 2018-02-21 to 2018-03-22
    Location(s) Affected: PRIN (102.100)
Resolution Date: 2018-03-27
Resolution: Manual flagging applied. Sensor offline while site awaits repair.
Issue Date: 2018-02-05
Issue: S2 submerged and sensor position altered due to infrastructure damage from high flow event. Data are still usable.
    Date Range: 2017-10-30 to 2017-11-07
    Location(s) Affected: HOPB
Resolution Date: 2017-11-07
Resolution: Sensor offline while site awaits repair.
ADDITIONAL INFORMATION
----------------------
NEON DATA POLICY AND CITATION GUIDELINES
----------------------------------------
A citation statement is available in this data product's detail page at
https://data.neonscience.org/data-products/DP1.20053.001. Please visit https://www.neonscience.org/data-policy for
more information about NEON's data policy and citation guidelines.
DATA QUALITY AND VERSIONING
---------------------------
NEON data are initially published with a status of Provisional, in which updates to data and/or processing
algorithms will occur on an as-needed basis, and query reproducibility cannot be guaranteed. Once data are published
as part of a Data Release, they are no longer provisional, and are associated with a stable DOI.
To learn more about provisional versus released data, please visit
https://www.neonscience.org/data-revisions-releases.
