#############################################################
#
# Any custom stuff you feel like doing....
#
#############################################################
CUST_DIR:=package/snakeos_features/source

$(BUILD_DIR)/.snakeos_features:
	rm -f $(BUILD_DIR)/series
	(cd $(CUST_DIR); \
	 /bin/ls -d * > $(BUILD_DIR)/series || \
	 touch $(BUILD_DIR)/series )
	for f in `cat $(BUILD_DIR)/series`; do \
		cp -af $(CUST_DIR)/$$f $(TARGET_DIR); \
	done
	rm -f $(BUILD_DIR)/series
	touch $@

snakeos_features: $(BUILD_DIR)/.snakeos_features

snakeos_features-clean:
	rm -f $(BUILD_DIR)/.snakeos_features

.PHONY: snakeos_features
#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_SNAKEOS_FEATURES),y)
TARGETS+=snakeos_features
endif
