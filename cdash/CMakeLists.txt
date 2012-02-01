#
# Generate the valgrind suppressions file.
#

file(GLOB suppression_files ${CMAKE_SOURCE_DIR}/cdash/*-suppressions.txt)

file(REMOVE ${CMAKE_BINARY_DIR}/valgrind-suppressions.txt)

foreach(fname ${suppression_files})
    file(READ ${fname} vgs)
    file(APPEND ${CMAKE_BINARY_DIR}/valgrind-suppressions.txt ${vgs})
endforeach()

include(ConfigureScript)
configure_script(cdash.py.in ${CMAKE_CURRENT_SOURCE_DIR}/cdash.py)
configure_script(cdash.run.in ${CMAKE_CURRENT_SOURCE_DIR}/cdash.run)

# vim:et:sw=4:ts=4:
