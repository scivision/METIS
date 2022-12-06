include(FetchContent)

string(TOLOWER ${PROJECT_NAME}_src name)

if(NOT ${PROJECT_NAME}_UPSTREAM_VERSION)
  message(FATAL_ERROR "please specify ${PROJECT_NAME}_UPSTREAM_VERSION")
endif()


file(READ ${CMAKE_CURRENT_LIST_DIR}/libraries.json json)

string(JSON url GET ${json} ${name} ${${PROJECT_NAME}_UPSTREAM_VERSION} "url")
string(JSON tag GET ${json} ${name} ${${PROJECT_NAME}_UPSTREAM_VERSION} "tag")


message(DEBUG "${PROJECT_NAME} archive source URL: ${url}   tag: ${tag}")

set(FETCHCONTENT_QUIET no)

FetchContent_Declare(${PROJECT_NAME}
GIT_REPOSITORY ${url}
GIT_TAG ${tag}
GIT_SHALLOW true
TLS_VERIFY true
GIT_REMOTE_UPDATE_STRATEGY "CHECKOUT"
INACTIVITY_TIMEOUT 60
)

FetchContent_Populate(${PROJECT_NAME})
