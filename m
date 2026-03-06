Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E3DF01808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ5f-0008DF-PH; Fri, 06 Mar 2026 02:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ5K-0007n9-OH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:59:02 -0500
Received: from p-west2-cluster1-host5-snip4-10.eps.apple.com ([57.103.68.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ59-0006Ga-Br
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:54 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 1800B1800107; Fri,  6 Mar 2026 07:58:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783920; x=1775375920;
 bh=vM1Wlorf+XqQlJ5f9IMCqYNj/5ImA32mrulRYej01YM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RXLTcFRWuhi7WN8XACHB/3Kthj5bfmbiCGwp1U7bB2DfDyi3ZBNU/aevPFNYBGoLnzUmNL41v9i3UJbM9SR0nYE5tWmD4ly7e06CiWfQbsDPi9PgdtHKZX8d11ih16FHEx6RxH+/3TySKC5m3KNrS4ynvMkAjPlwXUbEvKEPELRTNtzAbSAjCziyMfTOun63dHZ6pg9WPc96WTe8RwrTzaxIkBR8721snZ/V7RDx5REfKlqMEaNkpma6ZqjtO3e0bzAY6MLmrCaQOohLPrLlTVDBL7wybGMQ2WxkGN90WIMiNcNBOCdfoJJ7u+VA38x7Fk32LcN7dZtYhGCCumXHKQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 C785F1800135; Fri,  6 Mar 2026 07:58:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 15/17] hvf: arm: SME2 availability fixes
Date: Fri,  6 Mar 2026 08:57:54 +0100
Message-ID: <20260306075756.88922-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX3/qF0wOTG0pM
 VuTIYXPwqx0UNBYBV5+odsOSUTKdmhyk4FVH5w4hK0HtffpT3ZfA5xpqTdiBYNP6KMvK+cS2uv/
 BVdQ7W3BHbdZm7rvSdtbPUCgHjlXxzd/mf/GdUKpQdwQg6NBi/RyEIpsypt4tW5kOZKFLtmUtMm
 r772d9ka4vB/GuWB0msb605aInFh8JQ07jFMYMCXK9A8QT5N7TgWhg3vbat9zxzQ7jj4hvNENDt
 w4OXntMh3yvv++9cCdo6NgCRl8vnzZxep+S/roazCQIdUygVujzRosa0hrzdW/nQr+xp4eTYsCu
 ajRbbHavRiyf20UVo8R5yzY1FxT/WJCIHuxpX6WdftrYCS989ffCoq/higkS/0=
X-Proofpoint-ORIG-GUID: CvAzs_5vgQ-nAjcshXWO8Pb6hD21kJmH
X-Authority-Info-Out: v=2.4 cv=GaAaXAXL c=1 sm=1 tr=0 ts=69aa8930
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Iy1shTv_HyS0e-kpLPMA:9
X-Proofpoint-GUID: CvAzs_5vgQ-nAjcshXWO8Pb6hD21kJmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=835 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABNvYFdnmbtyXTPkDQ2+FD/r+HZtdplWUi9tsNS/zbIbSybZpxtOOBkGzybOOHlvNgkh9bmCo+FuT0KEYy1y5i37hdNmOmLAn8YLI1Gi2f+nmA9TASpdv2aCtvWmRvjYuZqPCnjsZCjz5vfzuYQb+NkcVZSuPhKwi2DbYPut9dz81qcqtpiGK113UK0E1XVvWziO00UOVK6Oinvtu3lkWIKzq7/Hm0kaM3hq5gAwNNfEicGZcCfYE63ey/xUSawuSdo1oI3p1Nq/8nxwbjO7z/simjDUvJgcLKFBGsMzrhUxGzKUTDJ1bVbSw9ytdBvRBkC3P7mN/tF39usZ8iQsdttbv/0lQJpqSZKXlk8D/oc9qknwpIf9l63ahFY4LlAE0rvtv9Qu30wna1suSc3eSYT/CxvEopgZS0cB1B/RiuF9IP529fZA3AEAzJ59+FkVWz4i/H6eB5snnm1XHrwIt/Mdl1Br4AJTUGVhfiCvVmNIUoqC2iWMLmMaoUo8AFS72hf62u//Ufxcaj8pi9xRGiNImKKXMnn6emGOxsHjIleqsCbKfIm/dKT9EbnaWhFfcj/LOeuY4WItwzEbLlTO+8fmfuSbWNV/RAyUZ9O2+ZdNi1EsopnZ7CZb2LfWjU/Xlk66v9K2qi8VZKSrzft6SsfWvLVilyBRZEyZ+tB/6SHYLRNWJsgsGEBovzrPyVrh8KyImpI9TVPyYrvzSfQcvTGGrtn5JLWsmVd7/BSw==
Received-SPF: pass client-ip=57.103.68.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


