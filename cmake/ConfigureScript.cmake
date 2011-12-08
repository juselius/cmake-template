
function(configure_script script)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${script}.in
        ${CMAKE_CURRENT_BINARY_DIR}/${script} @ONLY
        )
    execute_process(COMMAND 
        chmod 755 ${CMAKE_CURRENT_BINARY_DIR}/${script} OUTPUT_QUIET) 
endfunction()
