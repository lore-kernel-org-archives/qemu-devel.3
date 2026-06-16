Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D87CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBQ-00010M-Rl; Tue, 16 Jun 2026 15:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iG-NU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-00014e-2u
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso3364954f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636849; x=1782241649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMc87tQ2ULiuGMs7LUUhtdlm3P0nrGr1QZBHW/A68sk=;
 b=DkBd5DBkNynmQ2IUD1LN7scgHopP8+4h8gNy0yPnlz623kay9vCxPW6Ab24/gxj3cH
 TlbHD9Ik3Xslq8A0VabHU4L4/5XlRC0tM78sNTThInNYIdlGDRmYKotS/9XYc7oukVHs
 V3JBhevXoiYdbP9Nbw6OncVW3AczaUbxKYAZpKjWZN+wksJo7/Wk9RQPAiMjourcE8To
 HOExz+BJu0/lENsS2gKXGrzXFnpex3baEIBGxYlhpixB7tczFvhgeq7XzLzm3rsry9Nm
 ssjDeK3k+1p0Uuu3AQViHzuPsom4Cbr6lb4zcqBwRC+a+paNnA+S+9wSHub1YDFLjjOk
 DcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636849; x=1782241649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kMc87tQ2ULiuGMs7LUUhtdlm3P0nrGr1QZBHW/A68sk=;
 b=U/sdRx4PJorLR9e79g8f5ws6vWScyWgyGX9XyMyPixwkZ41on1ItquqV7+S3/B0mvG
 RfwIKuR31SfZBb3lSsNmOp/D/8+9UlOBHJL36Nx3/knDI+qbWLw6dWHtp52lBp7tVugk
 QVWGU3IAQ++Eie6LM0nVVbjf17IIuK6YczwMYLq0lptgz4bFWN2NptIm9+SMTzdb5mdU
 D893qGfogcv0XZG3S2nxPkzyAr2/twertqS+aGlpYgb0WrdTNdR/ajw9w6Uly3xeg+qX
 oDcllMO+N9SIpYQy7OokDSB5WM/zTotcxdGK8LTexJnIEVVVD/9ZzH6TBptlELPwpuYe
 rm9w==
X-Gm-Message-State: AOJu0Yw1AgX4v5dqbqBc+uWufVyrFY0jVe3pvjHeobhLTkrW7aiqpKbh
 /X38K3UydkCfO2SV4hFS9i4a/ybvhgmysms1BbqjA/mNDvdYw09o8oMZ127lsRpHce+TTKW8yjr
 1ru1R
X-Gm-Gg: Acq92OHuKSJTqYPwyKTznrAMO/+38IujRq/CTrc/ESQRLZGdPdSRfW4VJoDMe2ZnICF
 EV90h7yZnQlLceI5SwdQPoVM1C43LxXOjDQ8lgtaOX4SmPv2lLSmrb8eQbRxWyzzpHOPBqWX8A1
 7uzzFFHE5mLo2UMHBTy91D54u3myzLMRzTkkPqmgFZ7TKNwtJsuGhepSqFXHA+01GJBCX2kSN1J
 7v/WnsADIlzyQjndLEcMcwso4IzQLO4Q7xoGPGYdS18AjEdINOtOM06imIcbuU72g/onji7xg22
 jiVDGs/95mVF6IQyu5zLuoE8maeR7sNzwLw2znDE6qNfAdHN+tx7lWbg1dBsidvSL3PqGvRrZRx
 SoojNn3o79m38IJlCJtvnKc/tUzn6+DqaCaGUX3kCQZ663vu0Ysns4g3J/WeEgQTuySc6WOZOAT
 KBOA2ed3WWT0l4ZOcDKvpvUvyrXJFSDlPtjfxLEC8Ky4SM3ulfVpl/VZAzOKEnalBuJvLM4C0SN
 unJlGblMVrTZD/CDBxPVfp/UnaLM46F
X-Received: by 2002:a05:6000:270b:b0:462:2636:2b39 with SMTP id
 ffacd0b85a97d-46236462425mr901749f8f.14.1781636848972; 
 Tue, 16 Jun 2026 12:07:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/61] target/arm: honour CCR.BFHFNMIGN for probed data
 BusFaults
Date: Tue, 16 Jun 2026 20:06:19 +0100
Message-ID: <20260616190639.3462006-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Kyle Fox <kylefoxaustin.github@gmail.com>

M-profile CCR.BFHFNMIGN lets software executing at a negative execution
priority (in HardFault/NMI, or with FAULTMASK set) suppress precise data
BusFaults caused by load/store instructions: the access completes
returning UNKNOWN data, the fault status is recorded in BFSR/BFAR, but no
BusFault exception is taken. Software uses this to probe for the presence
of a device.

QEMU stored CCR.BFHFNMIGN but never consumed it: arm_cpu_do_transaction_
failed() always raised the external abort, which arm_v7m_cpu_do_interrupt()
pended as a BusFault and then escalated to a HardFault it could not take at
priority -1, aborting the VM with "Lockup: can't escalate 3 to HardFault".

Honour the bit in arm_cpu_do_transaction_failed(): when the access is a
data access from M-profile code at negative priority with BFHFNMIGN set,
record PRECISERR/BFARVALID and BFAR and return without raising, so the
faulting instruction completes instead of re-faulting forever. Instruction
fetches are unaffected, since BFHFNMIGN applies only to data accesses.

The SG instruction's stack-word load is also an AccType_NORMAL data access
that must honour BFHFNMIGN, but QEMU performs it manually in
v7m_read_sg_stack_word() (outside the TCG TLB, so it never reaches
arm_cpu_do_transaction_failed()). Apply the same suppression there: on a
BusFault, record the status and, when BFHFNMIGN is set at negative
priority, return the UNKNOWN data instead of pending ARMV7M_EXCP_BUS. The
remaining manual EXCP_BUS sites (vector-table loads, stacking, unstacking)
are AccType_VECTABLE/STACK/UNSTACK and are not required to honour the bit,
so they are left unchanged.

This surfaced running the real NXP i.MX 95 System Manager firmware on the
emulated Cortex-M33: its SystemMemoryProbe() (set BFHFNMIGN + FAULTMASK,
do the access, test CFSR.BFARVALID) locked up the VM. With this change the
SM's debug-monitor memory-probe commands run and recover correctly.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: minor tweak to v7m_read_sg_stack_word() code]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c   | 16 ++++++++++++++--
 target/arm/tcg/tlb_helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index c5a553a5d4..f4ba93b291 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2086,8 +2086,20 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
         env->v7m.cfsr[M_REG_NS] |=
             (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
         env->v7m.bfar = addr;
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
-        return false;
+        /*
+         * The SG instruction's stack-word load is an AccType_NORMAL data
+         * access, so CCR.BFHFNMIGN applies: at negative execution priority
+         * with BFHFNMIGN set, the BusFault is suppressed -- the access
+         * completes returning UNKNOWN data (status recorded above), with no
+         * BusFault exception pended.
+         */
+        if (!((env->v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK) &&
+            armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure))) {
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
+            return false;
+        }
+        /* BusFault suppressed; data value is UNKNOWN, we choose 0 */
+        value = 0;
     }
 
     *spdata = value;
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index f90765cb59..cbef9cb03e 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -10,6 +10,7 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "hw/intc/armv7m_nvic.h"
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
@@ -318,8 +319,31 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MemTxResult response, uintptr_t retaddr)
 {
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     ARMMMUFaultInfo fi = {};
 
+    /*
+     * For M-profile, CCR.BFHFNMIGN lets software executing at a negative
+     * priority (in HardFault/NMI, or with FAULTMASK set) suppress precise
+     * data BusFaults from load/store instructions: the access completes
+     * returning UNKNOWN data (the store is dropped), the fault status is
+     * recorded in BFSR/BFAR, but no BusFault exception is taken. This is
+     * the mechanism software uses to probe for the presence of a device
+     * (e.g. the NXP System Manager's SystemMemoryProbe). Honour it by
+     * recording the status and returning without raising, so the faulting
+     * instruction completes rather than re-faulting forever. BFHFNMIGN
+     * applies only to data accesses, so instruction fetches are unaffected.
+     */
+    if (arm_feature(env, ARM_FEATURE_M) &&
+        access_type != MMU_INST_FETCH &&
+        (env->v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK) &&
+        armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
+        env->v7m.cfsr[M_REG_NS] |=
+            (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
+        env->v7m.bfar = addr;
+        return;
+    }
+
     /* now we have a real cpu fault */
     cpu_restore_state(cs, retaddr);
 
-- 
2.43.0


