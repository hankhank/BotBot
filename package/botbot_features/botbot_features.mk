#############################################################
#
# Any custom stuff you feel like doing....
#
#############################################################
BOTBOT_DIR:=package/botbot_features/source

$(BUILD_DIR)/.botbot_features:
	rm -f $(BUILD_DIR)/series
	(cd $(BOTBOT_DIR); \
	 /bin/ls -d * > $(BUILD_DIR)/series || \
	 touch $(BUILD_DIR)/series )
	for f in `cat $(BUILD_DIR)/series`; do \
		cp -af $(BOTBOT_DIR)/$$f $(TARGET_DIR); \
	done
	rm -f $(BUILD_DIR)/series
	touch $@

botbot_features: $(BUILD_DIR)/.botbot_features

botbot_features-clean:
	rm -f $(BUILD_DIR)/.botbot_features

.PHONY: botbot_features
#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(BR2_PACKAGE_BOTBOT_FEATURES),y)
TARGETS+=botbot_features
endif
