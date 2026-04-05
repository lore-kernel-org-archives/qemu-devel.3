Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08707E64001
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9DJn-0003aD-5v; Sat, 04 Apr 2026 22:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJl-0003ZV-CB
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:29 -0400
Received: from p-east2-cluster4-host1-snip4-2.eps.apple.com ([57.103.78.153]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w9DJj-0008GE-KX
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 22:34:29 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 32EB11800157; Sun, 05 Apr 2026 02:34:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775356466; x=1777948466;
 bh=jSLmZGlzvEexo+rQ0/p11fTwifUtxaSisl7gqaHKfXw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LY0mladZVj7VhfMYsTDwOtYSl4eh4mVe4RaZVvXsjQRmaqYZO04R2+zufJNwYefZqz3eJg7kwMi7HjcXJA1aoJ2lLDAVl1W/jkYYmycvFWoC+UGTc5LBsTgvP3sK82196UMxKrPJ58gXuObA6fJ1mBkcCtkBteBxiA4AGSkuBhmvq6/kEK1eFdMk0/N5n5BarzOrCVd3IXkiMb+8yqqFlB0zoWLuH+oUjqF/Ey0NjSPiwTGmJ7RuF0dVTiGmKApEv1HTPnIuZPfSr6pW70H2FyGaeF/rqVNXzu0qffxe5XCMfQjG7zS5BPOeZJ0fTgs36EN6c9ZCTTzHztDxTKcHSg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 C9DF61800144; Sun, 05 Apr 2026 02:34:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 06/11] whpx: i386: reintroduce enlightenments for Windows 10
Date: Sun,  5 Apr 2026 04:34:04 +0200
Message-ID: <20260405023409.23142-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405023409.23142-1-mohamed@unpredictable.fr>
References: <20260405023409.23142-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LPBrgZW9 c=1 sm=1 tr=0 ts=69d1ca30
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hfWBbujXMTx1PmRkPVYA:9
X-Proofpoint-ORIG-GUID: xfm9LldCglwkZAu08ZUdiRGm0lzkUMIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAyNCBTYWx0ZWRfX+BR+6KeLJnnM
 EBO1cCZnwQjJYWeuKULFnOZvPqWv1Rc19xZSpkgl7ipjkmI4mkoUjbQI2OjANACfNkXHNbX1HgD
 l4K6cGzJ89vANXB9p6GZVoxLnLf3QPQrVFX0vNt4A/CC/2qpBxDgIYiQ9PrclDcxkyOYt6JmCu3
 ZTo7pU+FhZ7RG1WvsuP28PfGd/jKiIiNMCXJV1jdmpM13lLoRSD0mOEIOgOvZsDCOR/ilqPAG6n
 psqHkfoRerY/vNTTVUhTye80+9Xf+DyN0QMT5Oh/fll7DJMhPGbP5V9v2+4qlxjQM7Spd6g58fI
 6x9WOgrKe3SSc9onwbLPrs80Y3yU2Ct4cvf+CzWxioZ3r8dJ97IWcInG6xI3Uc=
X-Proofpoint-GUID: xfm9LldCglwkZAu08ZUdiRGm0lzkUMIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1030 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050024
Received-SPF: pass client-ip=57.103.78.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/whpx/whpx-all.c    | 66 +++++++++++++++++++++++++++++-----
 4 files changed, 61 insertions(+), 9 deletions(-)

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
index 66f263558f..5601cacd33 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2083,14 +2083,60 @@ int whpx_vcpu_run(CPUState *cpu)
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
 
@@ -2311,6 +2357,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
 
     whpx = &whpx_global;
 
@@ -2513,6 +2560,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
+        whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2565,7 +2613,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        cpuidExitList,
+        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
-- 
2.50.1 (Apple Git-155)


