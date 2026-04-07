Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BCEFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTs-000536-51; Tue, 07 Apr 2026 14:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wABSa-0002LR-8S
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:36 -0400
Received: from p-east2-cluster2-host7-snip4-5.eps.apple.com ([57.103.78.48]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wA8Bc-0002DR-J4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:17:54 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 0E4B618045FE; Tue, 07 Apr 2026 15:17:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775575071; x=1778167071;
 bh=oQob0705w1vpsKwSbilmxpp8KQiyruObQqebQ5RZ0Dc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FOkKdy0czXVmnVPyRZ+nUx+Fsva1xj+NB3BwCoV4V2TAu34CxpgJrni3No4TkcjtjGAiuui3g6rHJJSWNxB7sbCAEjqkGonj94gpD4V8UoaXa++gGHD0oBpj4b5Nu1Dj/Xl/hV5lCgbDV6p4yd1GevAAAhkh0dy4ENpp7Mj1qWybNbJ0DmX50fgm/NQMmcSFaH/5KC2JAHpSBZloki7lDnCXRFJk/90Ka9Y8MGjWKuasxHrwVm7CJ9ti+sXPr9DcIQMLeJQtHKU7niW4bZzsTeK9y3yol/MJtNxSJVrek5UvQWxjjGlMYbHd2o7N3ssoccmsj74oUjxXDBPrT9XYXw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 52AEA1803F2A; Tue, 07 Apr 2026 15:17:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v9 06/13] whpx: i386: reintroduce enlightenments for Windows 10
Date: Tue,  7 Apr 2026 17:17:00 +0200
Message-ID: <20260407151707.46536-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407151707.46536-1-mohamed@unpredictable.fr>
References: <20260407151707.46536-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qAkec1J7ssvgdAH1PV6cM4HoH4ydKIKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX/mVBUF5A+TI8
 0zL8AewnT2YhnlC9eo2Sl1yryuYU1/7EmyU2Bu4yL1327LAcIAXXer+hxIXxfUertF3y7UgO5W5
 nkk8JW3LlyrA+Y7IvGmbby2TMZMK8eQ23NwyPCMKe31N7UntEULE97yqx0ZBQ3wd0rBonEB7oDr
 2e8fS0P5VPLsDqE25Hxd7kCUzjzgaGdp/NAXPTDizJIm2pbXaGEDlc2vIkgtBhDu/4DORYZl051
 aPuWW+0owlwGDLR6LYkLrVIV6cVib/rXxAOydA/68XAhIsxP6AH76+cJJ5Qp9Y9DNkSl+4+RYb2
 W1M6CmsqS8l/wBHIGOkFlpxLED244iQT5L10BSk/jr0MGoR1y9BrtxbW3pwoY4=
X-Authority-Info-Out: v=2.4 cv=ArnjHe9P c=1 sm=1 tr=0 ts=69d5201d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hfWBbujXMTx1PmRkPVYA:9
X-Proofpoint-GUID: qAkec1J7ssvgdAH1PV6cM4HoH4ydKIKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 clxscore=1030 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604070140
Received-SPF: pass client-ip=57.103.78.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Pretend to be vmware to be able to use vmport's functionality.

If the vmware frequency leaf is disabled, pretend to be
KVM, with the only capability reported being X2APIC support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  2 ++
 include/system/whpx-internal.h |  1 +
 target/arm/whpx/whpx-all.c     |  1 +
 target/i386/whpx/whpx-all.c    | 63 +++++++++++++++++++++++++++++-----
 4 files changed, 58 insertions(+), 9 deletions(-)

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
index 66f263558f..c2a78312f8 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2083,14 +2083,57 @@ int whpx_vcpu_run(CPUState *cpu)
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
+                    reg_values[2].Reg64 |= CPUID_EXT_HYPERVISOR;
+                    break;
+                case 0x40000000:
+                    /*
+                     * Use vmware_cpuid_freq as a proxy to report VMware.
+                     * This is to get the TSC/APIC frequency query functionality
+                     * provided through vmport, as Linux doesn't use leaf
+                     * 0x40000010 for getting those frequencies.
+                     */
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = 0x40000010;
+                        reg_values[4].Reg64 = 0x61774d56;
+                        reg_values[2].Reg64 = 0x4d566572;
+                        reg_values[3].Reg64 = 0x65726177;
+                    } else {
+                        /* report KVM otherwise if that's disabled */
+                        reg_values[1].Reg64 = 0x40000001;
+                        reg_values[4].Reg64 = 0x4b4d564b;
+                        reg_values[2].Reg64 = 0x564b4d56;
+                        reg_values[3].Reg64 = 0x4d;
+                    }
+                    break;
+                case 0x40000001:
+                    if (!x86_cpu->vmware_cpuid_freq) {
+                        /* KVM reporting of X2APIC support */
+                        reg_values[1].Reg64 = reg_values[4].Reg64 =
+                            reg_values[2].Reg64 = 1 << 15;
+                    }
+                    break;
+                case 0x40000010:
+                    if (x86_cpu->vmware_cpuid_freq) {
+                        reg_values[1].Reg64 = env->tsc_khz;
+                        reg_values[4].Reg64 = env->apic_bus_freq / 1000; /* Hz to KHz */
+                    }
+                    break;
                 }
             }
 
@@ -2311,6 +2354,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2513,6 +2557,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2565,7 +2610,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
+        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.50.1 (Apple Git-155)


