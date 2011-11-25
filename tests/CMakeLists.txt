include_directories (
	${CMAKE_SOURCE_DIR}/src
	)

add_custom_target(tests ALL 
	DEPENDS test.bin
	)

add_executable(test.bin test.c)

configure_file(${CMAKE_SOURCE_DIR}/tests/test.sh.in
	${CMAKE_BINARY_DIR}/tests/test.sh @ONLY
	)
execute_process(COMMAND 
	chmod 755 ${CMAKE_BINARY_DIR}/tests/test.sh OUTPUT_QUIET) 

add_test(NAME ExampleTests 
	COMMAND ${CMAKE_BINARY_DIR}/tests/test.sh 
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/tests
	)

