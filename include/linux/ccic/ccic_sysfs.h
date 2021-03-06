/*
 *
 * Copyright (C) 2017-2019 Samsung Electronics
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#ifndef __CCIC_SYSFS__
#define __CCIC_SYSFS__

extern const struct attribute_group ccic_sysfs_group;

enum {
	BUILT_IN = 0,
	UMS = 1,
	SPU = 2,
};

enum ccic_sysfs_property {
	CCIC_SYSFS_PROP_CHIP_NAME = 0,
	CCIC_SYSFS_PROP_CUR_VERSION,
	CCIC_SYSFS_PROP_SRC_VERSION,
	CCIC_SYSFS_PROP_LPM_MODE,
	CCIC_SYSFS_PROP_STATE,
	CCIC_SYSFS_PROP_RID,
	CCIC_SYSFS_PROP_CTRL_OPTION,
	CCIC_SYSFS_PROP_BOOTING_DRY,
	CCIC_SYSFS_PROP_FW_UPDATE,
	CCIC_SYSFS_PROP_FW_UPDATE_STATUS,
	CCIC_SYSFS_PROP_FW_WATER,
	CCIC_SYSFS_PROP_DEX_FAN_UVDM,
	CCIC_SYSFS_PROP_ACC_DEVICE_VERSION,
	CCIC_SYSFS_PROP_DEBUG_OPCODE,
	CCIC_SYSFS_PROP_CONTROL_GPIO,
	CCIC_SYSFS_PROP_USBPD_IDS,
	CCIC_SYSFS_PROP_USBPD_TYPE,	/* for SWITCH_STATE */
	CCIC_SYSFS_PROP_CC_PIN_STATUS,
	CCIC_SYSFS_PROP_RAM_TEST,
	CCIC_SYSFS_PROP_SBU_ADC,
	CCIC_SYSFS_PROP_VSAFE0V_STATUS,
	CCIC_SYSFS_PROP_OVP_IC_SHUTDOWN,
	CCIC_SYSFS_PROP_HMD_POWER,
	CCIC_SYSFS_PROP_MAX_COUNT,
};
struct _ccic_data_t;
typedef struct _ccic_sysfs_property_t {
	enum ccic_sysfs_property *properties;
	size_t num_properties;
	int (*get_property)(struct _ccic_data_t *pccic_data,
			     enum ccic_sysfs_property prop,
			     char *buf);
	ssize_t (*set_property)(struct _ccic_data_t *pccic_data,
			     enum ccic_sysfs_property prop,
			     const char *buf,
				 size_t size);
	/* Decides whether userspace can change a specific property */
	int (*property_is_writeable)(struct _ccic_data_t *pccic_data,
				      enum ccic_sysfs_property prop);
	int (*property_is_writeonly)(struct _ccic_data_t *pccic_data,
				      enum ccic_sysfs_property prop);
} ccic_sysfs_property_t, *pccic_sysfs_property_t;

void ccic_sysfs_init_attrs(void);
#endif

