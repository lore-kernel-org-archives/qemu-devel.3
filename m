Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79038CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 04:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVMM4-0000nJ-43; Fri, 05 Jun 2026 00:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wVLZb-0003e7-8g
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 23:50:19 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wVLZZ-0001r2-FM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 23:50:18 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7e0b3db3499so11115427b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780631416; x=1781236216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AdYRwnklS1vxlj6cEc5o0mlVHZszu94r1W3VvhkXFJM=;
 b=Q2vl06IwP8iuAbFsaQrgrOhF3a6x31/LsbmVzj/MPxbug5nrVWm12YmSkL12JX8vAS
 is6pM1NDxoLFG1sB86hCOXroSeQ6mwwYgqAOTH68Vg+4S4UWgtLzmQWbIBlBeVMT1gMJ
 Hria/0UOhrzcPx6s+LnUED8DjMI3qMTLkOmlwD0xz2AmK+R6LTNQB6T3AjW4FLFr7mtO
 tLzSEzR2yyJBwywJuBz+1vZjTWMx0h4mVL+gfKFGZRCt6A2bcMmMYAS1fTkUp/UmBkRX
 8h7+v92xWkiKFt4FL0J+N/x7fvKzaFLOybN2Ttqn1c5cr6WuMSKTGEDLt8DTn0xZwnUu
 RJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780631416; x=1781236216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdYRwnklS1vxlj6cEc5o0mlVHZszu94r1W3VvhkXFJM=;
 b=kIPEWSYzKBPSneNEpbEuxoVKX/q7bDMfaL23NVv0vKXPhZU2BBYrV9xUFZisUN3wCF
 P+kWrBOW95nPYAwPfdK5R0bzTk9fdKtOQosJgFDU3oOqWmY6yRnj43pYIlGDjzpSTDaO
 GceJj2FozfhioawhvldmvRwI3f990egcPlzr6hqbn5njm1sOeYt8Oi0J0RvgmoPloAIr
 YERZGioXmHvshkgLgcpT385RaHHxKNg7CJPr789ZotDabH3Uyi/CA3jxVn7ZEalTUqyw
 q4CMlsg2tKcMXDTF8nH2xHjqmDejvoi+oQ39PBvIT8qm920+mcrCqA92G+VNRjVxQ/gW
 OL9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GV/7tcGUvZ3amRbGSzE/rn8bdJj5KesJAI3ErmT3U0EG93pC8TOZbrrECXq05jlDt8j1993bS922i@nongnu.org
X-Gm-Message-State: AOJu0YzgAd54Fh0E9jcZeGwPprbTUzHnEpr2xLb/ThC6Al/PjgSTyV7b
 9S7bkl0KfDhB8XxWwMboM9yI2UHYxabBRrgFCmcXKL8fBJ1YYM+EsEhb
X-Gm-Gg: Acq92OGeLBQC17xfhFUg6lGYhYd63Qs6rN/hCLGvf+5gt1qSoddJ4AeC24Hn2uPs2yi
 URkt1oa9nTDCL4OWu/GPxLR9O9RFKiVWy+dqabcNBkkd5zkoxkadmTOD1XwXyh6jZ3fSaV4hKcU
 O0IWIZ1TkwbeZx/qcVHcKJ/KTEqE8EqF05+FKprPAB0mLT+6F7aku46WSqPOrkXO+CK6SR1trJp
 zL9nwOyEzeZRc9GxiBSvWGMdxkeq9Bo+2nukas9cF8K+KvNTijoBnffGss36Tm8fe+pJ8tZH82x
 gMtgBSbErFw4Zi40+hGb+xXpWvCBTylH8xw9etEae8uCiNuInXna1ImqNu7nF56xqlNk5ytEGH4
 zKE+4X2n+mRC2NNjEDhyyiD785qhrjZOapHgE+9fkvAPN2VXfko4Shb8a3P6Szd7+xh0cuT0qtU
 ZkiW2DaJA5BfcNFZbhmBNFMzOBTROK9xNKi1XSeBuEMByHM+lkwOT5sd5hL+ARlPJvQ3kdh+b1o
 3caQX2Ri57iH/ny3kDMDmK7/IgFIqw=
X-Received: by 2002:a05:690c:62c8:b0:7dd:b286:dfdb with SMTP id
 00721157ae682-7ed0ceea12cmr18512027b3.41.1780631416183; 
 Thu, 04 Jun 2026 20:50:16 -0700 (PDT)
Received: from skippy.tail1682c8.ts.net
 (99-61-67-1.lightspeed.austtx.sbcglobal.net. [99.61.67.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea20ea9878sm44772987b3.3.2026.06.04.20.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 20:50:15 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] target/arm: honour CCR.BFHFNMIGN for probed data BusFaults
Date: Thu,  4 Jun 2026 22:50:12 -0500
Message-Id: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jun 2026 00:40:21 -0400
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

This surfaced running the real NXP i.MX 95 System Manager firmware on the
emulated Cortex-M33: its SystemMemoryProbe() (set BFHFNMIGN + FAULTMASK,
do the access, test CFSR.BFARVALID) locked up the VM. With this change the
SM's debug-monitor memory-probe commands run and recover correctly.

Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
---
Found while bringing up an out-of-tree i.MX 95 machine running the real NXP
System Manager firmware on the emulated Cortex-M33; the change is generic to
any ARMv7-M guest that probes for devices via BusFault suppression. It is
independent of (and posted alongside) a separate PMSAv7 MPU align-down fix
from the same bring-up.

The new path only runs for an M-profile data access at negative priority with
CCR.BFHFNMIGN set - the previously-broken case that aborted the VM. Normal
BusFaults (no BFHFNMIGN, or at non-negative priority) and instruction fetches
are unchanged.

Tested on master: qemu-system-arm builds clean, and the ARMv7-M / MPS2 qtests
pass with no regression -- boot-serial (incl. stm32vldiscovery, Cortex-M3),
the stm32l4x5 suite (Cortex-M4: exti/gpio/rcc/syscfg/usart), microbit,
sse-timer and cmsdk-apb-watchdog.

 target/arm/tcg/tlb_helper.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

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
2.34.1


