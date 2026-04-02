Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2721CC6B00
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8AgX-0002Ta-GN; Thu, 02 Apr 2026 01:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgU-0002OJ-6B
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:38 -0400
Received: from qs-2007a-snip4-3.eps.apple.com ([57.103.84.134]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgS-0004vo-EX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 56E5918000BE; Thu, 02 Apr 2026 05:33:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775108015; x=1777700015;
 bh=8jTy0gf7qMH8U5KzSkYzttZHwJqtRQSF990AWX8r1Uo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=I58gikVmsogm04zl/H+UGqQ4roTrI3R3eQbT4hNS2+Lbke+fs8cDfiRpfm7VBycuLrQ+6cbcC7qbRkYkQ0wm2MizkWHX/YfuBlPbJs3y5Ig47LQQXiTZ6RUfE0oyeX+LoCuBh+CJCPOalNzesxIfiHtyFRhWI7Rsdniwo3Pbmp2acCto/CH75CRfG7acWl3eW2kEnfcoj3JRzsYmKXupix0aDuHSwPQqUIIGljINUX0Ee/FnLLIBd6zedsaC4DOHpTFE83J6XZrGw+y673JnhLjKC4M1VZ9DNvucqjCL/BAMoxh4knFFjS4BCtE9rRBsoWGncfbUXZqPScJwRgvttw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 B127F1800365; Thu, 02 Apr 2026 05:33:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/4] whpx: i386: x2apic emulation
Date: Thu,  2 Apr 2026 07:33:24 +0200
Message-ID: <20260402053326.23402-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402053326.23402-1-mohamed@unpredictable.fr>
References: <20260402053326.23402-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NyBTYWx0ZWRfX/VblUMSQQwWi
 tGUeqA6GlTb9pasRYIePp2rSmToEGIH/bn5yy5MgSJGp0203lvsk5ac2GMOWpJOTBbPiqnQATL8
 Xf1CzoYCjKRvm2DDkfRYbAPOYgNPr5mkybBanimRDhBwThALJavcaJ5Gc6tgj/mY3ZFH3hUAgbf
 SUhg4rXxJpJUAGurkmqmQVDMwU6FaIewLgQAhl1tSlCT5BkUflSg2vYm95St8RiR8Y7oNGX/yzf
 MHnIklmse73S2N2vfZmgGW1CgAtQ2eISTJcYSIM5UlZg0NVAeHYsOtoAW8jYFYL5BqcDPXQAlzL
 vfK+c3sgEL0Oy6Nqz1XJ+lH3K5O6356nh9maRRcZemsv6cRW6mZhF6AHC6o1nA=
X-Authority-Info-Out: v=2.4 cv=Y4j1cxeN c=1 sm=1 tr=0 ts=69cdffae
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZRGgWdpwccs3gJCA4M8A:9
X-Proofpoint-GUID: Z-X7x3-WyXwsISqw7jW2rT3FZASTzqpW
X-Proofpoint-ORIG-GUID: Z-X7x3-WyXwsISqw7jW2rT3FZASTzqpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=627 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020047
Received-SPF: pass client-ip=57.103.84.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Add x2apic emulation to WHPX for the kernel-irqchip=off case.

Unfortunately, it looks like there isn't a workaround available
for proper behavior of PIC interrupts when kernel-irqchip=on
for Windows 10. The OS is out of support outside of extended
security updates so this will not be addressed.

On Windows 11, x2apic will be enabled straight away because
Linux enables it even without an IOMMU when using Hyper-V.

For Windows 10, you need: -device intel-iommu,intremap=on,eim=on

The performance impact is worthwhile for multicore guests.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 128 +++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e56ae2b343..f06474c31b 100644
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
@@ -1898,6 +1900,12 @@ int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[3];
             UINT32 reg_count;
             bool is_known_msr = 0; 
+            uint64_t val;
+
+            if (vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                val = ((uint32_t)vcpu->exit_ctx.MsrAccess.Rax) |
+                    ((uint64_t)(vcpu->exit_ctx.MsrAccess.Rdx) << 32);
+            }
 
             reg_names[0] = WHvX64RegisterRip;
             reg_names[1] = WHvX64RegisterRax;
@@ -1911,7 +1919,47 @@ int whpx_vcpu_run(CPUState *cpu)
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
+                    int ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
+                    if (ret < 0) {
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
+                int ret;
+                is_known_msr = 1;
+                if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
+                    bql_lock();
+                    ret = apic_msr_read(X86_CPU(cpu)->apic_state, index, &val);
+                    bql_unlock();
+                    reg_values[1].Reg64 = val;
+                    if (ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                } else {
+                    bql_lock();
+                    ret = apic_msr_write(X86_CPU(cpu)->apic_state, index, val);
+                    bql_unlock();
+                    if (ret < 0) {
+                        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    }
+                }
             }
             /*
              * For all unsupported MSR access we:
@@ -1921,6 +1969,11 @@ int whpx_vcpu_run(CPUState *cpu)
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
@@ -1939,6 +1992,47 @@ int whpx_vcpu_run(CPUState *cpu)
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
 
@@ -2136,6 +2230,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
     bool is_legacy_os = false;
+    UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
 
@@ -2354,6 +2449,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
+    prop.ExtendedVmExits.X64CpuidExit = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
@@ -2366,6 +2462,36 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


