section main {
    message info "This iApp creates an iRule which responds to every HTTP request."
    string irule_name display "xlarge"
    choice status_code default "500" { "200", "400", "500", "501" }
}
text {
    main "Main Configuration"
    main.info "Info:"
    main.irule_name "iRule Name:"
    main.status_code "HTTP response status code to send:"
}