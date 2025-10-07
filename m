Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F70CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6E96-0004ot-MU; Tue, 07 Oct 2025 16:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E95-0004nn-5Z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:51 -0400
Received: from p-east2-cluster4-host5-snip4-5.eps.apple.com ([57.103.78.196]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E92-0007O5-3j
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 10CCC18016DB; Tue,  7 Oct 2025 20:18:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=vENZitnc2vAvbJskKACnmx35CqKa4UmkCEE6BrJVP9E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VKcY2tMhE2VbVsTMrM2k+2awGJZliWMurg/8DGUJRL7RUf1QCtF5iVQ3z/R+q/aFtAEzZBbQ1U+LFsF3j8pdD9k4NVnGLvx1b2y0MQ215VqhQxMmtHsbj0gzv3VWR++dkXmEeBFyaP7iFYzxwzGEBSHhbQHbFhHlXZIkgJlvvMrMYxjvIbv3syovp6rJ0PuhBZpW6bhR20OLfJjdun2hybq1DGlKN8kqsQMvrRmqFPbvDCDknvG0KAd5L2DYgsIsWLp/CJ+T9M/vNPUlXDMQGQPOyUDTsbecPhIuhZDOq23KOlYvHPTFh4eUs+EuiNhD4c160HtkyRqK5WTW5HfGRg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 872C91800663; Tue,  7 Oct 2025 20:18:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 2/4] hvf: arm64: add workaround for Apple M4 to run older macOS
 versions
Date: Tue,  7 Oct 2025 22:18:35 +0200
Message-ID: <20251007201837.28992-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007201837.28992-1-mohamed@unpredictable.fr>
References: <20251007201837.28992-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ixiariaFywUw4LnKmwM8Sr7Ic9h5EEsj
X-Proofpoint-GUID: ixiariaFywUw4LnKmwM8Sr7Ic9h5EEsj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfXxLrGqsh+3zWz
 pj0xyfxXaqYAfSugFNvglrIPu1nRhrRCOxdEkv9ElyD8ruuo5decxImylGmwknklvuocYHk4YaW
 mvX5+5FksExQl8KG43ZOFj/0z5m41W140V985imwanuaXHoFxfMOp13X4gr48C/da4kZR5Xn001
 xfuyL4vV4JMZSZFdb9bBjkza/2slSTo/iVYlPOBN/jFUrLo7NKgsKIYi517pUOv+uZGWlv7M4zT
 OIxkatt01+bcoOgyXsh1fA0GadiWTD8rTN3wm9n245w6Mu4Ez7Vetb9+fPhDKUfJZZiK4s+Fs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=927 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.78.196;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Apple M4 removes FEAT_SSBS. However, older macOS releases
do misbehave in such a configuration and do not boot.

Use private API to trap SCTLR_EL1 accesses through FGT.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-accel-ops.c |  4 +--
 include/system/hvf_int.h  |  4 +++
 target/arm/hvf/hvf.c      | 71 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8b794c2d41..64d7afc3bf 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -152,8 +152,8 @@ static int hvf_init_vcpu(CPUState *cpu)
     sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
 
 #ifdef __aarch64__
-    r = hv_vcpu_create(&cpu->accel->fd,
-                       (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
+    r = hvf_vcpu_create(&cpu->accel->fd,
+                       (hv_vcpu_exit_t **)&cpu->accel->exit);
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a3b06a3e75..baee11d478 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -111,4 +111,8 @@ void hvf_arch_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+#ifdef __aarch64__
+hv_return_t hvf_vcpu_create(hv_vcpu_t* vcpu_ptr, hv_vcpu_exit_t ** exit);
+#endif
+
 #endif
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d..99daba036b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <sys/sysctl.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -138,11 +139,14 @@ static inline int hvf_arm_num_wrps(hv_vcpu_config_t config)
     return FIELD_EX64(val, ID_AA64DFR0, WRPS) + 1;
 }
 
+void _hv_vcpu_config_set_fgt_enabled(hv_vcpu_config_t cfg, bool enabled);
 void hvf_arm_init_debug(void)
 {
     hv_vcpu_config_t config;
     config = hv_vcpu_config_create();
 
+    _hv_vcpu_config_set_fgt_enabled(config, true);
+
     max_hw_bps = hvf_arm_num_brps(config);
     hw_breakpoints =
         g_array_sized_new(true, true, sizeof(HWBreakpoint), max_hw_bps);
@@ -292,6 +296,8 @@ void hvf_arm_init_debug(void)
 #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
 #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
 
+#define SYSREG_SCTLR_EL1      SYSREG(3, 0, 1, 0, 0)
+
 #define WFX_IS_WFE (1 << 0)
 
 #define TMR_CTL_ENABLE  (1 << 0)
@@ -1320,6 +1326,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_DBGWCR15_EL1:
         *val = env->cp15.dbgwcr[SYSREG_CRM(reg)];
         return 0;
+    case SYSREG_SCTLR_EL1:
+        *val =  env->cp15.sctlr_el[1] | SCTLR_DSSBS_64;
+        return 0;
     default:
         if (is_id_sysreg(reg)) {
             /* ID system registers read as RES0 */
@@ -1643,6 +1652,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_DBGWCR15_EL1:
         env->cp15.dbgwcr[SYSREG_CRM(reg)] = val;
         return 0;
+    case SYSREG_SCTLR_EL1:
+        env->cp15.sctlr_el[1] = val;
+        assert_hvf_ok(hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_SCTLR_EL1, val & ~SCTLR_DSSBS_64));
+        return 0;
     }
 
     cpu_synchronize_state(cpu);
@@ -2244,3 +2257,61 @@ bool hvf_arch_supports_guest_debug(void)
 {
     return true;
 }
+
+/*
+ * Apple M4 removes FEAT_SSBS. However, older macOS releases
+ * do misbehave in such a configuration and do not boot.
+ *
+ * Using private API to trap SCTLR_EL1 accesses through FGT.
+ */
+
+void _hv_vcpu_config_set_fgt_enabled(hv_vcpu_config_t cfg, bool enabled);
+#define HV_CONTROL_FIELD_HFGRTR 0xb
+#define HV_CONTROL_FIELD_HFGWTR 0xc
+hv_return_t _hv_vcpu_get_control_field(hv_vcpu_t vcpu, int field, uint64_t* value);
+hv_return_t _hv_vcpu_set_control_field(hv_vcpu_t vcpu, int field, uint64_t value);
+
+static bool hvf_is_ssbs_implemented(void) {
+    int has_ssbs = -1;
+    size_t has_ssbs_sz = sizeof(has_ssbs);
+    if (sysctlbyname("hw.optional.arm.FEAT_SSBS", &has_ssbs, &has_ssbs_sz, NULL, 0) == -1) {
+        has_ssbs = 0;
+    }
+    return has_ssbs;
+}
+
+hv_return_t hvf_vcpu_create(hv_vcpu_t* vcpu_ptr, hv_vcpu_exit_t ** exit)
+{
+    hv_return_t r;
+    hv_vcpu_t vcpu;
+    uint64_t hfgwtr_el1, hfgrtr_el1;
+
+    hv_vcpu_config_t config;
+    config = hv_vcpu_config_create();
+    if (!hvf_is_ssbs_implemented()) {
+        _hv_vcpu_config_set_fgt_enabled(config, true);
+    }
+
+    r = hv_vcpu_create(&vcpu, (hv_vcpu_exit_t **)exit, config);
+
+    if (hvf_is_ssbs_implemented()) {
+        return r;
+    }
+
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,&hfgwtr_el1));
+    assert_hvf_ok(_hv_vcpu_set_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,
+        hfgwtr_el1 | R_HFGWTR_EL2_SCTLR_EL1_MASK));
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGWTR,
+        &hfgwtr_el1));
+
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        &hfgrtr_el1));
+    assert_hvf_ok(_hv_vcpu_set_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        hfgrtr_el1 | R_HFGRTR_EL2_SCTLR_EL1_MASK));
+    assert_hvf_ok(_hv_vcpu_get_control_field(vcpu, HV_CONTROL_FIELD_HFGRTR,
+        &hfgrtr_el1));
+
+    *vcpu_ptr = vcpu;
+
+    return r;
+}
-- 
2.50.1 (Apple Git-155)


