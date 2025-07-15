USE [kratos]
GO

/****** Object:  View [dbo].[vwRushmore]    Script Date: 7/15/2025 8:31:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






 
ALTER view [dbo].[vwRushmore]
 
as
 
SELECT
 
L.LoanNumber,
[Mr.CooperLoan] = Null,  
[InvestorLoan] = Null,   
CASE WHEN  CD.BorrowerUnparsedName1 IS NOT NULL AND CD.BorrowerUnparsedName1 <> ''     
     THEN CD.BorrowerUnparsedName1
       ELSE B1.LastName 
       END AS [Borrower Last or Corp/Trust],
B1.FirstName AS BorrowerFirstName,
B1.MiddleName AS BorrowerMiddleName,
B1.LastName AS BorrowerLastName,
B1.SuffixToName AS BorrowerSuffixName,
B1.TaxIdentificationIdentifier AS MortgagorSSN,
B1.HomePhoneNumber AS MortgagorPrimaryPhone,
B1.MobilePhone AS MortgagorSecondaryPhone,
B1.EmailAddressText AS MortgagorEmailAddress,
B2.FirstName AS CoMortgagorFirstName,
B2.MiddleName AS CoMortgagorMiddleName,
B2.LastName AS CoMortgagorLastName,
B2.SuffixToName AS CoMortgagorSuffixName,
B2.TaxIdentificationIdentifier AS CoMortgagorSSN,
B2.HomePhoneNumber AS CoMortgagorPhone,
B2.EmailAddressText AS CoMortgagorEmail,
B3.FirstName AS Borrower3FirstName,
B3.MiddleName AS Borrower3MiddleName,
B3.LastName AS Borrower3LastName,
B3.TaxIdentificationIdentifier AS Borrower3SSN,
B3.AddressStreetLine1 AS Borrower3Address,
B3.AddressCity AS Borrower3City,  
B3.AddressState AS Borrower3State,  
B3.AddressPostalCode AS Borrower3Zip,	 
B3.HomePhoneNumber AS Borrower3Phone,
B4.FirstName AS Borrower4FirstName,
B4.MiddleName AS Borrower4MiddleName,
B4.LastName AS Borrower4LastName,
B4.TaxIdentificationIdentifier AS Borrower4SSN,
B4.AddressStreetLine1 AS Borrower4Address,
B4.AddressCity AS Borrower4City,  
B4.AddressState AS Borrower4State,  
B4.AddressPostalCode AS Borrower4Zip,
B4.HomePhoneNumber AS Borrower4Phone,
B5.FirstName AS Borrower5FirstName,
B5.MiddleName AS Borrower5MiddleName,
B5.LastName AS Borrower5LastName,
B5.TaxIdentificationIdentifier AS Borrower5SSN,
B5.AddressStreetLine1 AS Borrower5Address,
B5.AddressCity AS Borrower5City,
B5.AddressState AS Borrower5State,
B5.AddressPostalCode AS Borrower5Zip, 
B5.HomePhoneNumber AS Borrower5Phone,
B6.FirstName AS Borrower6FirstName,
B6.MiddleName AS Borrower6MiddleName,
B6.LastName AS Borrower6LastName,
B6.TaxIdentificationIdentifier AS Borrower6SSN,
B6.AddressStreetLine1 AS Borrower6Address,
B6.AddressCity AS Borrower6City, 
B6.AddressState AS Borrower6State,
B6.AddressPostalCode AS Borrower6Zip,
B6.HomePhoneNumber AS Borrower6Phone,
B7.FirstName AS Borrower7FirstName,
B7.MiddleName AS Borrower7MiddleName,
B7.LastName AS Borrower7LastName,
B7.TaxIdentificationIdentifier AS Borrower7SSN,
B7.AddressStreetLine1 AS Borrower7Address,
B7.AddressCity AS Borrower7City, 
B7.AddressState AS Borrower7State,
B7.AddressPostalCode AS Borrower7Zip,
B7.HomePhoneNumber AS Borrower7Phone,
B8.FirstName AS Borrower8FirstName,
B8.MiddleName AS Borrower8MiddleName,
B8.LastName AS Borrower8LastName,
B8.TaxIdentificationIdentifier AS Borrower8SSN,
B8.AddressStreetLine1 AS Borrower8Address,
B8.AddressCity AS Borrower8City, 
B8.AddressState AS Borrower8State,
B8.AddressPostalCode AS Borrower8Zip,
B8.HomePhoneNumber AS Borrower8Phone,
A.ApplicationIndex,
P.StreetAddress AS SubjectProjectAddress,
P.City AS SubjectPropertyCity,
P.State AS SubjectPropertyState,
P.PostalCode As SubjectPropertyZip,
R.URLA2020StreetAddress AS BorrowerMailingAddress, 
R.AddressCity AS BorrowerMailingCity,
R.AddressState AS BorrowerMailingState,
R.AddressPostalCode AS BorrowerMailingZip,
LoanType = CASE WHEN L.MortgageType = 'FHA' THEN '01'
                WHEN L.MortgageType = 'VA' THEN '04'
                WHEN CF6.StringValue = 'X' THEN '32' -- Texas A6
                WHEN LPD.LienPriorityType = 'SecondLien' THEN '16' --HELOC Closed
                WHEN CF7.StringValue = 'Y' THEN 39
                WHEN LPD.MiCoveragePercent Is Not Null THEN '05' -- Conventional Insured 
                ELSE '03' --Conventional Uninsured
               END,
L.OtherMortgageTypeDescription AS LoanTypeOtherDescription ,
LPD.LienPriorityType AS LienPosition,
Hud1Es.EscrowPayment AS EscrowMonthlyPaymentAmount,  
L.ProposedFirstMortgageAmount AS CurrentMonthlyPrincipalandInterestPayment,  
L.BaseLoanAmount AS CurrentUnpaidPrinicpalBalance,
L.PropertyAppraisedValueAmount AS CurrentAppraisedValue,
L.PropertyAppraisedValueAmount AS OriginalAppraisedValue,
L.PurchasePriceAmount AS SubjectPropertyPurchasePrice,
L.ProposedRealEstateTaxesAmount AS MonthlyTaxes,   
CC.Section1000BorrowerPaidTotalAmount AS CurrentEscrowBalance,
CASE WHEN Fee1.BorPaidAMount > 0 THEN 'Y' 
    ELSE 'N'
END AS PropertyTaxesImpounded,
CASE WHEN Fee2.BorPaidAMount > 0 THEN 'Y' 
    ELSE 'N'
END AS HomeownerInsuranceImpounded,
L.ProposedHazardInsuranceAmount AS HazardMonthlyPremium,
Fee1.MonthlyPayment AS FloodInsuranceMonthlyPremium, 
ISNULL(L.ProposedHazardInsuranceAmount, 0) + ISNULL(Fee1.MonthlyPayment, 0) AS [TotalHazard/FloodMonthlyPremium],
RL.CorrespondentFinalCDCityPropertyTax AS CityMonthlyTaxAmount,	
AdditionalImpound = Null,		      
L.BaseLoanAmount AS NoteBalance,
L.ExistingLiensAndDrawUsed AS LienCurrentAmtOwing1,	
CDIS.PPC1MaximumMonthlyPayment AS TotalMonthlyPayment,	      
FhaVaLoan.ClosingDate AS NoteDate,    -- changed from CD.DocumentPreparationDate 
LPD.ScheduledFirstPaymentDate AS FirstPymtDate,
L.MaturityDate AS LoanMaturityDate,
US.AppraisalCompletedDate,
L.RequestedInterestRatePercent AS AnnualInterestRate,
PaymentPeriod = 'Monthly',
VLD.CreditScore AS LockRequestCreditScoreForDecisionMaking,
CF.DateValue AS CreditScoreDate,
A.PropertyUsageType AS [Occupancy (P/S/I)],                     
RL.FinancedNumberOfUnits AS SubjectPropertyUnits,
Hmda.LoanPurpose,
L.LoanAmortizationTermMonths AS LoanTerm, -- changed from FhaVaLoan.ProposedMaturityYears
PR.County AS SubjectPropertyCounty,
ThePercentageOfOwnershipInterestIs = 100,
OriginalOccStatus = A.PropertyUsageType,
Hmda.LoanPurpose AS LoanPurposeSummary,
SubjectPropertyType = CASE WHEN LPD.GsePropertyType Like '%Condo%' THEN '04'
                           WHEN LPD.GsePropertyType = 'PUD' THEN '22'
                           WHEN LPD.GsePropertyType Like 'Manufacture%' THEN '14'
                      ELSE '01'
                      END, 
ATRQMC.IsHigherPricedLoan AS [HPMLFlagDoesTheLoanExceedThreshold?],
HpmlEscrowWaiverReason = NULL,
HpmlEscrowWaiverExpDate = NULL,
Hmda.QMStatus AS QMStatus,
VaLoanNumber = CASE WHEN L.MortgageType = 'VA' THEN 
        L.AgencyCaseIdentifier
        ELSE NULL
        END,
FhaLoanNumber = CASE WHEN L.MortgageType = 'FHA' THEN 
        LEFT(L.AgencyCaseIdentifier,11)
        ELSE NULL
        END,
AdpCode = CASE WHEN L.MortgageType = 'FHA' THEN 
        RIGHT(L.AgencyCaseIdentifier,3)
        ELSE NULL
        END,
InvestorPoolContractNum =TSUM.CommitmentNumber,
L.MersNumber AS MERSMin#,
L.MersNumberRegistrationDate AS MERSRegistrationDate,
'1015163' AS [MERSID#],
[MERSMOMFlag] = CASE WHEN '1015163' IS NOT NULL THEN 
        'Y'
        ELSE 'N'
        END,
CON2.InsuranceDeterminationDate AS FloodInfoDeterminationDate,
CON2.InsuranceDeterminationNumber AS FloodInfoDeterminationNumber,
CD.SpecialFloodHazardAreaIndictor AS PropertyInfoFloodZone,
TQL.FloodProgramCode,
TQL.LomaOrLomrDate,
TQL.LomaOrLomrCaseNumber,
DN.NFIPParticipationStatus AS CertificationType,
CON2.InsuranceCertNumber AS CertificateNumber,
DN.NFIPCommunityNumber AS CommunityNumber,
SUBSTRING(DN.MapPanelNumber, 7, 4) AS PanelNumber,
SUBSTRING(DN.MapPanelNumber, 11, 1) AS SuffixNumber,
CD.SpecialFloodHazardAreaIndictor AS ZoneIndicator,
DN.NFIPMapEffectiveRevisedDate AS MapDate,
MappingCompany = 'SnapFlood',
DN.NFIPMapEffectiveRevisedDate AS CommunityParticipationDate,
RZ.MaximumLateCharge,
RZ.LateChargePercent AS [LateCharge%], 
RZ.LateChargeType AS LateChargeCode,
RZ.MinimumLateCharge,
RZ.LateChargeDays AS [GracePeriod#ofDays(Late Charge Days)],
MIPPolicyExpirationDate = Null,  --TO DOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
MIP1stDueDate = CASE WHEN LPD.MiCoveragePercent Is Not Null THEN
                    LPD.ScheduledFirstPaymentDate
                    ELSE Null
                    END,
RZ.PmiIndicator,
CASE WHEN L.MortgageType = 'FHA' THEN 
L.ProposedMortgageInsuranceAmount * 12
        ELSE NULL
        END AS [MIP/PMIAnnualPremium],
L.ProposedMortgageInsuranceAmount AS [MIP PremiumAmount],
L.ProposedMortgageInsuranceAmount AS [MIP/PMIMonthlyPremiumAmt], -- Changed From IntS.NextPaymentEscrowMortgageInsurance
L.Ltv AS LTV,
AR.MaximumDeductibleHazardPercentage,
AR.MaximumDeductibleHazardAmount,
LPD.PrepaymentPenaltyIndicator AS [Prepymt-May/WillNotPenalty],
Gfe.PrepaymentPenaltyPeriod,
LoanInfoBuydown = Null,
ULDDPoolBalloonIndicator = Null,
Hmda.LoanAmount,
--Amort Type ARM Descr,
LE2.firstChangeFrequencyMonth,
LPD.IndexLookbackPeriod AS ARMIndexLookbackPeriod,
LPD.RoundPercent AS [LoanInfoARMRoundIndexTo%],
Hmda.HmdaInterestOnlyIndicator AS InterestOnlyIndicator,
LPD.RateAdjustmentPercent AS FirstRateAdjustmentCap,
LPD.MaxLifeInterestCapPercent AS MaxRate,
LPD.FloorPercent AS MinRate,
LPD.IndexMarginPercent AS Margin,
LPD.RateAdjustmentDurationMonthsCount AS RateChangeFreq,
LPD.RateAdjustmentDurationMonthsCount AS PaymentChangeFreq,
LPD.RateAdjustmentSubsequentCapPercent AS SubsequentCapUp,
LPD.RateAdjustmentSubsequentCapPercent AS SubsequentCapDown,
LPD.RateAdjustmentPercent AS [1stCapDown],
LPD.IndexMarginPercent AS TheMinimumRateAfterTheFirstRateChange,
Hmda.InterestRate AS TheMaximumRateAfterTheFirstRateChange,
[HAZ TYPE 01] = 50,
CON1.ContactName AS HAZAGENT01,
CON1.InsuranceRenewalDate AS HazDueDT1,
CON1.InsuranceRenewalDate AS HazExpires1,
CON1.InsurancePremium AS HaxPremAmt1,
[HazardTerm01] = 12,
CON1.InsuranceCoverageAmount AS HazCovAmt1,
HazPayType01 = CASE WHEN Gfe2010.HasEscrowHomeownerInsurancesIndicator = 1 THEN 
        'ESCROWED'
        ELSE 'NON-ESCROWED'
        END,
[HazardCoverageCD01] = 'HazardInsurance',
CON1.ReferenceNumber AS HazardPolicyNumber1,
CON1.Address AS HazardInsCoAddr1,
CON1.Phone AS HazardInsCoRefNum1,
CON1.City AS HazardInsCoCity1,
CON1.State AS HazardInsCoState1,
CON1.PostalCode AS PostalCode1,
HazType02 = 51,
CON2.ContactName AS HAZAGENT02,
CON2.InsuranceRenewalDate AS HazDueDT2,
CON2.InsuranceRenewalDate AS HazExpires2,
CON2.InsurancePremium AS HaxPremAmt2,
[HazardTerm02] = 12,
CON2.InsuranceCoverageAmount AS HazCovAmt2,
HazPayType02 = CASE WHEN Gfe2010.HasEscrowFloodInsurancesIndicator = 1 THEN 
        'ESCROWED'
        ELSE 'NON-ESCROWED'
        END,
[HazardCoverageCD2] = 'FloodInsurance',
CON2.ReferenceNumber AS HazardPolicyNumber2,
CON2.Address AS HazardInsCoAddr2,
CON2.Phone AS HazardInsCoRefNum2,
CON2.City AS HazardInsCoCity2,
CON2.State AS HazardInsCoState2,
CON2.PostalCode AS PostalCode2,
HazType03 = CASE WHEN Fee5.Description LIKE '%Wind%' THEN 
                    53 
                 WHEN Fee.Description LIKE '%Earthquake%' THEN
                    54
                 ELSE 50
                 END,
CON3.ContactName AS HAZAGENT3,
CON3.NextDueDate AS HazDueDT3,
CON3.RenewalDate AS HazExpires3,
CON3.Premium AS HaxPremAmt03,
[HazardTerm03] = 12,
CON3.CoverageAmount AS HazCovAmt3,
HazPayType03 = CASE WHEN Gfe2010.HasEscrowUserDefinedIndicator1 = 1 THEN 
        'ESCROWED'
        ELSE 'NON-ESCROWED'
        END,
Fee5.Description AS HazardCoverageCD3,
CON3.PolicyNumber AS HazardPolicyNumber3,
CON3.Address AS HazardInsCoAddr3,
CON3.Phone AS HazardInsCoRefNum3,
CON3.City AS HazardInsCoCity3,
CON3.State AS HazardInsCoState3,
CON3.PostalCode AS PostalCode3,
HazType04 = CASE WHEN Fee6.Description LIKE '%Wind%' THEN 
                53 
                 WHEN Fee6.Description LIKE '%Earthquake%' THEN
                54
                ELSE 50
                END,
CON4.Address AS HazAgent4,
CON4.RenewalDate AS HazExpires4,
CON4.Premium AS HazPremAmt4,
HazardTerm04 = 12,
CON4.CoverageAmount AS HazCovAmt4,
HazPayType04 = CASE WHEN Gfe2010.HasEscrowUserDefinedIndicator2 = 1 THEN 
        'ESCROWED'
        ELSE 'NON-ESCROWED'
        END,
Fee6.Description AS HazardCoverageCD4, 
CON4.PolicyNumber AS HazardPolicyNumber4,
CON4.Address AS HazardInsCoAddr4,
CON4.Phone AS HazardInsCoRefNum4,
CON4.City AS HazardInsCoCity4,
CON4.State AS HazardInsCoState4,
CON4.PostalCode AS PostalCode4,
HazType05 = CASE WHEN Fee7.Description LIKE '%Wind%' THEN 
                53 
                 WHEN Fee7.Description LIKE '%Earthquake%' THEN
                54
                ELSE 50
                END,
CON5.Address AS HazAgent5,
CON5.RenewalDate AS HazExpires5,
CON5.Premium AS HazPremAmt5,
HazardTerm05 = 12,
CON5.CoverageAmount AS HazCovAmt5,
HazPayType05 = CASE WHEN Gfe2010.HasEscrowUserDefinedIndicator3 = 1 THEN 
        'ESCROWED'
        ELSE 'NON-ESCROWED'
        END,
Fee7.Description AS HazardCoverageCD5, 
CON5.PolicyNumber AS HazardPolicyNumber5,
CON5.Address AS HazardInsCoAddr5,
CON5.Phone AS HazardInsCoRefNum5,
CON5.City AS HazardInsCoCity5,
CON5.State AS HazardInsCoState5,
CON5.PostalCode AS PostalCode5,
B1.Birthdate AS BorrDOB,
B2.Birthdate AS CoBorrDOB,
Fee3.BorPaidAmount AS InterestCollectingAtClosing, 
RZ.InterestOnlyMonths,
LPD.SubsequentRateAdjustmentMonthsCount AS LoanInfoARMFirstPeriodChange,
CD.BorrowerUnparsedName1 AS BorrowerVestingBorr1CorpTrustName,
CD.BorrowerTaxIdentificationNumberIdentifier1 AS BorrowerVestingBorr1OrgTaxID,
L.LoanProgramName AS LoanProgram,
--Add Impound Type
Fee4.PaidToName AS AddImpoundAgent,
Fee4.PaidToName AS AddImpoundCo,
--Add Impound Expires
--Add Impound Prem Amt
--Add Impound Coverage Amt
--Add Impound Pay Type
--Add Impound Policy #
--Add Impound Co Address
--Add Impound Co City
--Add Impound Co State
--Add Impound Co Zip
--Add Impound Co Phone#
Hmda.UniversalLoanId,
RON = 'No',
--WI Escrow Election for Reporting
Fee3.BorPaidAmount AS MortgageInterest,
M.PointsPaid AS BorrInfoPointsPaid,
Fee3.BorPaidAmount AS [1098.s(Interest)],
--Prorate for 750K Cap CX.1098.R (points)
LPD.PrepaymentPenaltyPercent AS [RegZPrepymntPenaltyAsA%],
L.AgencyCaseIdentifier AS AgencyCaseNum,
RL.[Date] AS PurchaseAdviceDate,
L.ProposedFirstMortgageAmount AS OriginalPlPmt,
L.RequestedInterestRatePercent AS OriginalNoteRate,
US.AppraisalCompletedDate AS OriginalAppraisalDate, 
CD.DisbursementDate AS PurchaseSettlementDate,
--=right([NOTICES.X97],1)
Hmda.CountyCode AS FIPSCountyCode,  
LPD.ScheduledFirstPaymentDate AS NextDue, 
CF1.StringValue AS MailingAddress1, 
CF2.StringValue AS MailingCity,
CF3.StringValue AS MailingState,
CF4.StringValue AS MailingZip,
ITIN = CASE WHEN CF5.StringValue = 'X' then 1 
        ELSE Null
        END,
L.LoanAmortizationType AS MortgageInst,
FhaMipUpfrontFinanced = CASE WHEN L.MortgageType = 'FHA' THEN 
        L.MiAndFundingFeeFinancedAmount
        ELSE NULL
        END,
VaGuaranteedRate = CASE WHEN L.MortgageType = 'VA' THEN
		L.MortgageInsurancePremiumUpfrontFactorPercent
		ELSE NULL
		END,
LpmiRate = CASE WHEN RZ.LenderPaidMortgageInsuranceIndicator = 1 THEN
		L.MiAndFundingFeeFinancedAmount
		ELSE NULL
		END,
IntOnlyAmortDueDate = CASE WHEN RZ.InterestOnlyMonths > 0 AND LPD.ScheduledFirstPaymentDate IS NOT NULL THEN
		DATEADD(MONTH, RZ.InterestOnlyMonths, LPD.ScheduledFirstPaymentDate)
		ELSE NULL
		END,
CurrentAppraisalDate = CASE WHEN US.AppraisalCompletedDate IS NOT NULL THEN
		US.AppraisalCompletedDate
		ELSE ReviewCompletedDate
		END,
LPD.MiCoveragePercent AS MiPercentCov,
HLD.CaseAssignedDate AS FhaCaseCreationDate,
FhaMipUpfrontFinancedENum = CASE WHEN L.MortgageType = 'FHA' THEN
CASE WHEN L.FirstTimeHomebuyersIndicator = 1 THEN
		4
		ELSE 1
		END
		ELSE NULL
		END,
FhaStreamlineRefiFlag = CASE WHEN L.LoanPurposeOfRefinanceType like 'Streamline%' THEN
		1
		ELSE NULL
		END,
R.Country AS MailingCountry,
FirstDateChange = CASE WHEN L.LoanAmortizationType = 'AdjustableRate' THEN
		DATEADD(MONTH, LPD.SubsequentRateAdjustmentMonthsCount, LPD.ScheduledFirstPaymentDate)
		ELSE NULL
		END,
LPD.RateAdjustmentDurationMonthsCount AS RemainingAdjPeriodMths,
LPD.ArmDisclosureType AS CurrentIndex,
NextIntAdjDate = CASE WHEN L.LoanAmortizationType = 'AdjustableRate' THEN
		DATEADD(MONTH, LPD.SubsequentRateAdjustmentMonthsCount, LPD.ScheduledFirstPaymentDate)
		ELSE NULL
		END,
NextPIAdjDate = CASE WHEN L.LoanAmortizationType = 'AdjustableRate' THEN
		DATEADD(MONTH, LPD.SubsequentRateAdjustmentMonthsCount, LPD.ScheduledFirstPaymentDate)
		ELSE NULL
		END







FROM [WIN-T0FCRL091AK].Encompass.elliedb.LOAN L

LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LOANMETADATA LM ON LM.ENCOMPASSID = L.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.BORROWER B1 ON B1.ENCOMPASSID = LM.ENCOMPASSID AND B1.BorrowerIndex is Null
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Application A ON B1.APPLICATIONID = A.APPLICATIONID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDocument CD ON CD.ENCOMPASSID = A.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property P ON P.ENCOMPASSID = CD.ENCOMPASSID
lEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Residence R ON R.applicationid = B1.applicationid AND R.MailingAddressIndicator = 1
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanProductData LPD ON R.ENCOMPASSID = LPD.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.InterimServicing IntS ON IntS.ENCOMPASSID = LPD.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.UnderwriterSummary US ON US.ENCOMPASSID = IntS.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.VaLoanData VLD ON VLD.ENCOMPASSID = US.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF ON CF.ENCOMPASSID = VLD.ENCOMPASSID AND CF.FieldName = 'CX.CREDITEFFECTIVE' 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Property PR ON PR.ENCOMPASSID = CF.ENCOMPASSID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hmda ON Hmda.ENCOMPASSID = PR.ENCOMPASSID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.FhaVaLoan ON FhaVaLoan.ENCOMPASSID = Hmda.ENCOMPASSID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ATRQMCommon ATRQMC ON ATRQMC.ENCOMPASSID = FhaVaLoan.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Contact CON1 ON CON1.ENCOMPASSID = ATRQMC.ENCOMPASSID AND CON1.ContactType = 'HAZARD_INSURANCE'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.DisclosureNotices DN ON DN.ENCOMPASSID = Hmda.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RegulationZ RZ ON RZ.ENCOMPASSID = DN.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.AdditionalRequests AR ON AR.ENCOMPASSID = RZ.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Gfe ON Gfe.ENCOMPASSID = AR.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingCost CC ON CC.ENCOMPASSID = Gfe.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.LoanEstimate2 LE2 ON LE2.ENCOMPASSID = CC.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee ON Fee.ENCOMPASSID = LE2.ENCOMPASSID AND Fee.FeeType = 'HazardInsurancePremium' 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Contact CON2 ON CON2.ENCOMPASSID = LE2.ENCOMPASSID AND CON2.ContactType = 'FLOOD_INSURANCE'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsPayTo CON3 ON CON3.ENCOMPASSID = LE2.ENCOMPASSID AND CON3.Hud1EsPayToIndex = 1
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.RateLock RL ON RL.ENCOMPASSID = LE2.ENCOMPASSID
LEFT JOIN dbo.vwBorrowers B2 on B2.LoanNumber = L.LoanNumber AND B2.BorrowerNum = 2
LEFT JOIN dbo.vwBorrowers B3 on B3.LoanNumber = L.LoanNumber AND B3.BorrowerNum = 3
LEFT JOIN dbo.vwBorrowers B4 on B4.LoanNumber = L.LoanNumber AND B4.BorrowerNum = 4
LEFT JOIN dbo.vwBorrowers B5 on B5.LoanNumber = L.LoanNumber AND B5.BorrowerNum = 5
LEFT JOIN dbo.vwBorrowers B6 on B6.LoanNumber = L.LoanNumber AND B6.BorrowerNum = 6
LEFT JOIN dbo.vwBorrowers B7 on B7.LoanNumber = L.LoanNumber AND B7.BorrowerNum = 7
LEFT JOIN dbo.vwBorrowers B8 on B8.LoanNumber = L.LoanNumber AND B8.BorrowerNum = 8
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.ClosingDisclosure1 CDIS ON CDIS.ENCOMPASSID = RL.ENCOMPASSID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TSUM ON TSUM.ENCOMPASSID = CDIS.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.TQL ON TSUM.ENCOMPASSID = TQL.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF1 ON TQL.EncompassId = CF1.EncompassId and CF1.FieldName = 'CX.SERV.BORRMAILINGADDR'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF2 ON TQL.EncompassId = CF2.EncompassId and CF2.FieldName = 'CX.SERV.BORRMAILINGCITY'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF3 ON TQL.EncompassId = CF3.EncompassId and CF3.FieldName = 'CX.SERV.BORRMAILINGSTATE'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF4 ON TQL.EncompassId = CF4.EncompassId and CF4.FieldName = 'CX.SERV.BORRMAILINGZIP'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF5 on TQL.EncompassId = CF5.EncompassId and CF5.FieldName = 'CX.LP.ITIN'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF6 on TQL.EncompassId = CF6.EncompassId and CF6.FieldName = 'CX.A6TITLEREVIEW'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.CustomField CF7 on TQL.EncompassId = CF7.EncompassId and CF7.FieldName = 'CX.BUSINESSPURPOSE'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Miscellaneous M ON TQL.ENCOMPASSID = M.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee1 ON Fee1.ENCOMPASSID = RL.ENCOMPASSID AND Fee1.FeeType = 'FloodInsuranceReserv' 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee2 ON Fee2.ENCOMPASSID = RL.ENCOMPASSID AND Fee2.FeeType = 'HazardInsurance'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee3 ON TQL.ENCOMPASSID = Fee3.ENCOMPASSID AND Fee3.FeeType = 'PrepaidInterest'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee4 ON M.ENCOMPASSID = Fee4.ENCOMPASSID AND Fee4.FeeType = 'MortgageInsurancePremium'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee5 ON M.ENCOMPASSID = Fee5.ENCOMPASSID AND Fee5.FeeType = 'UserDefined_1006'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee6 ON M.ENCOMPASSID = Fee6.ENCOMPASSID AND Fee6.FeeType = 'UserDefined_1007'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee7 ON M.ENCOMPASSID = Fee7.ENCOMPASSID AND Fee7.FeeType = 'UserDefined_1008'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Fee Fee8 ON M.ENCOMPASSID = Fee8.ENCOMPASSID AND Fee8.FeeType = 'UserDefined_1004'
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hud1Es ON M.ENCOMPASSID = Hud1Es.ENCOMPASSID 
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsPayTo CON5 ON M.ENCOMPASSID = CON5.ENCOMPASSID AND CON5.Hud1EsPayToIndex = 3
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Hud1EsPayTo CON4 ON M.ENCOMPASSID = CON4.ENCOMPASSID AND CON4.Hud1EsPayToIndex = 2
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.HudLoanData HLD ON HLD.ENCOMPASSID = US.ENCOMPASSID
LEFT JOIN [WIN-T0FCRL091AK].Encompass.elliedb.Gfe2010Page Gfe2010 ON Gfe2010.ENCOMPASSID = HLD.ENCOMPASSID 



WHERE A.ApplicationIndex = 0
And R.ApplicantType = 'Borrower'
And LM.LoanFolder IN (

'Archive - Employee',

'Completed - Employee',

'My Pipeline',

'(Archive)',

'Funded - Not Purchased',

'Completed Loans')

;

GO


