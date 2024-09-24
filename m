Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FFCCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st54F-0003LN-5D; Tue, 24 Sep 2024 08:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fS-00063B-Lv; Tue, 24 Sep 2024 04:13:06 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fO-0008FX-Cc; Tue, 24 Sep 2024 04:13:06 -0400
Received: from zq-Legion-Y7000.. (unknown [180.111.100.113])
 by APP-03 (Coremail) with SMTP id rQCowAAXHKyHdPJmouCdAA--.520S2;
 Tue, 24 Sep 2024 16:12:56 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, dbarboza@ventanamicro.com, zhouquan@iscas.ac.cn
Subject: [PATCH 1/2] linux-headers: Update to Linux v6.11
Date: Tue, 24 Sep 2024 16:12:55 +0800
Message-ID: <6352b2296d543590c4af91fbd61f5f55eb7dd8e9.1727164986.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727164986.git.zhouquan@iscas.ac.cn>
References: <cover.1727164986.git.zhouquan@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHKyHdPJmouCdAA--.520S2
X-Coremail-Antispam: 1UD129KBjvAXoWfuFyUAr1DKF1DZF1xCw4rZrb_yoW5ur1DCo
 W3trZ3Aws5tw4avF42kwnFyFW8uFyxWFZaqF4aqrs8tws7Ja4DGrW8Ka9FgryxKr15KF1r
 Gr92kr1qyrW3t3Z8n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYJ7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
 JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU55l8UUUUU
X-Originating-IP: [180.111.100.113]
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiCRAKBmbyQhC9vQAAsT
Received-SPF: pass client-ip=159.226.251.81; envelope-from=zhouquan@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Sep 2024 08:54:45 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Message-ID: <20240924081255.7iBSfguYayTi4SD8EFjRKZFJav-WMBrsogtSmk5vebk@z>

From: Quan Zhou <zhouquan@iscas.ac.cn>

Sync Linux 6.11 headers to get the latest RISC-V KVM caps.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 include/standard-headers/drm/drm_fourcc.h     |  18 ++
 include/standard-headers/linux/ethtool.h      | 210 ++++++++++++++++++
 .../linux/input-event-codes.h                 |   2 +
 linux-headers/asm-arm64/unistd.h              |  25 +--
 linux-headers/asm-generic/unistd.h            |   6 +-
 linux-headers/asm-loongarch/kvm.h             |   4 +
 linux-headers/asm-loongarch/unistd.h          |   4 +-
 linux-headers/asm-riscv/kvm.h                 |   7 +
 linux-headers/asm-riscv/unistd.h              |  41 +---
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 | 141 ++++++++++--
 linux-headers/linux/kvm.h                     |  23 +-
 linux-headers/linux/mman.h                    |   1 +
 linux-headers/linux/psp-sev.h                 |  28 +++
 16 files changed, 426 insertions(+), 87 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index b72917073d..16b09f7bea 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -1475,6 +1475,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
 #define AMD_FMT_MOD_TILE_VER_GFX11 4
+#define AMD_FMT_MOD_TILE_VER_GFX12 5
 
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
@@ -1485,6 +1486,8 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 /*
  * 64K_D for non-32 bpp is the same for GFX9/GFX10/GFX10_RBPLUS and hence has
  * GFX9 as canonical version.
+ *
+ * 64K_D_2D on GFX12 is identical to 64K_D on GFX11.
  */
 #define AMD_FMT_MOD_TILE_GFX9_64K_D 10
 #define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
@@ -1492,6 +1495,21 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 #define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
 #define AMD_FMT_MOD_TILE_GFX11_256K_R_X 31
 
+/* Gfx12 swizzle modes:
+ *    0 - LINEAR
+ *    1 - 256B_2D  - 2D block dimensions
+ *    2 - 4KB_2D
+ *    3 - 64KB_2D
+ *    4 - 256KB_2D
+ *    5 - 4KB_3D   - 3D block dimensions
+ *    6 - 64KB_3D
+ *    7 - 256KB_3D
+ */
+#define AMD_FMT_MOD_TILE_GFX12_256B_2D 1
+#define AMD_FMT_MOD_TILE_GFX12_4K_2D 2
+#define AMD_FMT_MOD_TILE_GFX12_64K_2D 3
+#define AMD_FMT_MOD_TILE_GFX12_256K_2D 4
+
 #define AMD_FMT_MOD_DCC_BLOCK_64B 0
 #define AMD_FMT_MOD_DCC_BLOCK_128B 1
 #define AMD_FMT_MOD_DCC_BLOCK_256B 2
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index b0b4b68410..fa11b78476 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -752,6 +752,197 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_c33_pse_ext_state - groups of PSE extended states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION: Group of error_condition states
+ * @ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID: Group of mr_mps_valid states
+ * @ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE: Group of mr_pse_enable states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED: Group of option_detect_ted
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM: Group of option_vport_lim states
+ * @ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED: Group of ovld_detected states
+ * @ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE: Group of pd_dll_power_type
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE: Group of power_not_available
+ *	states
+ * @ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED: Group of short_detected states
+ */
+enum ethtool_c33_pse_ext_state {
+	ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION = 1,
+	ETHTOOL_C33_PSE_EXT_STATE_MR_MPS_VALID,
+	ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE,
+	ETHTOOL_C33_PSE_EXT_STATE_OPTION_DETECT_TED,
+	ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
+	ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED,
+	ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE,
+	ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
+	ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_mr_mps_valid - mr_mps_valid states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD: Underload
+ *	state
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN: Port is not
+ *	connected
+ *
+ * The PSE monitors either the DC or AC Maintain Power Signature
+ * (MPS, see 33.2.9.1). This variable indicates the presence or absence of
+ * a valid MPS.
+ */
+enum ethtool_c33_pse_ext_substate_mr_mps_valid {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_DETECTED_UNDERLOAD = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_MPS_VALID_CONNECTION_OPEN,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_error_condition - error_condition states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT: Non-existing
+ *	port number
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT: Undefined port
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT: Internal
+ *	hardware fault
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON:
+ *	Communication error after force on
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS: Unknown
+ *	port status
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF: Host
+ *	crash turn off
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN:
+ *	Host crash force shutdown
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE: Configuration
+ *	change
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP: Over
+ *	temperature detected
+ *
+ * error_condition is a variable indicating the status of
+ * implementation-specific fault conditions or optionally other system faults
+ * that prevent the PSE from meeting the specifications in Table 33–11 and that
+ * require the PSE not to source power. These error conditions are different
+ * from those monitored by the state diagrams in Figure 33–10.
+ */
+enum ethtool_c33_pse_ext_substate_error_condition {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_mr_pse_enable - mr_pse_enable states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE: Disable
+ *	pin active
+ *
+ * mr_pse_enable is control variable that selects PSE operation and test
+ * functions.
+ */
+enum ethtool_c33_pse_ext_substate_mr_pse_enable {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE = 1,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_option_detect_ted - option_detect_ted
+ *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS: Detection
+ *	in process
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR:
+ *	Connection check error
+ *
+ * option_detect_ted is a variable indicating if detection can be performed
+ * by the PSE during the ted_timer interval.
+ */
+enum ethtool_c33_pse_ext_substate_option_detect_ted {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_option_vport_lim - option_vport_lim states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE: Main supply
+ *	voltage is high
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE: Main supply
+ *	voltage is low
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION: Voltage
+ *	injection into the port
+ *
+ * option_vport_lim is an optional variable indicates if VPSE is out of the
+ * operating range during normal operating state.
+ */
+enum ethtool_c33_pse_ext_substate_option_vport_lim {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE = 1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_ovld_detected - ovld_detected states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD: Overload state
+ *
+ * ovld_detected is a variable indicating if the PSE output current has been
+ * in an overload condition (see 33.2.7.6) for at least TCUT of a one-second
+ * sliding time.
+ */
+enum ethtool_c33_pse_ext_substate_ovld_detected {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD = 1,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_power_not_available - power_not_available
+ *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED: Power
+ *	budget exceeded for the controller
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET:
+ *	Configured port power limit exceeded controller power budget
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT:
+ *	Power request from PD exceeds port limit
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT: Power
+ *	denied due to Hardware power limit
+ *
+ * power_not_available is a variable that is asserted in an
+ * implementation-dependent manner when the PSE is no longer capable of
+ * sourcing sufficient power to support the attached PD. Sufficient power
+ * is defined by classification; see 33.2.6.
+ */
+enum ethtool_c33_pse_ext_substate_power_not_available {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED =  1,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_PW_LIMIT_EXCEEDS_CONTROLLER_BUDGET,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT,
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT,
+};
+
+/**
+ * enum ethtool_c33_pse_ext_substate_short_detected - short_detected states
+ *      functions. IEEE 802.3-2022 33.2.4.4 Variables
+ *
+ * @ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION: Short
+ *	condition was detected
+ *
+ * short_detected is a variable indicating if the PSE output current has been
+ * in a short circuit condition for TLIM within a sliding window (see 33.2.7.7).
+ */
+enum ethtool_c33_pse_ext_substate_short_detected {
+	ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION = 1,
+};
+
 /**
  * enum ethtool_pse_types - Types of PSE controller.
  * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
@@ -877,6 +1068,24 @@ enum ethtool_mm_verify_status {
 	ETHTOOL_MM_VERIFY_STATUS_DISABLED,
 };
 
+/**
+ * enum ethtool_module_fw_flash_status - plug-in module firmware flashing status
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED: The firmware flashing process has
+ *	started.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS: The firmware flashing process
+ *	is in progress.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED: The firmware flashing process was
+ *	completed successfully.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR: The firmware flashing process was
+ *	stopped due to an error.
+ */
+enum ethtool_module_fw_flash_status {
+	ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED = 1,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+};
+
 /**
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
@@ -1845,6 +2054,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 2221b0c383..50b2b7497e 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -618,6 +618,8 @@
 #define KEY_CAMERA_ACCESS_ENABLE	0x24b	/* Enables programmatic access to camera devices. (HUTRR72) */
 #define KEY_CAMERA_ACCESS_DISABLE	0x24c	/* Disables programmatic access to camera devices. (HUTRR72) */
 #define KEY_CAMERA_ACCESS_TOGGLE	0x24d	/* Toggles the current state of the camera access control. (HUTRR72) */
+#define KEY_ACCESSIBILITY		0x24e	/* Toggles the system bound accessibility UI/command (HUTRR116) */
+#define KEY_DO_NOT_DISTURB		0x24f	/* Toggles the system-wide "Do Not Disturb" control (HUTRR94)*/
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index ce2ee8f1e3..df36f23876 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -1,25 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#define __ARCH_WANT_RENAMEAT
-#define __ARCH_WANT_NEW_STAT
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
-#define __ARCH_WANT_SYS_CLONE3
-#define __ARCH_WANT_MEMFD_SECRET
-
-#include <asm-generic/unistd.h>
+#include <asm/unistd_64.h>
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index d983c48a3b..5bf6148cac 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -737,7 +737,7 @@ __SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SC_COMP(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
@@ -776,12 +776,8 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
-
-#ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
-#endif
-
 #define __NR_close_range 436
 __SYSCALL(__NR_close_range, sys_close_range)
 #define __NR_openat2 437
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index f9abef3823..ddc5cab0ff 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -81,7 +81,11 @@ struct kvm_fpu {
 #define LOONGARCH_REG_64(TYPE, REG)	(TYPE | KVM_REG_SIZE_U64 | (REG << LOONGARCH_REG_SHIFT))
 #define KVM_IOC_CSRID(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CSR, REG)
 #define KVM_IOC_CPUCFG(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
+
+/* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
+#define KVM_LOONGARCH_VCPU_PVTIME_CTRL	1
+#define  KVM_LOONGARCH_VCPU_PVTIME_GPA	0
 
 struct kvm_debug_exit_arch {
 };
diff --git a/linux-headers/asm-loongarch/unistd.h b/linux-headers/asm-loongarch/unistd.h
index fcb668984f..1f01980f9c 100644
--- a/linux-headers/asm-loongarch/unistd.h
+++ b/linux-headers/asm-loongarch/unistd.h
@@ -1,5 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
-#include <asm-generic/unistd.h>
+#include <asm/unistd_64.h>
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index e878e7cc39..e97db32964 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -168,6 +168,13 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
+	KVM_RISCV_ISA_EXT_ZIMOP,
+	KVM_RISCV_ISA_EXT_ZCA,
+	KVM_RISCV_ISA_EXT_ZCB,
+	KVM_RISCV_ISA_EXT_ZCD,
+	KVM_RISCV_ISA_EXT_ZCF,
+	KVM_RISCV_ISA_EXT_ZCMOP,
+	KVM_RISCV_ISA_EXT_ZAWRS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/linux-headers/asm-riscv/unistd.h b/linux-headers/asm-riscv/unistd.h
index 950ab3fd44..81896bbbf7 100644
--- a/linux-headers/asm-riscv/unistd.h
+++ b/linux-headers/asm-riscv/unistd.h
@@ -14,41 +14,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
+#include <asm/bitsperlong.h>
 
-#if defined(__LP64__) && !defined(__SYSCALL_COMPAT)
-#define __ARCH_WANT_NEW_STAT
-#define __ARCH_WANT_SET_GET_RLIMIT
-#endif /* __LP64__ */
-
-#define __ARCH_WANT_SYS_CLONE3
-#define __ARCH_WANT_MEMFD_SECRET
-
-#include <asm-generic/unistd.h>
-
-/*
- * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
- * having a direct 'fence.i' instruction available to userspace (which we
- * can't trap!), that's not actually viable when running on Linux because the
- * kernel might schedule a process on another hart.  There is no way for
- * userspace to handle this without invoking the kernel (as it doesn't know the
- * thread->hart mappings), so we've defined a RISC-V specific system call to
- * flush the instruction cache.
- *
- * __NR_riscv_flush_icache is defined to flush the instruction cache over an
- * address range, with the flush applying to either all threads or just the
- * caller.  We don't currently do anything with the address range, that's just
- * in there for forwards compatibility.
- */
-#ifndef __NR_riscv_flush_icache
-#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
-#endif
-__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-
-/*
- * Allows userspace to query the kernel for CPU architecture and
- * microarchitecture details across a given set of CPUs.
- */
-#ifndef __NR_riscv_hwprobe
-#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
+#if __BITS_PER_LONG == 64
+#include <asm/unistd_64.h>
+#else
+#include <asm/unistd_32.h>
 #endif
-__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 1c8f918234..59083fc739 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -106,6 +106,7 @@ struct kvm_ioapic_state {
 
 #define KVM_RUN_X86_SMM		 (1 << 0)
 #define KVM_RUN_X86_BUS_LOCK     (1 << 1)
+#define KVM_RUN_X86_GUEST_MODE   (1 << 2)
 
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index da439afee1..24c979be54 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -336,6 +336,7 @@
 #define __NR_statx 332
 #define __NR_io_pgetevents 333
 #define __NR_rseq 334
+#define __NR_uretprobe 335
 #define __NR_pidfd_send_signal 424
 #define __NR_io_uring_setup 425
 #define __NR_io_uring_enter 426
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 4fcb607c72..c23dd21a2d 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -289,6 +289,7 @@
 #define __NR_statx (__X32_SYSCALL_BIT + 332)
 #define __NR_io_pgetevents (__X32_SYSCALL_BIT + 333)
 #define __NR_rseq (__X32_SYSCALL_BIT + 334)
+#define __NR_uretprobe (__X32_SYSCALL_BIT + 335)
 #define __NR_pidfd_send_signal (__X32_SYSCALL_BIT + 424)
 #define __NR_io_uring_setup (__X32_SYSCALL_BIT + 425)
 #define __NR_io_uring_enter (__X32_SYSCALL_BIT + 426)
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 72e8f4b9dd..46636b3ef3 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -37,19 +37,20 @@
 enum {
 	IOMMUFD_CMD_BASE = 0x80,
 	IOMMUFD_CMD_DESTROY = IOMMUFD_CMD_BASE,
-	IOMMUFD_CMD_IOAS_ALLOC,
-	IOMMUFD_CMD_IOAS_ALLOW_IOVAS,
-	IOMMUFD_CMD_IOAS_COPY,
-	IOMMUFD_CMD_IOAS_IOVA_RANGES,
-	IOMMUFD_CMD_IOAS_MAP,
-	IOMMUFD_CMD_IOAS_UNMAP,
-	IOMMUFD_CMD_OPTION,
-	IOMMUFD_CMD_VFIO_IOAS,
-	IOMMUFD_CMD_HWPT_ALLOC,
-	IOMMUFD_CMD_GET_HW_INFO,
-	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
-	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
-	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_IOAS_ALLOC = 0x81,
+	IOMMUFD_CMD_IOAS_ALLOW_IOVAS = 0x82,
+	IOMMUFD_CMD_IOAS_COPY = 0x83,
+	IOMMUFD_CMD_IOAS_IOVA_RANGES = 0x84,
+	IOMMUFD_CMD_IOAS_MAP = 0x85,
+	IOMMUFD_CMD_IOAS_UNMAP = 0x86,
+	IOMMUFD_CMD_OPTION = 0x87,
+	IOMMUFD_CMD_VFIO_IOAS = 0x88,
+	IOMMUFD_CMD_HWPT_ALLOC = 0x89,
+	IOMMUFD_CMD_GET_HW_INFO = 0x8a,
+	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING = 0x8b,
+	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
+	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
+	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 };
 
 /**
@@ -356,10 +357,13 @@ struct iommu_vfio_ioas {
  *                                the parent HWPT in a nesting configuration.
  * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
  *                                   enforced on device attachment
+ * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
+ *                             valid.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
 };
 
 /**
@@ -396,8 +400,8 @@ struct iommu_hwpt_vtd_s1 {
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  */
 enum iommu_hwpt_data_type {
-	IOMMU_HWPT_DATA_NONE,
-	IOMMU_HWPT_DATA_VTD_S1,
+	IOMMU_HWPT_DATA_NONE = 0,
+	IOMMU_HWPT_DATA_VTD_S1 = 1,
 };
 
 /**
@@ -411,6 +415,9 @@ enum iommu_hwpt_data_type {
  * @data_type: One of enum iommu_hwpt_data_type
  * @data_len: Length of the type specific data
  * @data_uptr: User pointer to the type specific data
+ * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
+ *            IOMMU_HWPT_FAULT_ID_VALID is set.
+ * @__reserved2: Padding to 64-bit alignment. Must be 0.
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
@@ -441,6 +448,8 @@ struct iommu_hwpt_alloc {
 	__u32 data_type;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
+	__u32 fault_id;
+	__u32 __reserved2;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
@@ -482,8 +491,8 @@ struct iommu_hw_info_vtd {
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  */
 enum iommu_hw_info_type {
-	IOMMU_HW_INFO_TYPE_NONE,
-	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+	IOMMU_HW_INFO_TYPE_NONE = 0,
+	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 };
 
 /**
@@ -620,7 +629,7 @@ struct iommu_hwpt_get_dirty_bitmap {
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
  */
 enum iommu_hwpt_invalidate_data_type {
-	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
+	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
 };
 
 /**
@@ -692,4 +701,100 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
+ *                                   valid.
+ * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
+ */
+enum iommu_hwpt_pgfault_flags {
+	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
+	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
+};
+
+/**
+ * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
+ * @IOMMU_PGFAULT_PERM_READ: request for read permission
+ * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
+ * @IOMMU_PGFAULT_PERM_EXEC: (PCIE 10.4.1) request with a PASID that has the
+ *                           Execute Requested bit set in PASID TLP Prefix.
+ * @IOMMU_PGFAULT_PERM_PRIV: (PCIE 10.4.1) request with a PASID that has the
+ *                           Privileged Mode Requested bit set in PASID TLP
+ *                           Prefix.
+ */
+enum iommu_hwpt_pgfault_perm {
+	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
+	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
+	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
+	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
+};
+
+/**
+ * struct iommu_hwpt_pgfault - iommu page fault data
+ * @flags: Combination of enum iommu_hwpt_pgfault_flags
+ * @dev_id: id of the originated device
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: Combination of enum iommu_hwpt_pgfault_perm
+ * @addr: Fault address
+ * @length: a hint of how much data the requestor is expecting to fetch. For
+ *          example, if the PRI initiator knows it is going to do a 10MB
+ *          transfer, it could fill in 10MB and the OS could pre-fault in
+ *          10MB of IOVA. It's default to 0 if there's no such hint.
+ * @cookie: kernel-managed cookie identifying a group of fault messages. The
+ *          cookie number encoded in the last page fault of the group should
+ *          be echoed back in the response message.
+ */
+struct iommu_hwpt_pgfault {
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 perm;
+	__u64 addr;
+	__u32 length;
+	__u32 cookie;
+};
+
+/**
+ * enum iommufd_page_response_code - Return status of fault handlers
+ * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *                             populated, retry the access. This is the
+ *                             "Success" defined in PCI 10.4.2.1.
+ * @IOMMUFD_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *                             access. This is the "Invalid Request" in PCI
+ *                             10.4.2.1.
+ */
+enum iommufd_page_response_code {
+	IOMMUFD_PAGE_RESP_SUCCESS = 0,
+	IOMMUFD_PAGE_RESP_INVALID = 1,
+};
+
+/**
+ * struct iommu_hwpt_page_response - IOMMU page fault response
+ * @cookie: The kernel-managed cookie reported in the fault message.
+ * @code: One of response code in enum iommufd_page_response_code.
+ */
+struct iommu_hwpt_page_response {
+	__u32 cookie;
+	__u32 code;
+};
+
+/**
+ * struct iommu_fault_alloc - ioctl(IOMMU_FAULT_QUEUE_ALLOC)
+ * @size: sizeof(struct iommu_fault_alloc)
+ * @flags: Must be 0
+ * @out_fault_id: The ID of the new FAULT
+ * @out_fault_fd: The fd of the new FAULT
+ *
+ * Explicitly allocate a fault handling object.
+ */
+struct iommu_fault_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 out_fault_id;
+	__u32 out_fault_fd;
+};
+#define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
 #endif
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c93876ca0b..49dd1b30ce 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -192,11 +192,20 @@ struct kvm_xen_exit {
 /* Flags that describe what fields in emulation_failure hold valid data. */
 #define KVM_INTERNAL_ERROR_EMULATION_FLAG_INSTRUCTION_BYTES (1ULL << 0)
 
+/*
+ * struct kvm_run can be modified by userspace at any time, so KVM must be
+ * careful to avoid TOCTOU bugs. In order to protect KVM, HINT_UNSAFE_IN_KVM()
+ * renames fields in struct kvm_run from <symbol> to <symbol>__unsafe when
+ * compiled into the kernel, ensuring that any use within KVM is obvious and
+ * gets extra scrutiny.
+ */
+#define HINT_UNSAFE_IN_KVM(_symbol) _symbol
+
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
 	/* in */
 	__u8 request_interrupt_window;
-	__u8 immediate_exit;
+	__u8 HINT_UNSAFE_IN_KVM(immediate_exit);
 	__u8 padding1[6];
 
 	/* out */
@@ -913,6 +922,9 @@ struct kvm_enable_cap {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_PRE_FAULT_MEMORY 236
+#define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
+#define KVM_CAP_X86_GUEST_MODE 238
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1544,4 +1556,13 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_PRE_FAULT_MEMORY	_IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)
+
+struct kvm_pre_fault_memory {
+	__u64 gpa;
+	__u64 size;
+	__u64 flags;
+	__u64 padding[5];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 4e8cb60780..2b83059586 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -17,6 +17,7 @@
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
 #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
 
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index c3046c6bff..17bf191573 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -31,6 +31,7 @@ enum {
 	SNP_PLATFORM_STATUS,
 	SNP_COMMIT,
 	SNP_SET_CONFIG,
+	SNP_VLEK_LOAD,
 
 	SEV_MAX,
 };
@@ -50,6 +51,7 @@ typedef enum {
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
 	SEV_RET_INAVLID_CONFIG,
+	SEV_RET_INVALID_CONFIG = SEV_RET_INAVLID_CONFIG,
 	SEV_RET_INVALID_LEN,
 	SEV_RET_ALREADY_OWNED,
 	SEV_RET_INVALID_CERTIFICATE,
@@ -214,6 +216,32 @@ struct sev_user_data_snp_config {
 	__u8 rsvd1[52];
 } __attribute__((packed));
 
+/**
+ * struct sev_data_snp_vlek_load - SNP_VLEK_LOAD structure
+ *
+ * @len: length of the command buffer read by the PSP
+ * @vlek_wrapped_version: version of wrapped VLEK hashstick (Must be 0h)
+ * @rsvd: reserved
+ * @vlek_wrapped_address: address of a wrapped VLEK hashstick
+ *                        (struct sev_user_data_snp_wrapped_vlek_hashstick)
+ */
+struct sev_user_data_snp_vlek_load {
+	__u32 len;				/* In */
+	__u8 vlek_wrapped_version;		/* In */
+	__u8 rsvd[3];				/* In */
+	__u64 vlek_wrapped_address;		/* In */
+} __attribute__((packed));
+
+/**
+ * struct sev_user_data_snp_vlek_wrapped_vlek_hashstick - Wrapped VLEK data
+ *
+ * @data: Opaque data provided by AMD KDS (as described in SEV-SNP Firmware ABI
+ *        1.54, SNP_VLEK_LOAD)
+ */
+struct sev_user_data_snp_wrapped_vlek_hashstick {
+	__u8 data[432];				/* In */
+} __attribute__((packed));
+
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
-- 
2.34.1


