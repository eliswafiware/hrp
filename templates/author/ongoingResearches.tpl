{**
 * toSubmit.tpl
 *
 * Show the details of proposals to submit.
 *
 * $Id$
 *}

<div id="submissions">
<table class="listing" width="100%">
	<tr class="heading" valign="bottom">
		<td width="10%">{translate key="common.proposalId"}</td>
		<td width="10%"><span class="disabled">{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td width="50%">{sort_heading key="article.title" sort="title"}</td>
		<td width="30%" align="right">{translate key="common.action"}</td>
	</tr>
	<tr><td colspan="4" class="headseparator">&nbsp;</td></tr>

{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getArticleId()}
	{assign var="abstract" value=$submission->getLocalizedAbstract()}
    {assign var="proposalId" value=$submission->getProposalId()}
        <tr valign="top">
            <td>{if $proposalId}{$proposalId|escape}{else}&mdash;{/if}</td>
            <td>{if $submission->getDateSubmitted()}{$submission->getDateSubmitted()|date_format:$dateFormatLong}{else}&mdash;{/if}</td>                
            <td><a href="{url op="submission" path=$articleId}" class="action">{if $abstract}{$abstract->getScientificTitle()|escape}{else}{translate key="common.untitled"}{/if}</a></td>
            <td align="right">
                {if $submission->isSubmissionDue()}
					<a href="{url op="addExtensionRequest" path=$articleId}" title="{translate key="author.submit.submitExtensionRequestInstruct"}" class="action">{translate key="author.submit.submitExtensionRequest.short"} &#8226;</a><br />
                {/if}
                <a href="{url op="addProgressReport" path=$articleId}" class="action")>{translate key="author.submit.submitInterimProgressReport.short"} &#8226;</a><br />
                <a href="{url op="addCompletionReport" path=$articleId}" class="action">{translate key="author.submit.submitFinalReport.short"} &#8226;</a><br />
                {*<a href="{url op="addAdverseEvents" path=$articleId}" class="action">*}Adverse Events &#8226;{*</a>*}<br />
                {*<a href="{url op="addProtocolAmendment" path=$articleId}" class="action">*}Protocol Amendment &#8226;{*</a>*}<br />
                <a href="{url op="withdrawSubmission" path=$articleId}" class="action">{translate key="common.withdraw"} &#8226;</a><br />            
            </td>
        </tr>
        <tr>
        	<td colspan="4" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
        </tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="4" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="4" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="2" align="left">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>
