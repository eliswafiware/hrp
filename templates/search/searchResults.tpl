{**
 * searchResults.tpl
 *
 * Copyright (c) 2003-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display article search results.
 *
 * $Id$
 *}
{strip}
{assign var=pageTitle value="search.searchResults"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function ensureKeyword() {
	if (document.search.query.value == '') {
		alert({/literal}'{translate|escape:"jsparam" key="search.noKeywordError"}'{literal});
		return false;
	}
	document.search.submit();
	return true;
}

function showExportOptions(){
	$('#exportOptions').show();
	$('#showExportOptions').hide();
	$('#hideExportOptions').show();
}

function hideExportOptions(){
	$('#exportOptions').hide();
	$('#hideExportOptions').hide();
	$('#showExportOptions').show();
}

$(document).ready(
	function (){
		$('#exportOptions').hide();
		$('#hideExportOptions').hide();
	}
);
// -->
{/literal}
</script>

{if !$dateFrom}
{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
{assign var="dateTo" value="--"}
{/if}

<br/>
<form name="revise" action="{url op="advanced"}" method="post">
	<input type="hidden" name="query" value="{$query|escape}"/>
	<div style="display:none">
		{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
	</div>
</form>

<a href="javascript:document.revise.submit()" class="action">{translate key="search.reviseSearch"}</a>&nbsp;&nbsp;
<a href="#top" onclick="showExportOptions()" class="action" id="showExportOptions">|  &nbsp;{translate key="search.exportSearchResults"}&nbsp;&nbsp;</a>
<a href="#top" onclick="hideExportOptions()" class="action" id="hideExportOptions">|  &nbsp;{translate key="search.hideExportOptions"}</a><br />
<!--
<a href="javascript:document.generate.submit()" class="action">| Export Search Results</a><br />
-->
<form name="generate" action="{url op="generateCustomizedCSV"}" method="post"  id="exportOptions">
	<input type="hidden" name="query" value="{$query|escape}"/>
	<input type="hidden" name="region" value="{$region|escape}"/>
	<input type="hidden" name="statusFilter" value="{$statusFilter|escape}"/>
	<input type="hidden" name="dateFrom" value="{$dateFrom|escape}"/>
	<input type="hidden" name="dateTo" value="{$dateTo|escape}"/>
	
	<table class="data" width="100%">
	<tr><i><br />{translate key="search.exportIntruct"}<br /></i></tr>
	<tr>
	<td colspan="4" class="headseparator"></td>
	</tr>
	<tr>
	<td><br /><strong>{translate key="user.role.authors"}:</strong></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="value">
			<input type="checkbox" name="investigatorName" checked="checked"/>&nbsp;{translate key="common.fullName"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="investigatorAffiliation"/>&nbsp;{translate key="user.affiliation"}
		</td>
	</tr>
	<tr>
	<td colspan="4" class="separator"></td>
	</tr>
	<tr>
	<td><strong>{translate key="article.metadata"}:</strong></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="value">
			<input type="checkbox" name="scientificTitle" checked="checked"/>&nbsp;{translate key="proposal.scientificTitle"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="publicTitle"/>&nbsp;{translate key="proposal.publicTitle"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="researchField" checked="checked"/>&nbsp;{translate key="proposal.researchField"}
		</td>
	</tr>
	<tr valign="top">
		<td width="20%" class="value">
			<input type="checkbox" name="proposalType" checked="checked"/>&nbsp;{translate key="proposal.proposalType"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="duration" checked="checked"/>&nbsp;{translate key="search.researchDates"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="area" checked="checked"/>&nbsp;{translate key='proposal.proposalCountry'}
		</td>
	</tr>
	<tr valign="top">
		<td width="20%" class="value">
			<input type="checkbox" name="primarySponsor" checked="checked"/>&nbsp;{translate key="proposal.primarySponsor"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="dataCollection"/>&nbsp;{translate key="proposal.dataCollection"}
		</td>
		<td width="20%" class="value">
			<input type="checkbox" name="status" checked="checked"/>&nbsp;{translate key="common.status"}
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<input type="checkbox" name="studentResearch" checked="checked"/>&nbsp;{translate key="search.studentExport"}
		</td>
		<td></td>
	</tr>
	<tr>
	<td colspan="4" class="endseparator">&nbsp;</td>
	</tr>
	</table>
	<p><input type="submit" value="{translate key="common.export"}" class="button defaultButton"/>
</form>

<br/>
<h4>{if $statusFilter == 1}Complete Research:<br/>{/if}{if $statusFilter == 2}Ongoing Research:<br/>{/if}Search {if $query}for '{$query}' {/if}{if $formattedDateFrom != ''} from {$formattedDateFrom|date_format:$dateFormatLong}{/if} {if $formattedDateFrom != '' && $formattedDateTo != ''} and {/if}{if $formattedDateTo != ''} until {$formattedDateTo|date_format:$dateFormatLong}{/if}{if $country} in {$country} {/if} returned {$count} result(s). </h4>
<div id="results">
<table width="100%" class="listing">
<tr class="heading" valign="bottom">
		<td>{sort_heading key='article.title' sort="title"}</td>
		<td>{sort_heading key='search.primarySponsor' sort="primarySponsor"}</td>
		<td>{sort_heading key='search.region' sort="region"}</td>
		<td>{sort_heading key='search.researchField' sort="researchField"}</td>
		<td>{sort_heading key='search.researchDates' sort="researchDates"}</td>
		<td>{sort_heading key="common.status" sort="status"}</td>
</tr>
<tr>
	<td colspan="6" class="headseparator">&nbsp;</td>
</tr>
<p></p>
{iterate from=results item=result}
<tr valign="bottom">
	{assign var="abstract" value=$result->getLocalizedAbstract()}
	<td><a href="{url op="viewProposal" path=$result->getId()}" class="action">{$abstract->getScientificTitle()|escape}</a></td>
	<td>
	{if $result->getLocalizedPrimarySponsor() == "Other"}
		{$result->getLocalizedOtherPrimarySponsor()}
	{else}
		{$result->getLocalizedPrimarySponsor()}
	{/if}
	</td>
	<td>
	{if $result->getLocalizedMultiCountryResearch() == "Yes"}
		Multi-country research
	{elseif $result->getLocalizedProposalCountry() == "NW"}
		Nationwide
	{else}
		{$result->getLocalizedProposalCountryText()}
	{/if}
	</td>
	<td>{$result->getLocalizedResearchFieldText()}</td>
	<td>{$result->getLocalizedStartDate()} to {$result->getLocalizedEndDate()}</td>
	<td>{if $result->getStatus() == 11}Complete{else}Ongoing{/if}</td>
</tr>
<tr>
	<td colspan="6" class="{if $results->eof()}end{/if}separator">&nbsp;</td>
</tr>
{/iterate}
{if $results->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="search.noResults"}</td>
	</tr>
	<tr>
		<td colspan="6" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left">{page_info iterator=$results}</td>
		<td align="right" colspan="2">{page_links anchor="results" iterator=$results name="search" query=$query dateFrom=$dateFrom dateTo=$dateTo proposalCountry=$country sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>	

{include file="common/footer.tpl"}

