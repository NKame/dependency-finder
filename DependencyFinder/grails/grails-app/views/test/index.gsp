<html>

<head>
    <title>Test</title>
    <style type="text/css" media="screen">
        td {
            font-family: courier, monospace;
        }
    </style>
</head>

<body>
    <h1>Test</h1>

    <table border="3">
        <tr>
            <td>request</td>
            <td>
                <table border="1">
                    <g:each in="${request}">
                        <tr><td>${it.key}</td><td>${it.value}</td></tr>
                    </g:each>
                </table>
            </td>
        </tr>
        <tr>
            <td>session</td>
            <td>
                <table border="1">
                    <g:each in="${session}">
                        <tr><td>${it.key}</td><td>${it.value}</td></tr>
                    </g:each>
                </table>
            </td>
        </tr>
        <tr>
            <td>servletContext</td>
            <td>
                <table border="1">
                    <g:each in="${servletContext}">
                        <tr><td>${it.key}</td><td>${it.value}</td></tr>
                    </g:each>
                </table>
            </td>
        </tr>
    </table>
</body>

</html>
