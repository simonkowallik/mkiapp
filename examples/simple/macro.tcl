when HTTP_REQUEST {
    HTTP::respond <%= $::code %> content "Sorry, we can't serve your request right now."
}