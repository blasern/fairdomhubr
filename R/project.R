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
  # download data
  json_projects <- jsonlite::fromJSON("https://fairdomhub.org/projects.json")
  # summarize in table
  tibble::tibble(id = json_projects$data$id, 
                 title = json_projects$data$attributes$title, 
                 type = json_projects$data$type, 
                 links = json_projects$data$links$self)
}

#' get_project
#' 
#' get project information of a project specified by id or title
#' 
#' @param id project id 
#' @param title project title
#' @examples 
#' get_project(id = 1)
#' @importFrom jsonlite fromJSON 
#' @importFrom tibble tibble
#' @export
get_project <- function(id = NULL, title = NULL){
  # check input
  stopifnot(!(is.null(title) & is.null(id)))
  if (!is.null(title) & !is.null(id)){
    warning("Specified both title and id. Using id.")
  }
  # find project id
  if (is.null(id)){
    projects <- get_projects()
    id <- projects$id[pmatch(title, projects$title)]
    if (is.na(id)) stop("Project not found.")
  }
  # download data
  json_project <- jsonlite::fromJSON(paste0("https://fairdomhub.org/projects/", id, ".json"))
  # summarize 
  cbind.data.frame(tibble::tibble(title = json_project$data$attributes$title,
                                  description = json_project$data$attributes$description,
                                  created = json_project$data$meta$created,
                                  modified = json_project$data$meta$modified,
                                  web_page = json_project$data$attributes$web_page), 
                   data.frame(lapply(json_project$data$relationships, function(x) nrow(x$data)))
  )
}
