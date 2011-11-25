#
# Generate the valgrind suppressions file.
#

file(GLOB suppression_files ${CMAKE_SOURCE_DIR}/Dashboard/*-suppressions.txt)

file(REMOVE ${CMAKE_BINARY_DIR}/valgrind-suppressions.txt)

foreach(fname ${suppression_files})
	file(READ ${fname} vgs)
	file(APPEND ${CMAKE_BINARY_DIR}/valgrind-suppressions.txt ${vgs})
endforeach()

