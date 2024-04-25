Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWa-00026y-Gk; Thu, 25 Apr 2024 06:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-00021x-9A
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWR-0007Ci-TG
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso704470f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041610; x=1714646410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XwmIfh7Bnnr9WxqJhGLFJuhVzK85Ho+AZb7h0Ddr584=;
 b=nl8OhEsOy8oJgLY6ZUB0b8Xr49uIO6fefuvNofu+6a1zhwWFRxQEfslDJ4QDumwa9y
 QUjFLNjFRKCCUIrIL3BYIGU+M4dyYqtprs4h8Z8oq1BykrNALmZb3Q3aWjsjlFaBoI8f
 C0ufJmDxWOSL3Dz1cg4X13hh0vJZ43aLxxNUlR94kO/xi52irYiQl24+fvQuXeImFYjP
 +X9hSCBYknEyrpMx5aVPLeJ8FqUM6MzN1ZlwkNLmZhoGkcze9PC7Pb+QYBAowed3UVfW
 t2y23FVaO8qk62detgG1wFRmMpFU4teTsIQzvOQF+wCppFMpbypu1tPxZHB3i5hWwI+T
 sc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041610; x=1714646410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwmIfh7Bnnr9WxqJhGLFJuhVzK85Ho+AZb7h0Ddr584=;
 b=XCRRNCGHKa/KDj/2lLM3HQzBVFgEa/eocxzl8WbD/yBs4WAeeIAhLS7TYoKdbseILC
 z3IW0MSLcboBJgxUVN1ftwivr77PUFHiirWYfm41HLdPDsVPAX37u7gBIqBbJZpDNRtd
 4iIWib5f7sHp16CNC4ZlMztTceHP+FNRrXqIkHiMm0hJy7oT17XkeLnjvqSFJdK7KXTZ
 CMBcw/OTGuRzfSfgbRv/UQ/WvnUMxU/nRYraptUtP4r7N7wWKdfxCQqBBenaDZhCuZ6z
 tvGyeMeEJb4X5thJxYdfyiR+gOsC2HNJTQgFTzINbu1jz+wHUsKFWXE5QZMT1xm6ScLR
 2BdQ==
X-Gm-Message-State: AOJu0YxS8Du/U/6CNE7W0FTmGUrLQTEYGA7trreTWtyB/SH8XSgb7zYe
 2xWvdufaUKEImqLPMiWdVSVs9CcWxpXhz9o4ochEUj9LX4sT359wHehfMIU3ctPV0H+G47ZN9b+
 X
X-Google-Smtp-Source: AGHT+IGk12LX/Up5VpiaR/RUoZFqIDjPlRGn8NpaPJfMyzDD7CnSxrZarab2y/qq6d96KO4SwYKpoQ==
X-Received: by 2002:a05:6000:e09:b0:33e:bdea:629e with SMTP id
 dx9-20020a0560000e0900b0033ebdea629emr3142725wrb.37.1714041610229; 
 Thu, 25 Apr 2024 03:40:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/37] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
Date: Thu, 25 Apr 2024 11:39:40 +0100
Message-Id: <20240425103958.3237225-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.

If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
should be set or clear according to the Non-maskable property. And the RPR
priority should also update the NMI bit according to the APR priority NMI bit.

By the way, add gicv3_icv_nmiar1_read trace event.

If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
NMI again

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: use cs->nmi_support instead of cs->gic->nmi_support]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-20-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gicv3_internal.h  |   4 ++
 hw/intc/arm_gicv3_cpuif.c | 105 +++++++++++++++++++++++++++++++++-----
 hw/intc/trace-events      |   1 +
 3 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 81200eb90e3..bc9f518fe86 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -246,6 +246,7 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_LR_EL2_PRIORITY_SHIFT 48
 #define ICH_LR_EL2_PRIORITY_LENGTH 8
 #define ICH_LR_EL2_PRIORITY_MASK (0xffULL << ICH_LR_EL2_PRIORITY_SHIFT)
+#define ICH_LR_EL2_NMI (1ULL << 59)
 #define ICH_LR_EL2_GROUP (1ULL << 60)
 #define ICH_LR_EL2_HW (1ULL << 61)
 #define ICH_LR_EL2_STATE_SHIFT 62
@@ -277,6 +278,9 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_VTR_EL2_PREBITS_SHIFT 26
 #define ICH_VTR_EL2_PRIBITS_SHIFT 29
 
+#define ICV_AP1R_EL1_NMI (1ULL << 63)
+#define ICV_RPR_EL1_NMI (1ULL << 63)
+
 /* ITS Registers */
 
 FIELD(GITS_BASER, SIZE, 0, 8)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 715909d0f7d..b1f6c16ffef 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -158,6 +158,10 @@ static int ich_highest_active_virt_prio(GICv3CPUState *cs)
     int i;
     int aprmax = ich_num_aprs(cs);
 
+    if (cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI) {
+        return 0x0;
+    }
+
     for (i = 0; i < aprmax; i++) {
         uint32_t apr = cs->ich_apr[GICV3_G0][i] |
             cs->ich_apr[GICV3_G1NS][i];
@@ -192,6 +196,7 @@ static int hppvi_index(GICv3CPUState *cs)
      * correct behaviour.
      */
     int prio = 0xff;
+    bool nmi = false;
 
     if (!(cs->ich_vmcr_el2 & (ICH_VMCR_EL2_VENG0 | ICH_VMCR_EL2_VENG1))) {
         /* Both groups disabled, definitely nothing to do */
@@ -200,6 +205,7 @@ static int hppvi_index(GICv3CPUState *cs)
 
     for (i = 0; i < cs->num_list_regs; i++) {
         uint64_t lr = cs->ich_lr_el2[i];
+        bool thisnmi;
         int thisprio;
 
         if (ich_lr_state(lr) != ICH_LR_EL2_STATE_PENDING) {
@@ -218,10 +224,12 @@ static int hppvi_index(GICv3CPUState *cs)
             }
         }
 
+        thisnmi = lr & ICH_LR_EL2_NMI;
         thisprio = ich_lr_prio(lr);
 
-        if (thisprio < prio) {
+        if ((thisprio < prio) || ((thisprio == prio) && (thisnmi & (!nmi)))) {
             prio = thisprio;
+            nmi = thisnmi;
             idx = i;
         }
     }
@@ -290,6 +298,7 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
      * equivalent of these checks.
      */
     int grp;
+    bool is_nmi;
     uint32_t mask, prio, rprio, vpmr;
 
     if (!(cs->ich_hcr_el2 & ICH_HCR_EL2_EN)) {
@@ -302,10 +311,11 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
      */
 
     prio = ich_lr_prio(lr);
+    is_nmi = lr & ICH_LR_EL2_NMI;
     vpmr = extract64(cs->ich_vmcr_el2, ICH_VMCR_EL2_VPMR_SHIFT,
                      ICH_VMCR_EL2_VPMR_LENGTH);
 
-    if (prio >= vpmr) {
+    if (!is_nmi && prio >= vpmr) {
         /* Priority mask masks this interrupt */
         return false;
     }
@@ -327,6 +337,11 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
         return true;
     }
 
+    if ((prio & mask) == (rprio & mask) && is_nmi &&
+        !(cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI)) {
+        return true;
+    }
+
     return false;
 }
 
@@ -551,7 +566,11 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_icv_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
 
     gicv3_cpuif_virt_irq_fiq_update(cs);
     return;
@@ -698,7 +717,11 @@ static void icv_ctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t icv_rpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     GICv3CPUState *cs = icc_cs_from_env(env);
-    int prio = ich_highest_active_virt_prio(cs);
+    uint64_t prio = ich_highest_active_virt_prio(cs);
+
+    if (cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI) {
+        prio |= ICV_RPR_EL1_NMI;
+    }
 
     trace_gicv3_icv_rpr_read(gicv3_redist_affid(cs), prio);
     return prio;
@@ -737,13 +760,19 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
      */
     uint32_t mask = icv_gprio_mask(cs, grp);
     int prio = ich_lr_prio(cs->ich_lr_el2[idx]) & mask;
+    bool nmi = cs->ich_lr_el2[idx] & ICH_LR_EL2_NMI;
     int aprbit = prio >> (8 - cs->vprebits);
     int regno = aprbit / 32;
     int regbit = aprbit % 32;
 
     cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
     cs->ich_lr_el2[idx] |= ICH_LR_EL2_STATE_ACTIVE_BIT;
-    cs->ich_apr[grp][regno] |= (1 << regbit);
+
+    if (nmi) {
+        cs->ich_apr[grp][regno] |= ICV_AP1R_EL1_NMI;
+    } else {
+        cs->ich_apr[grp][regno] |= (1 << regbit);
+    }
 }
 
 static void icv_activate_vlpi(GICv3CPUState *cs)
@@ -764,6 +793,7 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
     int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
     int idx = hppvi_index(cs);
     uint64_t intid = INTID_SPURIOUS;
+    int el = arm_current_el(env);
 
     if (idx == HPPVI_INDEX_VLPI) {
         if (cs->hppvlpi.grp == grp && icv_hppvlpi_can_preempt(cs)) {
@@ -773,11 +803,16 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
     } else if (idx >= 0) {
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+        bool nmi = env->cp15.sctlr_el[el] & SCTLR_NMI && lr & ICH_LR_EL2_NMI;
 
         if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
             intid = ich_lr_vintid(lr);
             if (!gicv3_intid_is_special(intid)) {
-                icv_activate_irq(cs, idx, grp);
+                if (!nmi) {
+                    icv_activate_irq(cs, idx, grp);
+                } else {
+                    intid = INTID_NMI;
+                }
             } else {
                 /* Interrupt goes from Pending to Invalid */
                 cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
@@ -798,8 +833,37 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
 
 static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* todo */
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    int idx = hppvi_index(cs);
     uint64_t intid = INTID_SPURIOUS;
+
+    if (idx >= 0 && idx != HPPVI_INDEX_VLPI) {
+        uint64_t lr = cs->ich_lr_el2[idx];
+        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
+
+        if ((thisgrp == GICV3_G1NS) && icv_hppi_can_preempt(cs, lr)) {
+            intid = ich_lr_vintid(lr);
+            if (!gicv3_intid_is_special(intid)) {
+                if (lr & ICH_LR_EL2_NMI) {
+                    icv_activate_irq(cs, idx, GICV3_G1NS);
+                } else {
+                    intid = INTID_SPURIOUS;
+                }
+            } else {
+                /* Interrupt goes from Pending to Invalid */
+                cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
+                /*
+                 * We will now return the (bogus) ID from the list register,
+                 * as per the pseudocode.
+                 */
+            }
+        }
+    }
+
+    trace_gicv3_icv_nmiar1_read(gicv3_redist_affid(cs), intid);
+
+    gicv3_cpuif_virt_update(cs);
+
     return intid;
 }
 
@@ -1424,7 +1488,7 @@ static void icv_increment_eoicount(GICv3CPUState *cs)
                                 ICH_HCR_EL2_EOICOUNT_LENGTH, eoicount + 1);
 }
 
-static int icv_drop_prio(GICv3CPUState *cs)
+static int icv_drop_prio(GICv3CPUState *cs, bool *nmi)
 {
     /* Drop the priority of the currently active virtual interrupt
      * (favouring group 0 if there is a set active bit at
@@ -1446,6 +1510,12 @@ static int icv_drop_prio(GICv3CPUState *cs)
             continue;
         }
 
+        if (i == 0 && cs->nmi_support && (*papr1 & ICV_AP1R_EL1_NMI)) {
+            *papr1 &= (~ICV_AP1R_EL1_NMI);
+            *nmi = true;
+            return 0xff;
+        }
+
         /* We can't just use the bit-twiddling hack icc_drop_prio() does
          * because we need to return the bit number we cleared so
          * it can be compared against the list register's priority field.
@@ -1505,6 +1575,7 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int irq = value & 0xffffff;
     int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
     int idx, dropprio;
+    bool nmi = false;
 
     trace_gicv3_icv_eoir_write(ri->crm == 8 ? 0 : 1,
                                gicv3_redist_affid(cs), value);
@@ -1517,8 +1588,8 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * error checks" (because that lets us avoid scanning the AP
      * registers twice).
      */
-    dropprio = icv_drop_prio(cs);
-    if (dropprio == 0xff) {
+    dropprio = icv_drop_prio(cs, &nmi);
+    if (dropprio == 0xff && !nmi) {
         /* No active interrupt. It is CONSTRAINED UNPREDICTABLE
          * whether the list registers are checked in this
          * situation; we choose not to.
@@ -1540,8 +1611,9 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
         int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
+        bool thisnmi = lr & ICH_LR_EL2_NMI;
 
-        if (thisgrp == grp && lr_gprio == dropprio) {
+        if (thisgrp == grp && (lr_gprio == dropprio || (thisnmi & nmi))) {
             if (!icv_eoi_split(env, cs) || irq >= GICV3_LPI_INTID_START) {
                 /*
                  * Priority drop and deactivate not split: deactivate irq now.
@@ -2627,7 +2699,11 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
 
-    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    if (cs->nmi_support) {
+        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
+    } else {
+        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
+    }
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
@@ -2744,6 +2820,11 @@ static void ich_lr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           8 - cs->vpribits, 0);
     }
 
+    /* Enforce RES0 bit in NMI field when FEAT_GICv3_NMI is not implemented */
+    if (!cs->nmi_support) {
+        value &= ~ICH_LR_EL2_NMI;
+    }
+
     cs->ich_lr_el2[regno] = value;
     gicv3_cpuif_virt_update(cs);
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 94030550d5a..47340b5bc13 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -152,6 +152,7 @@ gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu 0x%x valu
 gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu 0x%x value 0x%" PRIx64
 gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_nmiar1_read(uint32_t cpu, uint64_t val) "GICv3 ICV_NMIAR1 read cpu 0x%x value 0x%" PRIx64
 gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu 0x%x value 0x%" PRIx64
 gicv3_cpuif_virt_update(uint32_t cpuid, int idx, int hppvlpi, int grp, int prio) "GICv3 CPU i/f 0x%x virt HPPI update LR index %d HPPVLPI %d grp %d prio %d"
 gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting FIQ %d IRQ %d"
-- 
2.34.1


