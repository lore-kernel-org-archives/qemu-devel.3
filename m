Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2158CF513F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMe2-00063g-Ln; Thu, 05 Mar 2026 23:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMe0-00061q-An
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:32 -0500
Received: from p-west2-cluster5-host3-snip4-4.eps.apple.com ([57.103.71.87]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdx-0002Ww-QP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:32 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 EA5891800140; Fri,  6 Mar 2026 04:18:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770708; x=1775362708;
 bh=vM1Wlorf+XqQlJ5f9IMCqYNj/5ImA32mrulRYej01YM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MyqY6GPhdZ7dMy/KaHBuIC/G5dPq00RrNDTdo/u9ggzpMISi2N54DlzKbVxP7rcbYReJiTBuddrlWzJ1koD28BNgjXiU4wbiUan2Q+hLqhPLGzRY9QFgkDB0rkrKG1INZKeUfsD6WBNCNERGASv93CI/X86jewv8zBNDNu+NCS7SFRgvLUSI3B6lUTEBFsfQgQRNn3veijpeBfTQmfvb+4Q6WQKvyJGssFQR8YNR+CcT49i/DEGARLy72Mglk9/IrNSWkZ5I7xWspk3IIQi+4I53MkVJ73TvcOmVLQwh1VRBjPoA5aclDDts7MnvAhcS88R4gypLL/f4hBxVIkJTOQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 A3F07180011A; Fri,  6 Mar 2026 04:18:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 14/15] hvf: arm: SME2 availability fixes
Date: Fri,  6 Mar 2026 05:17:45 +0100
Message-ID: <20260306041747.54554-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOSBTYWx0ZWRfX2pbgJmd8GjKb
 KFsLlrkq69SslkHPEvkKmo0t8Ji8M+nyB4Ji2U5Og2UlWbclDCBDEuUXNixb/zbBPz+asx5xsyy
 ADuE4BkWF3tegbA7yg0mV8T4r2eNLXvyRNSaNhmco3FCpgXnxNM3fBEDdlapiYbK/MfQXo199Nj
 k+K/oOWgk0fR+TqdSqMGAr0YFE/T055zjmSqXqfZAcmS6Fw0rU4jTa73fXHi8UE3cC1077NEQYh
 p38Ji9ce9/qK43mG5ts8e8R2dp20xAV8iyHLiJTQiGTW1gxHkcmEqB448f70xhN5dsmnTo66Aw8
 nKc8sNal+F7h8T9Gwm8brK/O/y/a2tIdlD169HrqCTASCPI4VhSje6VUCrp6Rg=
X-Proofpoint-GUID: y7HDlLiJ_0qLda-WknWo-QBXSI_q2D4o
X-Authority-Info-Out: v=2.4 cv=bbxmkePB c=1 sm=1 tr=0 ts=69aa5593
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Iy1shTv_HyS0e-kpLPMA:9
X-Proofpoint-ORIG-GUID: y7HDlLiJ_0qLda-WknWo-QBXSI_q2D4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=835
 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060039
X-JNJ: AAAAAAAByHI0w0q6NwzPX4LGsXsclem1Dj6/Q36Sm/PzpCOCoIGlAQf8ewJd107efeOEqb5USNmmFXSUlh6ZGocp9tA9wATQQqsec9zVZgsL4qEzHvHi2yMjaDiMkFF7sgFxnoEnOVUJdW6jggg64KRIP3yoqVVAuEC0SIl/rfIZ5ylqLJzqds2XLoRVmLiuxjiCPXg8kFIdEuQT9afV82o7z948SaiusWTri1pL5Oe5uadNafhwyHYyGd50wxQsEgtZLmJ50woHeIgC/Uo/LzTD+7xiVwji2aeJCfTOmrEBMcyKqddubLz5C+WDlPzzfXaBNYUwsLooZ+ZmH7gLxnfTqulVxrObfHLwATc75sk3cyae3oFlaCiew7oRqOUqY6MBObKD2JEgOs+jTSrJi7I9xgzp0ZkCoDcFYPvOlmX49AhKyCRLk1x4D+5PGusVEcHPps2t6UwXePfmEeTq2DIwhDV/q+S+p8ASEtCfhURctC7xJ3pkjC3t+s3OruW7L3D+QM+vO1zvLQDgwsBW6A8pXx3f3dg7MVR7adGPAQ/0GsgCPP87Wpuea/VxRhh6P0YVYU5jBRTmw5Fgwlv/djOAOLuLmMhbEeLdJ+D4sVjjVgusHh67CYSAFpfbnP+0Ot7QEbPwbcUhhijKE/OW8Xi6yto5Cf2J4mBLxSwpQpoW6QXpTnGKrZVgIVOT+03VutkAX4wH7sVUEQVElbTyoQ971KPQ7Bp4nnvAlcDEC7CR
Received-SPF: pass client-ip=57.103.71.87;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Not sync the SME sysregs if SME2 is not available.
Disable SME when nested virt is on.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 29 +++++++++++++++++++----------
 target/arm/hvf_arm.h |  5 +++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8d1333cbb4..cb05db2358 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1163,6 +1163,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     if (hvf_nested_virt_enabled()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+        /* SME is not implemented with nested virt on the Apple side */
+        SET_IDREG(&host_isar, ID_AA64PFR1,
+              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
     }
 
     ahcf->isar = host_isar;
@@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
-    if (__builtin_available(macOS 15.2, *)) {
-        for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
-            uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-            uint32_t key = kvm_to_cpreg_id(kvm_id);
-            const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
-
-            if (ri) {
-                assert(!(ri->type & ARM_CP_NO_RAW));
-                arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+    if (hvf_arm_sme2_supported()) {
+        /*
+         * Clang doesn't allow us to combine the two checks together.
+         * -Wunsupported-availability-guard
+         */
+        if (__builtin_available(macOS 15.2, *)) {
+            for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
+                uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+                uint32_t key = kvm_to_cpreg_id(kvm_id);
+                const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+                if (ri) {
+                    assert(!(ri->type & ARM_CP_NO_RAW));
+                    arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+                }
             }
         }
         /*
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 6b1c3b9792..9cb58ad9ab 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.50.1 (Apple Git-155)


