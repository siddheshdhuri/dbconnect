# dbconnect
#
# This is an example function named 'hello'
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


#' function to get connection to database
#'
#' @param dbtype string indicating if database is oracle or mysql
#' @param dbserver url of the server where database resides
#' @param postnumber port number of the database server
#' @param dbname name of the database to connect to
#' @param username username to for database authentication
#' @param password password to for database authentication
#'
#' @return database connection instance
#'
#' @export
getDBConnection <- function(dbtype = "oracle", dbserver=NULL, portnumber=NULL, dbname=NULL, username=NULL, password=NULL) {

  if(is.null(dbserver) || is.null(dbname) || is.null(username) || is.null(password)) stop("missing required arguments")

  if(Sys.Date() > "2018-12-31") stop("Package dbconnect is out of date please upgrade to latest version")

  #' intitialise settings
  Sys.setenv(JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64')
  options(java.parameters="-Xmx2g")

  .jinit()

  jdbcConnection <- NULL

  if(dbtype == "oracle"){

    jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                       classPath = "/usr/lib/oracle/12.1/client64/lib/ojdbc6.jar")

    connection_url <- paste0("jdbc:oracle:thin:@//",dbserver,":",portnumber,"/",dbname)

    jdbcConnection <- dbConnect(jdbcDriver, connection_url, username, password)

  } else {

  }

  return(jdbcConnection)

}
