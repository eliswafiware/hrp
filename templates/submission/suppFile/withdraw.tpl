{**
 * withdraw.tpl
 *
 *}
{strip}

{assign var="pageTitle" value="author.submit.addWithdrawReport"}
{assign var="pageCrumbTitle" value="submission.withdrawReports"}

{include file="common/header.tpl"}
{/strip}

{literal}
    <script>
        function showOrHideOtherReasonField(value) {
            if (value == "2") {
                document.getElementById('otherReasonField').style.display = '';
                $('#otherReason').val("");
            } else {
                document.getElementById('otherReasonField').style.display = 'none';
                $('#otherReason').val("NA");
            }
        }
    </script>
{/literal}


<form name="withdrawFile" method="post" action="{url page=$rolePath op="saveWithdrawal"}" enctype="multipart/form-data">
    <input type="hidden" name="articleId" value="{$articleId|escape}" />
    <input type="hidden" name="type" value="{$type|escape}" /> <!-- Added by AIM, June 15 2011 -->
    {include file="common/formErrors.tpl"}

    <div id="supplementaryFileUpload">

        <br />
        <table id="showReviewers" width="70%" class="data">
            <tr valign="top">
                    <td class="label">{translate key="author.submit.uploadWithdrawReport"}</td>
                    <td class="value"><input type="file" name="uploadSuppFile" id="uploadSuppFile" class="uploadField" /></td>
            </tr>
            <tr valign="top">
                <td class="label">{translate key="author.submit.reasonsForWithdrawal"}</td>
                <td class="value">
                    <select name="withdrawReason" id="withdrawReason" class="selectMenu" onchange="showOrHideOtherReasonField(this.value);">
                        <option value="">{translate key="common.chooseOne"}</option>
                        <option value="0">{translate key="submission.withdrawLack"}</option>
                        <option value="1">{translate key="submission.withdrawAdverse"}</option>
                        <option value="2">{translate key="common.other"}</option>
                    </select>
                </td>
            </tr>
            <tr valign="top" id="otherReasonField" style="display: none;">
                <td class="label">&nbsp;</td>
                <td class="value">{translate key="author.submit.otherReasonForWithdrawal"}:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" class="textField" name="otherReason" id="otherReason" value="NA" size="20" maxlength="40" />
                </td>
            </tr>
            <tr valign="top">
                <td class="label">{translate key="common.comments"}</td>
                <td class="value">
                    <textarea name="withdrawComments" id="withdrawComments" class="textArea" rows="5" cols="30"></textarea>
                </td>
            </tr>
        </table>
    </div>

    <div class="separator"></div>


    <p><input type="submit" value="{translate key="common.save"}" class="button defaultButton" /> <input type="button" value="{translate key="common.cancel"}" class="button" onclick="history.go(-1)" /></p>

    <p><span class="formRequired">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

