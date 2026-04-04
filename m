Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BD5E88D7E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 04:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8sUx-0006kb-DV; Sat, 04 Apr 2026 00:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUq-0006gM-Sl
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:33 -0400
Received: from p-east2-cluster5-host8-snip4-2.eps.apple.com ([57.103.79.35]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8sUn-00064m-O0
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 00:20:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 0BAF9180016C; Sat, 04 Apr 2026 04:20:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775276429; x=1777868429;
 bh=GZdCCmgVqW23HX+mjz2AnzpVTE0NCr1pVAykO8WLeqw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JfMqjns9H7kz/zq7rdq5+covg2r/wVt5vqsiszkAIMXPuyx8q+X7CY/bAmu6Dvos0lQu+bESpZViyAsZ0IvEWHkQ2S2x2ODT7aRotzLovxScJ8m3FTWuFQOWFdAkspdP10zJFzYYchjaY1xDdMsm2Ryaw7uc3oE7t7ItY43N++aZFjU+xD7/U6WCLPTRibzfNa0reWrO5lM8YQz5so5mcEZH4bUjo6J+EByNnqkwt4Tq0TLIE7KWMlGUqIS7M3H8bEwV03aggjON/hw7qhv6dAv4O0/S5Bjro4aTJMcy5KS9V+ooBGlXqXwAELfJp2c6e9UWXKh/sogYrhGp1WMLrg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 4D6321800097; Sat, 04 Apr 2026 04:20:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 06/11] whpx: i386: reintroduce enlightenments for Windows 10
Date: Sat,  4 Apr 2026 06:20:10 +0200
Message-ID: <20260404042015.86580-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404042015.86580-1-mohamed@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ifxx8sbsAUgWZK6yYGjgyif3lWMQ9_5b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAzNCBTYWx0ZWRfX1sWYKWcl3gWi
 8aerXlBAv8PQhqtkqKG7vxoyiLUJxWKX8z7+B7N45urIWKMinfKsvEXOq1PoC+vbmsms5iylghu
 iKQqUgb85Yu2kU8Ww9oQjpFfGwdlKzkATufMjm8jh9CrZ9I8WrCfRupvW1fNY9Z+fXpTXSkjQaO
 2wKIwFu4At+A4ML5nRPG1cKDiH0Tiarutj91jSYaoECgT1HDiz+BD2LeebD8a9MWU8fNLekvgzo
 LqOEiOfDLIvj5niAfVoQImxUKUkzo3HVwjit7w/lwwUkEwPCAa8tMTZ06LwvQ7BWfkh957q4ttj
 PibhUUU0hC2qPBw8xq21zCyHRUf5lvnQ7X3OXRXcfU2+sXt24XJcDdsPqv3xCY=
X-Authority-Info-Out: v=2.4 cv=UoNu9uwB c=1 sm=1 tr=0 ts=69d0918c
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1av6p83xj7LwzDHaJJEA:9
X-Proofpoint-GUID: ifxx8sbsAUgWZK6yYGjgyif3lWMQ9_5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604040034
Received-SPF: pass client-ip=57.103.79.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Was removed in 2c08624 but it's still useful for
Windows 10 so reintroduce it there.

And this time, actually make it work by reporting
the hypervisor bit in CPUID.

Also pretend to be KVM, with the only capability
reported being X2APIC support.

Although looks like Linux doesn't use that vmware leaf...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  2 ++
 include/system/whpx-internal.h |  1 +
 target/arm/whpx/whpx-all.c     |  1 +
 target/i386/whpx/whpx-all.c    | 55 ++++++++++++++++++++++++++++------
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b813a5d9d2..59be996aef 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -550,6 +550,8 @@ static void whpx_accel_instance_init(Object *obj)
 
     whpx->hyperv_enlightenments_allowed = true;
     whpx->hyperv_enlightenments_required = false;
+    /* Value determined at whpx_accel_init */
+    whpx->hyperv_enlightenments_enabled = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 5902124b63..cf782cf5f8 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -45,6 +45,7 @@ struct whpx_state {
 
     bool hyperv_enlightenments_allowed;
     bool hyperv_enlightenments_required;
+    bool hyperv_enlightenments_enabled;
 
 };
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be96..4019a513aa 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -968,6 +968,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
      * as they're not needed for performance.
      */
     if (whpx->hyperv_enlightenments_required) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 66f263558f..03233d1b94 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2083,14 +2083,49 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-            reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-            reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-            reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-
-            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
-                if (cpu_has_x2apic_feature(env)) {
-                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+            if (whpx_is_legacy_os()) {
+                reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+            } else {
+                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
+                    vcpu->exit_ctx.CpuidAccess.Rcx,
+                    (UINT32 *)&reg_values[1].Reg32,
+                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                    (UINT32 *)&reg_values[3].Reg32);
+            }
+
+            if (!whpx->hyperv_enlightenments_enabled) {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 1:
+                    if (cpu_has_x2apic_feature(env)) {
+                        reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                    }
+                    reg_values[2].Reg64 |= CPUID_EXT_HYPERVISOR;
+                    break;
+                case 0x40000000:
+                    /* report KVM */
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = 0x40000010;
+                    } else {
+                        reg_values[1].Reg64 = 0x40000001;
+                    }
+                    reg_values[4].Reg64 = 0x4b4d564b;
+                    reg_values[2].Reg64 = 0x564b4d56;
+                    reg_values[3].Reg64 = 0x4d;
+                    break;
+                case 0x40000001:
+                    /* report X2APIC */
+                    reg_values[1].Reg64 = reg_values[4].Reg64 =
+                        reg_values[2].Reg64 = 1 << 15;
+                    break;
+                case 0x40000010:
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = env->tsc_khz;
+                        reg_values[4].Reg64 = env->apic_bus_freq / 1000; /* Hz to KHz */
+                    }
+                    break;
                 }
             }
 
@@ -2311,6 +2346,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2513,6 +2549,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2565,7 +2602,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
+        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.50.1 (Apple Git-155)


