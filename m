Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485DE85372
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fSN-00059P-7Q; Fri, 03 Apr 2026 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSL-00058y-JY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:05 -0400
Received: from p-east2-cluster6-host3-snip4-10.eps.apple.com ([57.103.76.141]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8fSJ-00007Y-I5
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:25:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 DABC01800B54; Fri, 03 Apr 2026 14:24:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775226302; x=1777818302;
 bh=zl2db1VwfCW29E4LtwT7zz4buZdQP1VZYTXVu1kcs+o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DtoL5rL7Ca/ybfi84oX7+wTkcaEw06Wp0Gv38hKIr/IGF5HEaYdYC68m7GA24kOYUYX+xwokjkbmIbC8wdln1lB+k7ccl0L5GKm7HT/t45CPuN0jSs5bc5UO0UGjrOeo0j0ddPpfqa3VQUCQ8ABcJukz4oMQdzj7Yhaz5FA1jG3p6Y6FrPcybg5teIkenpv8W4L4H4E2+PIn5MTO+ZvI8Cf6OymlO9Aw92kt2koQaNa3Ij1sg9THWpa2C+OHNaFlDiUIPASUblV0PB4dgh0A+4q/lepmxwkUehL/4vV1g3QDrKuQGbDuLxQqQPAusCGN2f3184VErU8djXMEluUYBA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 0E9B31800B7E; Fri, 03 Apr 2026 14:24:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v5 2/9] whpx: i386: x2apic emulation
Date: Fri,  3 Apr 2026 16:24:39 +0200
Message-ID: <20260403142446.36964-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403142446.36964-1-mohamed@unpredictable.fr>
References: <20260403142446.36964-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyOCBTYWx0ZWRfXyg8pUIW8n4n7
 zziVIzqrbdWiSqy19Hf7pbaKW/A479NNs+B1+0cRZCjxkuxxCtiP8sbLyWXRvJGwKt/CDMviY3G
 7XjUWQDUosXebV2y4RkRgjcbwvwl+d0YCXXFog1JH//79Ir4vsXK6+LNpvotrfKCZAl0BZCsmlw
 S/AyZWvvvWr5JBkDqPjxsHoUALzHmK+yAoZMFvBpD8X9B1DDm+x0GGtSomKJch4B/JfA1Zten/7
 drB/CDcjx5/a9NCBY15EjvdC8yIGIpHQYRLRuTRG2U3yQxhboo+NbEhs4Aq1YEUDffSNasuQ3iE
 10ANEyzZ7jPz8cvlaXR3w0VIfgYTVi+2h429eAkJ9IAsAd6Q8mWajWS5cUO2Ng=
X-Proofpoint-GUID: KLqBT4qFOhLpYY90WFpowHXs9MdCDnvv
X-Proofpoint-ORIG-GUID: KLqBT4qFOhLpYY90WFpowHXs9MdCDnvv
X-Authority-Info-Out: v=2.4 cv=afVsXBot c=1 sm=1 tr=0 ts=69cfcdbc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nj4AhdDZwDx412jv8JQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1030
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=734
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604030128
Received-SPF: pass client-ip=57.103.76.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add x2apic emulation to WHPX for the kernel-irqchip=off case.

Unfortunately, it looks like there isn't a workaround available
for proper behavior of PIC interrupts when kernel-irqchip=on
for Windows 10. The OS is out of support outside of extended
security updates so this will not be addressed.

The performance boost is quite visible for multicore guests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 134 +++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e56ae2b343..4127440c0c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1082,6 +1082,8 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
+    prop.ExtendedVmExits.X64CpuidExit = 1;
+
     if (exceptions != 0) {
         prop.ExtendedVmExits.ExceptionExit = 1;
     }
@@ -1898,6 +1900,18 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            uint64_t val;
+
+            if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                val = ((uint32_t)vcpu->exit_ctx.MsrAccess.Rax) |
+                    ((uint64_t)(vcpu->exit_ctx.MsrAccess.Rdx) << 32);
+            } else {
+                /*
+                 * Workaround for [-Werror=maybe-uninitialized]
+                 * with GCC. Not needed with Clang.
+                 */
+                val = 0;
+            }
 
             reg_names[0] = WHvX64RegisterRip;
             reg_names[1] = WHvX64RegisterRax;
@@ -1911,7 +1925,47 @@ int whpx_vcpu_run(CPUState *cpu)
                 && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
                 && !whpx_irqchip_in_kernel()) {
                 is_known_msr = 1;
-                reg_values[1].Reg32 = (uint32_t)X86_CPU(cpu)->env.apic_bus_freq;
+                val = X86_CPU(cpu)->env.apic_bus_freq;
+            }
+
+            if (!whpx_irqchip_in_kernel() &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
+                is_known_msr = 1;
+                if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                    /* Read path unreachable on Hyper-V */
+                    abort();
+                } else {
+                    WHV_REGISTER_VALUE reg = {.Reg64 = val};
+                    int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
+                }
+            }
+
+            if (!whpx_irqchip_in_kernel() &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber >= MSR_APIC_START &&
+                vcpu->exit_ctx.MsrAccess.MsrNumber <= MSR_APIC_END) {
+                int index = vcpu->exit_ctx.MsrAccess.MsrNumber - MSR_APIC_START;
+                int msr_ret;
+                is_known_msr = 1;
+                if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                    bql_lock();
+                    msr_ret = apic_msr_read(X86_CPU(cpu)->apic_state, index, &val);
+                    bql_unlock();
+                    reg_values[1].Reg64 = val;
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                } else {
+                    bql_lock();
+                    msr_ret = apic_msr_write(X86_CPU(cpu)->apic_state, index, val);
+                    bql_unlock();
+                    if (msr_ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                }
             }
             /*
              * For all unsupported MSR access we:
@@ -1921,6 +1975,11 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
+            if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                reg_values[1].Reg32 = (uint32_t)val;
+                reg_values[2].Reg32 = (uint32_t)(val >> 32);
+            }
+
             if (!is_known_msr) {
                 trace_whpx_unsupported_msr_access(vcpu->exit_ctx.MsrAccess.MsrNumber,
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
@@ -1939,6 +1998,47 @@ int whpx_vcpu_run(CPUState *cpu)
             ret = 0;
             break;
         }
+        case WHvRunVpExitReasonX64Cpuid: {
+            WHV_REGISTER_VALUE reg_values[5] = {0};
+            WHV_REGISTER_NAME reg_names[5];
+            UINT32 reg_count = 5;
+            X86CPU *x86_cpu = X86_CPU(cpu);
+            CPUX86State *env = &x86_cpu->env;
+
+            reg_names[0] = WHvX64RegisterRip;
+            reg_names[1] = WHvX64RegisterRax;
+            reg_names[2] = WHvX64RegisterRcx;
+            reg_names[3] = WHvX64RegisterRdx;
+            reg_names[4] = WHvX64RegisterRbx;
+
+            reg_values[0].Reg64 =
+                vcpu->exit_ctx.VpContext.Rip +
+                vcpu->exit_ctx.VpContext.InstructionLength;
+
+            reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+            reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+            reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+            reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
+                if (cpu_has_x2apic_feature(env)) {
+                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                }
+            }
+
+            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+                whpx->partition,
+                cpu->cpu_index,
+                reg_names, reg_count,
+                reg_values);
+
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to set CpuidAccess state "
+                             " registers, hr=%08lx", hr);
+            }
+            ret = 0;
+            break;
+        }
         case WHvRunVpExitReasonException:
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
@@ -2136,6 +2236,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     bool is_legacy_os = false;
+    UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
 
@@ -2354,6 +2455,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
+    prop.ExtendedVmExits.X64CpuidExit = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
@@ -2366,6 +2468,36 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.X64MsrExitBitmap.UnhandledMsrs = 1;
+    if (!whpx_irqchip_in_kernel()) {
+        prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeX64MsrExitBitmap,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set MSR exit bitmap, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeCpuidExitList,
+        cpuidExitList,
+        RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
+                     hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /*
      * We do not want to intercept any exceptions from the guest,
      * until we actually start debugging with gdb.
-- 
2.50.1 (Apple Git-155)


