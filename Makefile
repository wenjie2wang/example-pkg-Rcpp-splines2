objects := $(wildcard R/*.R) DESCRIPTION
version := $(shell egrep "^Version" DESCRIPTION | awk '{print $$NF}')
pkg := $(shell egrep "^Package" DESCRIPTION | awk '{print $$NF}')
tar := $(pkg)_$(version).tar.gz
checkLog := $(pkg).Rcheck/00check.log

.PHONY: check
check: $(checkLog)

.PHONY: build
build: $(tar)

$(tar): $(objects)
	@$(RM) -rf src/RcppExports.cpp R/RcppExports.R
	@Rscript -e "library(methods);" \
	-e "Rcpp::compileAttributes()" \
	-e "devtools::document();";
	R CMD build .

$(checkLog): $(tar)
	R CMD check $<

.PHONY: clean
clean:
	@$(RM) -rf *~ */*~ *.Rhistroy *.tar.gz src/*.so src/*.o *.Rcheck/ .\#*
