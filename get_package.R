get_package <- function(pckg) {
  print(pckg)
  if (!is.element(pckg, installed.packages()[, 1])) {
    print(paste(pckg, "not found in the installed packages"))
    print("Installing now...")
    install.packages(pckg, dependencies = TRUE)
  }
  print(paste("loading", pckg, "into workspace"))
  library(pckg, character.only = TRUE)
}