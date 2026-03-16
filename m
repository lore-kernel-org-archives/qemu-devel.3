Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A328EF30298
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 02:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1y33-0002Ci-PL; Sun, 15 Mar 2026 22:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2o-00029S-Oo
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:51:07 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1y2m-0000Xq-W9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 22:51:02 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2c0bcd8f194so1134815eec.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773629459; x=1774234259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoJVdciZFaewroq0cySKl+vu/S+aD/kerrA4/hB7jSw=;
 b=m8zq+Rx1Lv5r07qV6BcwN8l9DHgPlK/CLE8L2eaU1sYF5QCkCyCPfOMF9krQVdO8QH
 UkyAsOMuwrwV0zGs+VdJUW8Tf+Z/Y6D8Oi2uuOks9god0Prd6GfPpf0W+ZjpspxVJlZM
 s4WwPIER2Q79B4RYUbDlv4rObq6AWeu9k5YvHS5awEwj/fSBPdKnV9wbx7iwIRDB15W0
 YLW3l4uNrEBPauP6S3FCSE4DtHO5HpsZkerB9cN6Pc/A+VG0z2sAtUmESe9DLji05xgQ
 eaS9eVi1DDENbdcrMiBWDfGnxwbDtijBYhupOuEnIWOHo+ie4VyYcHRJaTsnbla5Ut+h
 L2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773629459; x=1774234259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VoJVdciZFaewroq0cySKl+vu/S+aD/kerrA4/hB7jSw=;
 b=hw0wIdvA8nMNGBFkwxwjBhuI6SG1ATVMM17W/9T9mDU/ta7rbB2GrQcQDMQRCCdzxo
 zsPqUYySVjPjkl9JNUctxmN+jvINyFjzvlq5080sxslvU+DT0T0Lt/OeOnruEPqeeRNv
 dxtMqni4t1a1JlMpbYdFD0/PicFhM2zWT73JAqO1BP8VQIXLBBJ1raqj1I09UQTGWeJc
 LHWpf1K7J5fXt/IiNW6KlcXYoAM+uaBgP5Gfpxvb3NMzaFQL2eQI8capBTf2tEpVllv3
 oMCbPpOM2Z/4/a29ZhFgp8bDhqUX6BpGNnqRWDx11hqBuAnWl8I2tXBw+x2VCFTw20wo
 uHCQ==
X-Gm-Message-State: AOJu0YyzT62uByxnJsSnzrOwZ8yQ9ihhw1oVyqyk7cVJq+Cr7vvuljzx
 Xw6pBzrgxjwMp6NyIiozq+DwkR0Zb1fdulxNxL4+IveBHqdv0AfqMX/b+xpCHoX3
X-Gm-Gg: ATEYQzwInNR+0odYkSUNc/kRJazWunefejeKTFecWB3e688NMYZZis9YCqy2NOpJGiH
 wuYH1tJ7DzQvqurr8PFCTvs4CLZz+0foro8CRfHoSu+L17GLnV/XYFXHGwYk97CWk66d5DmeoEk
 gXP3E2vQHPz4r44tCKYnqTfqucUkA6v0BQAmnZ4SS3e5F3GC9hTm6pt9lhUDp/aPNeYIXJD8tSX
 GJ7JOPuLvWn4RL0WoYlZQshYw2sPQbw8n4CeINbgdOhyn9tD7PCIYGf+901a2iBU3jS7+afF52z
 O1HXNBC8Xos+OIdZfxzLlsy9IwAtEq2dJmxp5+Jr1eikx8Swv6SMKd6SXLfgtkR7B22GoL9morv
 neyue0ZCAQcdCXCHSSl1lNX49lORJlrnibas4mGsC6sZRp3SM0Tg+R02Fey8nKvSJFKdu1rCzCG
 Q3YvdvShDaC/TsmhnFOjes+HtlZ/G/60vWHpGe5BXpLvrTTWqABg==
X-Received: by 2002:a05:693c:3113:b0:2b7:fdb6:ccf6 with SMTP id
 5a478bee46e88-2bea547ecd8mr4693975eec.14.1773629458994; 
 Sun, 15 Mar 2026 19:50:58 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3a12e2sm13138973eec.2.2026.03.15.19.50.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 15 Mar 2026 19:50:58 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 6/6] target/arm/hvf,
 whpx: wire ISV=0 emulation for data aborts
Date: Sun, 15 Mar 2026 23:50:34 -0300
Message-ID: <20260316025034.85611-7-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316025034.85611-1-lucaaamaral@gmail.com>
References: <20260315034123.41921-1-lucaaamaral@gmail.com>
 <20260316025034.85611-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When a data abort with ISV=0 occurs during MMIO emulation, the
syndrome register does not carry the access size or target register.
Previously this hit an assert(isv) and killed the VM.

Replace the assert with instruction fetch + decode + emulate using the
shared library in target/arm/emulate/.  The faulting instruction is read
from guest memory via cpu_memory_rw_debug(), decoded by the decodetree-
generated decoder, and emulated against the vCPU register file.

Both HVF (macOS) and WHPX (Windows Hyper-V) use the same pattern:
  1. cpu_synchronize_state() to flush hypervisor registers
  2. Fetch 4-byte instruction at env->pc
  3. arm_emul_insn(env, insn)
  4. On success, advance PC past the emulated instruction

If the instruction is unhandled or a memory error occurs, a synchronous
external abort is injected into the guest via syn_data_abort_no_iss()
with fnv=1 and fsc=0x10, matching the syndrome that KVM uses in
kvm_inject_arm_sea().  The guest kernel's fault handler then reports
the error through its normal data abort path.

WHPX adds a whpx_inject_data_abort() helper and adjusts the
whpx_handle_mmio() return convention so the caller skips PC advancement
when an exception has been injected.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/hvf/hvf.c       | 46 ++++++++++++++++++++++++++--
 target/arm/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bb..000e54bd 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -32,6 +32,7 @@
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
+#include "emulate/arm_emulate.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/trace.h"
@@ -2175,10 +2176,49 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         assert(!s1ptw);
 
         /*
-         * TODO: ISV will be 0 for SIMD or SVE accesses.
-         * Inject the exception into the guest.
+         * ISV=0: syndrome doesn't carry access size/register info.
+         * Fetch and emulate via target/arm/emulate/.
          */
-        assert(isv);
+        if (!isv) {
+            ARMCPU *arm_cpu = ARM_CPU(cpu);
+            CPUARMState *env = &arm_cpu->env;
+            uint32_t insn;
+            ArmEmulResult r;
+
+            cpu_synchronize_state(cpu);
+
+            if (cpu_memory_rw_debug(cpu, env->pc,
+                                    (uint8_t *)&insn, 4, false) != 0) {
+                bool same_el = arm_current_el(env) == 1;
+                uint32_t esr = syn_data_abort_no_iss(same_el,
+                    1, 0, 0, 0, iswrite, 0x10);
+
+                error_report("HVF: cannot read insn at pc=0x%" PRIx64,
+                             (uint64_t)env->pc);
+                env->exception.vaddress = excp->virtual_address;
+                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
+                break;
+            }
+
+            r = arm_emul_insn(env, insn);
+            if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
+                bool same_el = arm_current_el(env) == 1;
+                uint32_t esr = syn_data_abort_no_iss(same_el,
+                    1, 0, 0, 0, iswrite, 0x10);
+
+                error_report("HVF: ISV=0 %s insn 0x%08x at "
+                             "pc=0x%" PRIx64 ", injecting data abort",
+                             r == ARM_EMUL_UNHANDLED ? "unhandled"
+                                                     : "memory error",
+                             insn, (uint64_t)env->pc);
+                env->exception.vaddress = excp->virtual_address;
+                hvf_raise_exception(cpu, EXCP_DATA_ABORT, esr, 1);
+                break;
+            }
+
+            advance_pc = true;
+            break;
+        }
 
         /*
          * Emulate MMIO.
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551be..0c04073e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -29,6 +29,7 @@
 #include "syndrome.h"
 #include "target/arm/cpregs.h"
 #include "internals.h"
+#include "emulate/arm_emulate.h"
 
 #include "system/whpx-internal.h"
 #include "system/whpx-accel-ops.h"
@@ -352,6 +353,27 @@ static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
     whpx_set_reg(cpu, reg, reg_val);
 }
 
+/*
+ * Inject a synchronous external abort (data abort) into the guest.
+ * Used when ISV=0 instruction emulation fails.  Matches the syndrome
+ * that KVM uses in kvm_inject_arm_sea().
+ */
+static void whpx_inject_data_abort(CPUState *cpu, bool iswrite)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    bool same_el = arm_current_el(env) == 1;
+    uint32_t esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, iswrite, 0x10);
+
+    cpu->exception_index = EXCP_DATA_ABORT;
+    env->exception.target_el = 1;
+    env->exception.syndrome = esr;
+
+    bql_lock();
+    arm_cpu_do_interrupt(cpu);
+    bql_unlock();
+}
+
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
@@ -366,7 +388,40 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
     uint64_t val = 0;
 
     assert(!cm);
-    assert(isv);
+
+    /*
+     * ISV=0: syndrome doesn't carry access size/register info.
+     * Fetch and decode the faulting instruction via the emulation library.
+     */
+    if (!isv) {
+        ARMCPU *arm_cpu = ARM_CPU(cpu);
+        CPUARMState *env = &arm_cpu->env;
+        uint32_t insn;
+        ArmEmulResult r;
+
+        cpu_synchronize_state(cpu);
+
+        if (cpu_memory_rw_debug(cpu, env->pc,
+                                (uint8_t *)&insn, 4, false) != 0) {
+            error_report("WHPX: cannot read insn at pc=0x%" PRIx64,
+                         (uint64_t)env->pc);
+            whpx_inject_data_abort(cpu, iswrite);
+            return 1;
+        }
+
+        r = arm_emul_insn(env, insn);
+        if (r == ARM_EMUL_UNHANDLED || r == ARM_EMUL_ERR_MEM) {
+            error_report("WHPX: ISV=0 %s insn 0x%08x at "
+                         "pc=0x%" PRIx64 ", injecting data abort",
+                         r == ARM_EMUL_UNHANDLED ? "unhandled"
+                                                 : "memory error",
+                         insn, (uint64_t)env->pc);
+            whpx_inject_data_abort(cpu, iswrite);
+            return 1;
+        }
+
+        return 0;
+    }
 
     if (iswrite) {
         val = whpx_get_gp_reg(cpu, srt);
@@ -451,6 +506,10 @@ int whpx_vcpu_run(CPUState *cpu)
             }
 
             ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
+            if (ret > 0) {
+                advance_pc = false;
+                ret = 0;
+            }
             break;
         case WHvRunVpExitReasonCanceled:
             cpu->exception_index = EXCP_INTERRUPT;
-- 
2.52.0


