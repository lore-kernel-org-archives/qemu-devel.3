Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE7FC9EF5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 10:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypEk-0004OW-V1; Sat, 07 Mar 2026 05:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vypEi-0004Nq-6O
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:50:20 -0500
Received: from p-west1-cluster2-host8-snip4-5.eps.apple.com ([57.103.64.206]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vypEf-0007xr-Te
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 05:50:19 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-0 (Postfix) with ESMTPS id
 A7CE8180009C; Sat,  7 Mar 2026 10:50:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772880615; x=1775472615;
 bh=iUCLvVKcpLclH2h93iEy1925cxmqS3nCPQbaRIi7NJo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BdGn3g1kUqIodF7uj9JCGcK70mmChqk8mMkcRzMhUVY9BCy//HMD+Fc+nzcPUVTT/gHrUT5DauhEbRkWYTsmYhtKIM/8pr4h1GJKlm0gDR256C33NkzIO61N11oKAW4j6fj+RSzf3YsrntXox3EEfKgeiwOs/4ihlWJNQZr/1mW8G5acmmPbbDQvGSStt9FopbtJIQDurSGGfMn2aA312w0AlVxEhd7/dgl8RUGtghTPvX225tCWmEYxJ5LRBhvGDi4+kCu777Ib9R1lBX0IaSkKRBWHt47keH/EjVVMVnHa93e9BwLq1aCETc15H6YqL4pOy5GyRsfo0wOrJ0dSOQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-0 (Postfix) with ESMTPSA id
 C5D8918000A1; Sat,  7 Mar 2026 10:50:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] hvf: arm: remove SME2 stub code
Date: Sat,  7 Mar 2026 11:50:09 +0100
Message-ID: <20260307105009.67242-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xf3WlW3tKZ_fxhgoToS74eoR4OHx05kN
X-Proofpoint-ORIG-GUID: xf3WlW3tKZ_fxhgoToS74eoR4OHx05kN
X-Authority-Info-Out: v=2.4 cv=K/gv3iWI c=1 sm=1 tr=0 ts=69ac02e7
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9Dezs168Bnguv2szdR4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDEwMCBTYWx0ZWRfX5E3n5pWZfnmD
 FFeBt7H6hoPqzvZhn48cjgtBco6vrwCubf5zD/qH15vubbcu4+xNDxZ4sax60mxYKNs/+k44WYX
 g8tiiILt5rbKl7C3Wp/hSGj/cNfbzCWuA7s5iijUUc89urfP/rImGTa7c+DBqk0+L0Ti4cr6uqQ
 3E861cf98gUQrSpzmpy7iBzaBE3p+qX2fbgb/pphvQoDrchZj8qtoJzws0tTTZEkQZGLwbrqdXf
 Zsuu81sKQ40xRpM72MrXlDtFjgbx+rfL7GFNAzDdVyR1YyM4IwV9j2B8mbYLgmnfPnvXj1wNJFI
 CuXgZJyBEHFypWzGGwPHwrLAxd5UDAeM1h4wGLt+0Xg/Mqy7tQbMYyfCu44geg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070100
Received-SPF: pass client-ip=57.103.64.206;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Releases n and n-1 of macOS are supported. As such, macOS 15.x and 26.x are currently the baseline.

The QEMU CI still uses a newer SDK, just with an older default target as it's running on a macOS 14 host.

Note that this on its own doesn't prevent running on macOS 14. It just means that you have to use a newer SDK in order to do so.

Why do this? Because the stub code broke the x86 build... and it doesn't make much sense to keep it.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c           |  31 ++++++
 target/arm/hvf/hvf_sme_stubs.h | 172 ---------------------------------
 target/arm/hvf_arm.h           |  45 ---------
 3 files changed, 31 insertions(+), 217 deletions(-)
 delete mode 100644 target/arm/hvf/hvf_sme_stubs.h

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4630d76930..7c68337567 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -41,6 +41,37 @@
 
 #include "gdbstub/enums.h"
 
+static inline bool hvf_arm_sme2_supported(void)
+{
+    if (__builtin_available(macOS 15.2, *)) {
+        size_t svl_bytes;
+        hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+        /* Nested virt not supported together with SME right now. */
+        if (hvf_nested_virt_enabled()) {
+            return false;
+        }
+        if (result == HV_UNSUPPORTED) {
+            return false;
+        }
+        assert_hvf_ok(result);
+        return svl_bytes > 0;
+    } else {
+        return false;
+    }
+}
+
+static inline uint32_t hvf_arm_sme2_get_svl(void)
+{
+    if (__builtin_available(macOS 15.2, *)) {
+        size_t svl_bytes;
+        hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+        assert_hvf_ok(result);
+        return svl_bytes;
+    } else {
+        abort();
+    }
+}
+
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
 
diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stubs.h
deleted file mode 100644
index 43686f7824..0000000000
--- a/target/arm/hvf/hvf_sme_stubs.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-typedef int32_t hv_return_t;
-typedef uint64_t hv_vcpu_t;
-
-static inline bool hvf_arm_sme2_supported(void)
-{
-    return false;
-}
-
-static inline uint32_t hvf_arm_sme2_get_svl(void)
-{
-    g_assert_not_reached();
-}
-
-typedef enum hv_sme_p_reg_t {
-    HV_SME_P_REG_0,
-    HV_SME_P_REG_1,
-    HV_SME_P_REG_2,
-    HV_SME_P_REG_3,
-    HV_SME_P_REG_4,
-    HV_SME_P_REG_5,
-    HV_SME_P_REG_6,
-    HV_SME_P_REG_7,
-    HV_SME_P_REG_8,
-    HV_SME_P_REG_9,
-    HV_SME_P_REG_10,
-    HV_SME_P_REG_11,
-    HV_SME_P_REG_12,
-    HV_SME_P_REG_13,
-    HV_SME_P_REG_14,
-    HV_SME_P_REG_15,
-} hv_sme_p_reg_t;
-
-/*
- * The system version of this type declares it with
- *    __attribute__((ext_vector_type(64)))
- * However, that is clang specific and not supported by GCC.
- * Since these headers are only here for the case where the system
- * headers do not provide these types (including both older macos
- * and non-macos hosts), we don't need to make the type match
- * exactly, so we declare it as a uint8_t array.
- */
-typedef uint8_t hv_sme_zt0_uchar64_t[64];
-
-typedef enum hv_sme_z_reg_t {
-    HV_SME_Z_REG_0,
-    HV_SME_Z_REG_1,
-    HV_SME_Z_REG_2,
-    HV_SME_Z_REG_3,
-    HV_SME_Z_REG_4,
-    HV_SME_Z_REG_5,
-    HV_SME_Z_REG_6,
-    HV_SME_Z_REG_7,
-    HV_SME_Z_REG_8,
-    HV_SME_Z_REG_9,
-    HV_SME_Z_REG_10,
-    HV_SME_Z_REG_11,
-    HV_SME_Z_REG_12,
-    HV_SME_Z_REG_13,
-    HV_SME_Z_REG_14,
-    HV_SME_Z_REG_15,
-    HV_SME_Z_REG_16,
-    HV_SME_Z_REG_17,
-    HV_SME_Z_REG_18,
-    HV_SME_Z_REG_19,
-    HV_SME_Z_REG_20,
-    HV_SME_Z_REG_21,
-    HV_SME_Z_REG_22,
-    HV_SME_Z_REG_23,
-    HV_SME_Z_REG_24,
-    HV_SME_Z_REG_25,
-    HV_SME_Z_REG_26,
-    HV_SME_Z_REG_27,
-    HV_SME_Z_REG_28,
-    HV_SME_Z_REG_29,
-    HV_SME_Z_REG_30,
-    HV_SME_Z_REG_31,
-} hv_sme_z_reg_t;
-
-enum {
-  HV_SYS_REG_SMCR_EL1,
-  HV_SYS_REG_SMPRI_EL1,
-  HV_SYS_REG_TPIDR2_EL0,
-  HV_SYS_REG_ID_AA64ZFR0_EL1,
-  HV_SYS_REG_ID_AA64SMFR0_EL1,
-};
-
-enum {
-  HV_FEATURE_REG_ID_AA64SMFR0_EL1,
-  HV_FEATURE_REG_ID_AA64ZFR0_EL1,
-};
-
-typedef struct {
-    bool streaming_sve_mode_enabled;
-    bool za_storage_enabled;
-} hv_vcpu_sme_state_t;
-
-static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *value)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
-                                                hv_vcpu_sme_state_t *sme_state)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
-                                                const hv_vcpu_sme_state_t *sme_state)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
-                                                hv_sme_z_reg_t reg,
-                                                uint8_t *value,
-                                                size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
-                                                hv_sme_z_reg_t reg,
-                                                const uint8_t *value,
-                                                size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
-                                                hv_sme_p_reg_t reg,
-                                                uint8_t *value,
-                                                size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
-                                                hv_sme_p_reg_t reg,
-                                                const uint8_t *value,
-                                                size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
-                                                 uint8_t *value,
-                                                 size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
-                                                 const uint8_t *value,
-                                                 size_t length)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
-                                                  hv_sme_zt0_uchar64_t *value)
-{
-    g_assert_not_reached();
-}
-
-static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
-                                                  const hv_sme_zt0_uchar64_t *value)
-{
-    g_assert_not_reached();
-}
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 9cb58ad9ab..97b02cb472 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -23,49 +23,4 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
-/*
- * We need access to types from macOS SDK >=15.2, so expose stubs if the
- * headers are not available until we raise our minimum macOS version.
- */
-#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
-  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
-    #include "system/hvf_int.h"
-
-    static inline bool hvf_arm_sme2_supported(void)
-    {
-        if (__builtin_available(macOS 15.2, *)) {
-            size_t svl_bytes;
-            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
-            /* Nested virt not supported together with SME right now. */
-            if (hvf_nested_virt_enabled()) {
-                return false;
-            }
-            if (result == HV_UNSUPPORTED) {
-                return false;
-            }
-            assert_hvf_ok(result);
-            return svl_bytes > 0;
-        } else {
-            return false;
-        }
-    }
-
-    static inline uint32_t hvf_arm_sme2_get_svl(void)
-    {
-        if (__builtin_available(macOS 15.2, *)) {
-            size_t svl_bytes;
-            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
-            assert_hvf_ok(result);
-            return svl_bytes;
-        } else {
-            abort();
-        }
-    }
-  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
-      #include "hvf/hvf_sme_stubs.h"
-  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
-#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
-  #include "hvf/hvf_sme_stubs.h"
-#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
-
 #endif
-- 
2.50.1 (Apple Git-155)


