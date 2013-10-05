if ENS_ENABLE_COVERAGE
gcov:
	@find . -name "*.gcda" | xargs -r gcov

gcov-reset:
	@find . -name "*.gcov" | xargs rm -f {} \;
	@find . -name "*.gcda" | xargs rm -f {} \;
if ENS_HAVE_LCOV
lcov-clean:
	@rm -rf coverage

lcov-reset: lcov-clean
	@find . -name "*.gcov" | xargs rm -f {} \;
	@find . -name "*.gcda" | xargs rm -f {} \;
	@lcov --directory . --zerocounters

lcov-report:
	@mkdir coverage
	@lcov --compat-libtool --directory . --capture --output-file coverage/coverage.info
	@lcov -l coverage/coverage.info | grep -v "`cd $(top_srcdir) && pwd`" | cut -d: -f1 > coverage/remove
	@lcov -r coverage/coverage.info `cat coverage/remove` > coverage/coverage.cleaned.info
	@rm coverage/remove
	@mv coverage/coverage.cleaned.info coverage/coverage.info
	@genhtml -t "$(PACKAGE_STRING)" -o coverage coverage/coverage.info

else
lcov-clean:
	@echo "Install lcov and reconfigure"

lcov-reset:
	@echo "Install lcov and reconfigure"

lcov-report:
	@echo "Install lcov and reconfigure"

endif

else
gcov:
	@echo "reconfigure with --enable-coverage"

gcov-reset:
	@echo "reconfigure with --enable-coverage"

lcov-clean:
	@echo "reconfigure with --enable-coverage"

lcov-reset:
	@echo "reconfigure with --enable-coverage"

lcov-report:
	@echo "reconfigure with --enable-coverage"

endif
