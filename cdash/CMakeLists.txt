#
# Generate the valgrind suppressions file.
#

file(GLOB suppression_files ${CMAKE_CURRENT_SOURCE_DIR}/*-suppressions.txt)

file(REMOVE ${CMAKE_CURRENT_BINARY_DIR}/valgrind-suppressions.txt)

foreach(fname ${suppression_files})
	file(READ ${fname} vgs)
	file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/valgrind-suppressions.txt ${vgs})
endforeach()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdash.py.in
	${CMAKE_CURRENT_SOURCE_DIR}/cdash.py @ONLY
	)
execute_process(COMMAND 
	chmod 755 ${CMAKE_CURRENT_SOURCE_DIR}/cdash.py OUTPUT_QUIET) 

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdash.run.in
	${CMAKE_CURRENT_SOURCE_DIR}/cdash.run @ONLY
	)
execute_process(COMMAND 
	chmod 755 ${CMAKE_CURRENT_SOURCE_DIR}/cdash.run OUTPUT_QUIET) 

