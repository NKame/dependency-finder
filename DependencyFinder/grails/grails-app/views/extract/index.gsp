<!--
    Copyright (c) 2001-2009, Jean Tessier
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

        * Redistributions of source code must retain the above copyright
          notice, this list of conditions and the following disclaimer.

        * Redistributions in binary form must reproduce the above copyright
          notice, this list of conditions and the following disclaimer in the
          documentation and/or other materials provided with the distribution.

        * Neither the name of Jean Tessier nor the names of his contributors
          may be used to endorse or promote products derived from this software
          without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

<html>

<head>
<link rel="stylesheet" href="${resource(dir:'css',file:'style.css')}" />
<link rel="shortcut icon" href="images/logoicon.gif" type="image/gif" />
<title>Extract ${name}</title>
</head>

<!-- Reading the parameters and setting up the forms -->

<body>

<table cellpadding="5">
    <tr>
        <td>
            <div class="title">
                <span id="name">${name}</span>
                <g:if test="${label}"><span id="label">${label}</span></g:if>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <table border="0" class="controls" width="100%">
                <tr>
                    <th><fieldset class="navigation"><g:link controller="query">Dependency graph</g:link></fieldset></th>
                    <th><fieldset class="navigation"><g:link controller="closure">Transitive closure</g:link></fieldset></th>
                    <th><fieldset class="navigation"><g:link controller="cycles">Dependency cycles</g:link></fieldset></th>
                    <th><fieldset class="navigation"><g:link controller="metrics">Dependency metrics</g:link></fieldset></th>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <br />
            This operation may take a few minutes, depending on the
            size and complexity of the codebase to analyze.<br />
            If you really want to do this at this time, please click
            on the <i>Launch</i> button.
        </td>
    </tr>
    <tr>
        <td align="center">
            <br />
            <g:form action="extract">
                <input type="submit" name="launch" value="Launch">
                <font size="smaller">optional label:</font> <g:textField name="label" value="${label ?: ''}" />
                <g:if test="${servletContext?.factory}">
                    <br />
                    <label title="Uncheck to discard the current graph and extract a new one from scratch" for="update">
                        <g:checkBox name="update" id="update" checked="true"/>
                        Update the current graph
                    </label>
                </g:if>
            </g:form>
        </td>
    </tr>
    <tr>
        <td>
            <table>

                <g:if test="${servletContext?.factory}">
                    <tr><td valign="top" rowspan="3">The current graph contains:</td><td align="right">${servletContext?.factory?.packages?.size()}</td><td>packages</td></tr>
                    <tr><td align="right">${servletContext?.factory?.classes?.size()}</td><td>classes</td></tr>
                    <tr><td align="right">${servletContext?.factory?.features?.size()}</td><td>features</td></tr>
                    <g:if test="${servletContext?.extractStart}">
                        <tr><td>&nbsp;</td></tr>
                        <tr><td colspan="3">
                            <table>
                                <tr>
                                    <td align="left">Extracting it took</td>
                                    <td align="right">${servletContext?.extractDuration} second(s) on</td>
                                    <td align="right">${servletContext?.extractStart}.</td>
                                </tr>
                                <g:if test="${servletContext?.updateStart}">
                                    <tr>
                                        <td align="left">Last update took</td>
                                        <td align="right">${servletContext?.updateDuration} second(s) on</td>
                                        <td align="rignt">${servletContext?.updateStart}.</td>
                                    </tr>
                                </g:if>
                            </table>
                        </td></tr>
                    </g:if>
                </g:if>
                <g:else>
                    There is no dependency graph at this time.
                </g:else>

            </table>
        </td>
    </tr>
</table>

</body>

</html>
