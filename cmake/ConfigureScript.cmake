
function(configure_script infile outfile)
    configure_file(${infile} ${outfile} @ONLY)
    execute_process(COMMAND 
        chmod 755 ${CMAKE_CURRENT_BINARY_DIR}/${script} OUTPUT_QUIET) 
endfunction()
