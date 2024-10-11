## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  # stable version
#  install.packages("gtfsio")
#  
#  # development version
#  remotes::install_github("r-transit/gtfsio")

## ----message = FALSE----------------------------------------------------------
library(gtfsio)

## -----------------------------------------------------------------------------
data_dir <- system.file("extdata", package = "gtfsio")
list.files(data_dir)

## -----------------------------------------------------------------------------
gtfs_path <- file.path(data_dir, "ggl_gtfs.zip")
gtfs_url  <- "https://github.com/r-transit/gtfsio/raw/master/inst/extdata/ggl_gtfs.zip"

gtfs_from_path <- import_gtfs(gtfs_path)
names(gtfs_from_path)

gtfs_from_url <- import_gtfs(gtfs_url)
names(gtfs_from_url)

## -----------------------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path, files = c("shapes", "trips"))

gtfs

## -----------------------------------------------------------------------------
gtfs <- import_gtfs(
  gtfs_path,
  files = c("shapes", "trips"),
  fields = list(trips = c("trip_id", "route_id"))
)

gtfs

## -----------------------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path, files = "levels")

gtfs$levels

class(gtfs$levels$elevation)

gtfs <- import_gtfs(
  gtfs_path, 
  files = "levels", 
  extra_spec = list(levels = c(elevation = "integer"))
)

gtfs$levels

class(gtfs$levels$elevation)

## -----------------------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path)
tmpf <- tempfile(fileext = ".zip")
tmpd <- tempfile()

export_gtfs(gtfs, tmpf)
zip::zip_list(tmpf)$filename

export_gtfs(gtfs, tmpd, as_dir = TRUE)
list.files(tmpd)

## -----------------------------------------------------------------------------
export_gtfs(gtfs, tmpf, files = c("shapes", "trips"))
zip::zip_list(tmpf)$filename

## -----------------------------------------------------------------------------
extra_gtfs <- gtfs
extra_gtfs$extra_file <- data.frame(column = "value")

export_gtfs(extra_gtfs, tmpd, as_dir = TRUE, standard_only = TRUE)

"extra_file" %in% sub(".txt", "", list.files(tmpd))

levels_fields <- readLines(file.path(tmpd, "levels.txt"), n = 1L)
grepl("elevation", levels_fields)

## ----error = TRUE-------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path, files = c("shapes", "trips"))

check_file_exists(gtfs, "shapes")
check_file_exists(gtfs, "stop_times")

assert_file_exists(gtfs, "shapes")
assert_file_exists(gtfs, "stop_times")

## ----error = TRUE-------------------------------------------------------------
gtfs <- import_gtfs(
  gtfs_path,
  files = "trips",
  fields = list(trips = "trip_id")
)

check_field_exists(gtfs, "trips", fields = "trip_id")
check_field_exists(gtfs, "trips", fields = "shape_id")

assert_field_exists(gtfs, "trips", fields = "trip_id")
assert_field_exists(gtfs, "trips", fields = "shape_id")

## ----error = TRUE-------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path, files = "levels")

check_field_class(gtfs, "levels", fields = "elevation", classes = "character")
check_field_class(gtfs, "levels", fields = "elevation", classes = "integer")

assert_field_class(gtfs, "levels", fields = "elevation", classes = "character")
assert_field_class(gtfs, "levels", fields = "elevation", classes = "integer")

## ----error = TRUE-------------------------------------------------------------
gtfs <- import_gtfs(gtfs_path, files = "shapes")

check_field_class(gtfs, "stop_times", fields = "stop_id", classes = "character")

assert_field_class(gtfs, "stop_times", fields = "stop_id", classes = "character")

