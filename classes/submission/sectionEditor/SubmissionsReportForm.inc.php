<?php

/**
 * @defgroup sectionEditor_form
 */

/**
 * @file /classes/submission/sectionEditor/form/SubmissionReportForm.inc.php
 *
 * Added by MSB. Last Updated: Oct 13, 2011
 * @class SubmissionsReportForm
 * @ingroup sectionEditor_form
 *
 * @brief Form for section editors to generate meeting attendance report form.
 */


import('lib.pkp.classes.form.Form');
import('classes.submission.common.Action');

class SubmissionsReportForm extends Form {
	/**
	 * Constructor.
	 */
	function SubmissionsReportForm() {
		parent::Form('sectionEditor/reports/submissionsReport.tpl');
		// Validation checks for this form
		$this->addCheck(new FormValidatorPost($this));
		//$this->addCheck(new FormValidator($this,'countries', 'required', 'editor.reports.countryRequired'));
		//$this->addCheck(new FormValidator($this,'decisions', 'required', 'editor.reports.decisionRequired'));
	}
	        
        function display() {
                $journal = Request::getJournal();
            
		$countryDao =& DAORegistry::getDAO('CountryDAO');
                $proposalDetailsDao =& DAORegistry::getDAO('ProposalDetailsDAO');
                $regionDAO =& DAORegistry::getDAO('AreasOfTheCountryDAO');
		$institutionDao =& DAORegistry::getDAO('InstitutionDAO');
		$riskAssessmentDao =& DAORegistry::getDAO('RiskAssessmentDAO');
		$currencyDao =& DAORegistry::getDAO('CurrencyDAO');
		$sectionDao =& DAORegistry::getDAO('SectionDAO');
		
                $sectionOptions = array('0' => Locale::translate('editor.reports.anyCommittee')) + $sectionDao->getSectionTitles($journal->getId());
                $decisionTypes = array(
                    INITIAL_REVIEW => 'submission.initialReview',
                    CONTINUING_REVIEW => 'submission.continuingReview',
                    PROTOCOL_AMENDMENT => 'submission.protocolAmendment',
                    SERIOUS_ADVERSE_EVENT => 'submission.seriousAdverseEvents',
                    END_OF_STUDY => 'submission.endOfStudy'
		);
		$decisionOptions = array(
                    98 => 'editor.reports.aDecisionsIUR',
                    99 => 'editor.reports.aDecisionsEUR',
                    SUBMISSION_SECTION_DECISION_APPROVED => 'editor.article.decision.approved',
                    SUBMISSION_SECTION_DECISION_RESUBMIT => 'editor.article.decision.resubmit',
                    SUBMISSION_SECTION_DECISION_DECLINED => 'editor.article.decision.declined'
		);
                $budgetOptions = array(
                    ">=" => 'editor.reports.budgetSuperiorTo',
                    "<=" => 'editor.reports.budgetInferiorTo'
		);
                $sourceCurrencyId = $journal->getSetting('sourceCurrency');
                $reportTypeOptions = array(
                    0 => 'editor.reports.type.spreadsheet',
                    1 => 'editor.reports.type.pieChart',
                    2 => 'editor.reports.type.barChart'
		);
                $measurementOptions = array(
                    0 => 'editor.reports.measurement.proposalNmbre',
                    1 => 'editor.reports.measurement.cumulatedBudget'
                );
                $chartOptions = array(
                    'studentResearch' => Locale::translate('proposal.studentInitiatedResearch'),
                    'kii' => Locale::translate('proposal.keyImplInstitution'),
                    'multiCountry' => Locale::translate('proposal.multiCountryResearch'),
                    'nationwide' => Locale::translate('proposal.nationwide'),
                    'researchFields' => Locale::translate('proposal.researchField'),
                    'proposalTypes' => Locale::translate('proposal.proposalType'),
                    'dataCollection' => Locale::translate('proposal.dataCollection'),
                    'getIdentityRevealed' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.identityRevealedAbb'),
                    'getUnableToConsent' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.unableToConsentAbb'),
                    'getUnder18' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.under18Abb'),
                    'getDependentRelationship' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.dependentRelationshipAbb'),
                    'getEthnicMinority' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.ethnicMinorityAbb'),
                    'getImpairment' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.impairmentAbb'),
                    'getPregnant' => Locale::translate("editor.reports.riskAssessment.subjects").' - '.Locale::translate('proposal.pregnantAbb'),
                    'getNewTreatment' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.newTreatmentAbb'),
                    'getBioSamples' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.bioSamplesAbb'),
                    'exportHumanTissue' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.exportHumanTissueAbb'),
                    'exportReason' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.exportReason'),                    
                    'getRadiation' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.radiationAbb'),
                    'getDistress' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.distressAbb'),
                    'getInducements' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.inducementsAbb'),
                    'getSensitiveInfo' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.sensitiveInfoAbb'),
                    'getReproTechnology' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.reproTechnologyAbb'),
                    'getGenetic' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.geneticsAbb'),
                    'getStemCell' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.stemCellAbb'),
                    'getBiosafety' => Locale::translate("editor.reports.riskAssessment.researchIncludes").' - '.Locale::translate('proposal.biosafetyAbb')
                );
                
                
                
                $templateMgr =& TemplateManager::getManager();
                $templateMgr->assign('sectionOptions', $sectionOptions);
		$templateMgr->assign('decisionTypes', $decisionTypes);
		$templateMgr->assign('decisionOptions', $decisionOptions);
                $templateMgr->assign('proposalDetailYesNoArray', $proposalDetailsDao->getYesNoArray());
                $templateMgr->assign('institutionsList', $institutionDao->getInstitutionsList());
                $templateMgr->assign('coutryList', $countryDao->getCountries());
                $templateMgr->assign('geoAreasList', $regionDAO->getAreasOfTheCountry());
                $templateMgr->assign('researchFieldsList', $proposalDetailsDao->getResearchFields());
                $templateMgr->assign('proposalTypesList', $proposalDetailsDao->getProposalTypes());
                $templateMgr->assign('dataCollectionArray', $proposalDetailsDao->getDataCollectionArray());
                $templateMgr->assign('budgetOptions', $budgetOptions);                
                $templateMgr->assign('sourceCurrency', $currencyDao->getCurrencyByAlphaCode($sourceCurrencyId));
                $templateMgr->assign('riskAssessmentYesNoArray', $riskAssessmentDao->getYesNoArray());
                $templateMgr->assign('riskAssessmentExportReasonArray', $riskAssessmentDao->getExportReasonArray());
                $templateMgr->assign('reportTypeOptions', $reportTypeOptions);
                $templateMgr->assign('measurementOptions', $measurementOptions);
                $templateMgr->assign('chartOptions', $chartOptions);
                
     	        parent::display();
	}     
}

?>
