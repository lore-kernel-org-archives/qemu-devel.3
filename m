Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E785F364C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxWT-0008K3-FL; Thu, 09 Apr 2026 18:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWS-0008IQ-Hb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:48 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAxWQ-0000d7-Ku
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:06:48 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2cc4c693d59so971785eec.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775772405; x=1776377205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoJVdciZFaewroq0cySKl+vu/S+aD/kerrA4/hB7jSw=;
 b=kMhxRzX+KqRMLJI2Y7HOEVZkxbpmG+T80eMgG6aWzMA3Ks6e7pveo8SxzJrfL5WseH
 QN5zrnUDUr4Xx+jdzGn3/9SnWyXQ4uNc0mPChXcXNPKSlacVo0i00jrTKAbo85YQWuyp
 VMKjM0JzHxQa7/ljpbjO+FdQ3aDbF72M+I/XjDg/ApAjmUGTj/o3E7hTPTRyHh4hHxjG
 cNoddiZbfqPKuAPaZlQa/NFvlJfD6vgZxdH4xeTWZcF4p+SFgJF+yaze1HC+ORS2Noxi
 lnFSQT9zYOKdbu5UcN+1iKY8tpiibvjAGcx+jxdy5thjPcAR4SJYSDpK2egZ0mOdAI32
 MCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775772405; x=1776377205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VoJVdciZFaewroq0cySKl+vu/S+aD/kerrA4/hB7jSw=;
 b=D2/a6fJwc/wtpxUOf5xgmRqlKTvO2s7YYO0zf50tUZ2ov0IpvFQu0ATghBUNzhy5zR
 nKt+qrIC160VsBzxbzUIUUglz2+7b2ler0F+/xQaZ7nSljM5vgxzXVIwF+jHS0VPZEzp
 BiGLMwVPSmZBJuR+3eQF/EeqplUWkmae+MLfVyHrnfoK1R7LmMKTe8FMoAvI32iDMxL4
 fo2KPPv81ysNBjD8ymQ5Gp+3L/52LvD3Np0Dejzk5FspX2RzptLCA5v6cB4gCFnNDuQu
 sSHqG9ZHl6yZGZwOlxHC1H749X6hKIOevfo1awI3Af0FB9CkGnZFR3J3d/lgQjh3aWzI
 DrDA==
X-Gm-Message-State: AOJu0YxnwjNnZeZjXQ68GY/r0y5E+hAXsCCkC+iEScvPKWdRnBza/dRO
 7CUVUbS5Wly17Bvv2uxHtN92bELoN9PFAQg3byyY/FHaVFJGkU/NjT3pODD+SQXv
X-Gm-Gg: AeBDieudzMmZSUjSUzEd499bEVB38H/R/pIHurvn8Ik/3tz1j68w4deMQOpLyTQ0nUk
 xQz091rfHW+b5YPC/XdU7J7PE+c/wj+O9++96iCvpniRxiec8A6xsUwE0yDFJrjKWa6DInKKEAx
 2n4qkJfSUZ3qIt7YBrYPx1zsIIfNmJpu68YHlFpxUY7mwM0O0rCb+Q6qtakVMvc0HrMkg/vSMxP
 xXNcL5rcFIRc/zGuN2DTRQbK62dm3J47px9ZwDSgme9stggWwq+B/dniQOa2bEH1QAq7jjyJom6
 0m4/iJFztFSnrxFRP07IgevgvkUKNJ+ojgeo3ORmHapubG9C+PJ1iMO+ExpY1n0XTfHXPUJo07+
 2Ru5uoqkg6TwmTcR7/sW2qxe5dGSSXt4ROWy3bLhsUq2YRxIzDlWeraBNLMV3GKaEn1S3xyqcAb
 k+yxl2+SuSmEd8ZqFs/a2X8XmjB9SJSzqNBA+rj/uV+uql+JvtX8OhmAaZpX9zjw==
X-Received: by 2002:a05:7300:6d03:b0:2c1:778:d897 with SMTP id
 5a478bee46e88-2d5888a07c5mr501111eec.21.1775772404920; 
 Thu, 09 Apr 2026 15:06:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:bb40:195d:78fd:ecba:d45])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d561bde68bsm1534567eec.17.2026.04.09.15.06.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 15:06:44 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v6 6/6] target/arm/hvf,
 whpx: wire ISV=0 emulation for data aborts
Date: Thu,  9 Apr 2026 19:06:14 -0300
Message-ID: <20260409220614.65558-7-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


