when HTTP_REQUEST {
    HTTP::respond <%= $::code %> content {
<MKIAPP_FILE_HTMLRESPONSE>
    } "Content-Type" "text/html"
}