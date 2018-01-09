#' get_projects
#' 
#' get project names and ids
#' 
#' @examples 
#' get_projects()
#' @importFrom jsonlite fromJSON 
#' @importFrom tibble tibble
#' @export
get_projects <- function(){
  json_projects <- jsonlite::fromJSON("https://fairdomhub.org/projects.json")
  tibble::tibble(id = json_projects$data$id, 
                 title = json_projects$data$attributes$title, 
                 type = json_projects$data$type, 
                 links = json_projects$data$links$self)
}
