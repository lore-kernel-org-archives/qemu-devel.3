Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9772CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 00:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYusg-0001Fr-KE; Sun, 14 Jun 2026 20:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYusf-0001Fb-Kz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 20:08:45 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYusd-0001xU-LQ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 20:08:45 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7e16f05fd79so26590207b3.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781482122; x=1782086922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0itSddNhXHUQmdf83KRdnrOB89AyIQq3+Tsy42l9m4E=;
 b=otyAaiUYnLTem2U1KOpRPDxiJC9DGLcywCXjMLHllI9rCb9a6tA9hxU2a3OuSTVl1c
 m0fyStH/hkN/yNwIxsNuvIK7WVErEok9tmu275T/XTD40oCLsTpa7Cc+iBuHXHTWx8RI
 rqXDl14Q9L7dVcdccGA0jJAb+Eg6f8/32R/9rLkDQV5HlAsZUH0gl49z2IVe5VbitwRz
 Bqx8yYJV9e7rtC8on3W671OQUdX3FFH4/Er3MsQyYOhojU9M1ZL6d4UcV5onBwZjJ9/6
 nFxudt4dzIRv4b5SVc+V9iR2QXofonUD8Q3aNUZxjaHSFjrbiH7kFgyCIKyRyKDUMXab
 MRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781482122; x=1782086922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0itSddNhXHUQmdf83KRdnrOB89AyIQq3+Tsy42l9m4E=;
 b=X2dRQehPoFH1BAlPRYBRTdnHpIk9Q2jzUxi1Eq5v/p+mKDl7/VrtirWP1seQtbIubN
 PhdvTQnGlGZ5JJTeLpxHwB+upAOBUSTr/18Fqk3EQmfBzWcWodkczLnqsQkNLULD+cCi
 zdrZV0OH5l5scmsKrXBLhRkuEuORBRAdc8unyc+1CynmFy/oONs25UYTOp/HzE1DNjom
 mZ1rKNFD9cuLzhXADTCQX/5t/m2JkeHHcKC0gKvFwPDlQO9SAWgh/W/DMRK2uZoMJjXn
 M47hbQ+ndqlrS4uas5+jVpqOnp7oHB0dalMQNRFrUCLXeOD5BbUo0j9SyrPuJArZDKqm
 qC5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2SxKSKc5O8Y6+46pmNwGz8JwKt1g4cF0VBCYsg3NE2A4jmrPeZH03mxI/udvQgayskiTWti8Z5zRH@nongnu.org
X-Gm-Message-State: AOJu0YyVHLuu5RSZTQAnjiaX3IE3E4RjxqmiWZkPKCF7rucTEyE7wg22
 /Ytm/ghdohK1+MnFkD34eFSHCXPT0GBnpXa/YRNuMXICX0yOP6mdBJVk
X-Gm-Gg: Acq92OGjb3P+hgL+NiQV6UnR1Nvcv5sXOaw5YGw+EANjAskE9B3jgZE8seBW7czn1UG
 MytRpWqOnAEcrjnBn75sDHh9QYuQKU3WaFSGk0xrxoXSVR5P+p7d/DKtCSO8RDs9hjv3Xi6pPhk
 sJKwXxCfgWjzkCCk5ADHWWyVknNOGUInXHNsmH0b+ODnW9PNwMKpNTQLBhSnqsEuhzPuq1vwITz
 FkGSv+7Fy4M4vpKPLUxpuOlC7XnRqVeRoL7JqY9j18mzSDbaGqiK6RIYshXv6VkRNHdxFh4ctee
 4963CLav0KeNyKCWn6SLByEK/o14va5ueqkVGkh7mZY3/jsBc1Hj/TS8nV4DS3sHUHPEjj+3hou
 e+wiAxGZB08BZ9/0Z61Og3JAnVky5Xxwnw2t9s/xf4LEhnr9gmkCs6CkuYFTUxjsbM8n9slsP8K
 i3jQIJTMuSPRWt4qHWbDvc6lcIL4OFspAKcnN0s83vySI+4WVPCs8hrZJc55iIcgkkqfYTrn+MH
 MrNbDLI8sMv+xiOHBZQpfEK
X-Received: by 2002:a05:690c:4a11:b0:7bd:5af9:f0a2 with SMTP id
 00721157ae682-7f7b5f52026mr122891037b3.14.1781482121917; 
 Sun, 14 Jun 2026 17:08:41 -0700 (PDT)
Received: from skippy.tail1682c8.ts.net
 (99-61-67-1.lightspeed.austtx.sbcglobal.net. [99.61.67.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7f76e2b578asm38654607b3.3.2026.06.14.17.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 17:08:41 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Kyle Fox <kylefoxaustin.github@gmail.com>
Subject: [PATCH v2] target/arm: honour CCR.BFHFNMIGN for probed data BusFaults
Date: Sun, 14 Jun 2026 19:08:35 -0500
Message-Id: <20260615000835.996870-1-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
References: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yw1-x1134.google.com
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
---
v2:
 - Also honour BFHFNMIGN for the SG instruction's stack-word load in
   v7m_read_sg_stack_word() (an AccType_NORMAL access performed manually,
   outside the TCG TLB), per review. The vector-table/stacking/unstacking
   EXCP_BUS sites are left unchanged (AccType_VECTABLE/STACK/UNSTACK).

 target/arm/tcg/m_helper.c   | 12 ++++++++++++
 target/arm/tcg/tlb_helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f2059ed8b03..ba101ecb953 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2086,6 +2086,18 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
         env->v7m.cfsr[M_REG_NS] |=
             (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
         env->v7m.bfar = addr;
+        /*
+         * The SG instruction's stack-word load is an AccType_NORMAL data
+         * access, so CCR.BFHFNMIGN applies: at negative execution priority
+         * with BFHFNMIGN set, the BusFault is suppressed -- the access
+         * completes returning UNKNOWN data (status recorded above), with no
+         * BusFault exception pended.
+         */
+        if ((env->v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK) &&
+            armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
+            *spdata = value;
+            return true;
+        }
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
         return false;
     }
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index bbe1e70bc43..452688010f5 100644
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


