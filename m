Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43AEC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 13:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxoVA-0008UZ-6J; Fri, 19 Apr 2024 09:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxoV7-0008Tr-A7
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 09:42:01 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxoV5-00086R-33
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 09:42:01 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d717603aa5so25092221fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713534115; x=1714138915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oy0myZolFHjohcbr3xwrONm5HW5/I5fGMRWgJnRDNAM=;
 b=DlmDGpYXFvMo/RncRckvX37LNFIOFALnMahG7rfVncfUc8w1PakgJN1r5K1JzE7Muy
 x1/pvvX9QFZXPz7BGnDC+4cE+06pFPJW6rWuhFntJM94Q11RCUeZhOTOJrQ6FFB8N77x
 fiTwO4Jtg2UTkdKkgsUIiP7ysyg8HmjKxxrDCSfnKnPi5uY9Io0BdME1sB2hecMiZcrP
 PBCC7ebLhkLAEiUPqXxBryQyYEXapYEvvcJT4PPCS4Dpuad7kZseHtw8TXu9pBIA3O+E
 q0OcuAFyPVXDNpMu92uooPA1HmLm3hfIJRISP6zk3wBfU+K05lW02Y2ewewPiaYN9F9m
 UVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713534115; x=1714138915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oy0myZolFHjohcbr3xwrONm5HW5/I5fGMRWgJnRDNAM=;
 b=lG/DsImYf0z/g3xO4G11FW5m/zxkDbYfEQhXmbhWRaHn8spyveIvvEHdDVVuTi5Lti
 6G+FF8Zj5QxbbxFJKfpHxUGMILLBNmEpzrUV/ma3MnaBhs6InL/pxKiK2/BJ/WL1JVjP
 zuY55En3PHJc2sUcc3ZOgKKC8qBF6mAR5Ax6fo1ptj2eOQYNp425r4hsm7FfEQ31t2Ng
 d5lOPD1z8xh4J7iRu1Vbt/IdC3neZ6pDLSczehPVDKaVYDzHX5nBcpIPesu53s5OFeX3
 amg98gdAYaO+JjYYZVJlrsGP+mLZWeUHOgpb0N8vkt/mh7JLquq5ElmmPTVBTKXpwREp
 H+2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN18LmkeHUrPuD41kkTZmhA0zimCap8zPiaQ8fllG0senHLR2BxtZdetQM/fxXnY8c/1++dmnuJluRAoBE9dzMFBs929U=
X-Gm-Message-State: AOJu0YwYxeawFKd5iQFaYf3nHHRXp5sXcGF9vefxc8Ojd42+A+RGE1+9
 60vQSPLzEmn4e1NofmWFVaA658IQmwDMPl7n6kLJUP7RPFxC5ZnSbhRmRwgXjvv1KeL5iozaT8W
 DCFr0EcdKRNneOFDsOffnPP6s+J/4LEH2Y19/Gw==
X-Google-Smtp-Source: AGHT+IEnDbHSJ460BVXav28r5PmRaxCiHrhVT/sLueW9glmZRwiGwctqNVBS3FYlCzvCrlRi25rlzvtUOigU1BREe/w=
X-Received: by 2002:a05:6512:3d20:b0:516:d4c2:53eb with SMTP id
 d32-20020a0565123d2000b00516d4c253ebmr2381628lfv.58.1713534114967; Fri, 19
 Apr 2024 06:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240407081733.3231820-1-ruanjinjie@huawei.com>
In-Reply-To: <20240407081733.3231820-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 14:41:43 +0100
Message-ID: <CAFEAcA9Y02am4wfb8Ct9qz7YX_maH4VD+JD+FFc18dBg5+hv7w@mail.gmail.com>
Subject: Re: [PATCH v13 00/24] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Sun, 7 Apr 2024 at 09:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for ARMv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.

I had one last loose end I wanted to tidy up, and I got round
to working through reading the spec about it today. This is
the question of what the "is NMI enabled?" test should be
in the code in arm_gicv3_cpuif.c.

The spec wording isn't always super clear, but there are several
things here:

 * FEAT_NMI : the changes to the CPU proper which implement
   superpriority for IRQ and FIQ, PSTATE.ALLINT, etc etc.
 * FEAT_GICv3_NMI : the changes to the CPU interface for
   GICv3 NMI handling. Any CPU with FEAT_NMI and FEAT_GICv3
   must have this.
 * NMI support in the IRI (Interrupt Routing Infrastructure,
   i.e. all the bits of the GIC that aren't the cpuif; the
   distributor and redistributors). Table 3-1 in the GIC spec
   says that you can have an IRI without NMI support connected
   to a CPU which does have NMI support. This is what the ID
   register bit GICD_TYPER.NMI reports.

At the moment this patchset conflates FEAT_GICv3_NMI and
the NMI support in the IRI. The effect of this is that we
allow a machine model to create a CPU with FEAT_NMI but
without FEAT_GICv3_NMI in the cpuif, and we don't allow
a setup where the CPU and cpuif have NMI support but the
IRI does not. (This will actually happen with this patchset
with the sbsa-ref machine and -cpu max, because we haven't
(yet) made sbsa-ref enable NMI in the GIC device when the
CPU has NMI support.)

For a Linux guest this doesn't make much difference, because
Linux will only enable NMI support if it finds it in both
the IRI and the CPU, but I think it would be better to
get the enable-tests right as these can be awkward to change
after the fact in a backwards-compatible way.

I think this is easy to fix -- we can add a new bool field
GICv3CPUState::nmi_support which we initialize in
gicv3_init_cpuif() if the CPU has FEAT_NMI, and make the
checks in arm_gicv3_cpuif.c check cs->nmi_support instead
of cs->gic->nmi_support. That looks like this squashed into
patch 18:

diff --git a/include/hw/intc/arm_gicv3_common.h
b/include/hw/intc/arm_gicv3_common.h
index 88533749ebb..cd09bee3bc4 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -225,6 +225,13 @@ struct GICv3CPUState {

     /* This is temporary working state, to avoid a malloc in gicv3_update() */
     bool seenbetter;
+
+    /*
+     * Whether the CPU interface has NMI support (FEAT_GICv3_NMI). The
+     * CPU interface may support NMIs even when the GIC proper (what the
+     * spec calls the IRI; the redistributors and distributor) does not.
+     */
+    bool nmi_support;
 };

 /*
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 2457b7bca23..715909d0f7d 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -21,6 +21,7 @@
 #include "hw/irq.h"
 #include "cpu.h"
 #include "target/arm/cpregs.h"
+#include "target/arm/cpu-features.h"
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"

@@ -839,7 +840,7 @@ static int icc_highest_active_prio(GICv3CPUState *cs)
      */
     int i;

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         /*
          * If an NMI is active this takes precedence over anything else
          * for priority purposes; the NMI bit is only in the AP1R0 bit.
@@ -1285,7 +1286,7 @@ static void icc_drop_prio(GICv3CPUState *cs, int grp)
             continue;
         }

-        if (i == 0 && cs->gic->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
+        if (i == 0 && cs->nmi_support && (*papr & ICC_AP1R_EL1_NMI)) {
             *papr &= (~ICC_AP1R_EL1_NMI);
             break;
         }
@@ -1324,7 +1325,7 @@ static int icc_highest_active_group(GICv3CPUState *cs)
      */
     int i;

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         if (cs->icc_apr[GICV3_G1][0] & ICC_AP1R_EL1_NMI) {
             return GICV3_G1;
         }
@@ -1787,7 +1788,7 @@ static void icc_ap_write(CPUARMState *env, const
ARMCPRegInfo *ri,
         return;
     }

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         cs->icc_apr[grp][regno] = value & (0xFFFFFFFFU | ICC_AP1R_EL1_NMI);
     } else {
         cs->icc_apr[grp][regno] = value & 0xFFFFFFFFU;
@@ -1901,7 +1902,7 @@ static uint64_t icc_rpr_read(CPUARMState *env,
const ARMCPRegInfo *ri)
         }
     }

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         /* NMI info is reported in the high bits of RPR */
         if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env)) {
             if (cs->icc_apr[GICV3_G1NS][0] & ICC_AP1R_EL1_NMI) {
@@ -2961,7 +2962,16 @@ void gicv3_init_cpuif(GICv3State *s)
          */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);

-        if (s->nmi_support) {
+        /*
+         * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
+         * implement FEAT_GICv3_NMI, which is the CPU interface part
+         * of NMI support. This is distinct from whether the GIC proper
+         * (redistributors and distributor) have NMI support. In QEMU
+         * that is a property of the GIC device in s->nmi_support;
+         * cs->nmi_support indicates the CPU interface's support.
+         */
+        if (cpu_isar_feature(aa64_nmi, cpu)) {
+            cs->nmi_support = true;
             define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
         }

plus this squashed into patch 19:

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 20a8e1f2fe4..b1f6c16ffef 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -566,7 +566,7 @@ static void icv_ap_write(CPUARMState *env, const
ARMCPRegInfo *ri,

     trace_gicv3_icv_ap_write(ri->crm & 1, regno,
gicv3_redist_affid(cs), value);

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
     } else {
         cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
@@ -1510,7 +1510,7 @@ static int icv_drop_prio(GICv3CPUState *cs, bool *nmi)
             continue;
         }

-        if (i == 0 && cs->gic->nmi_support && (*papr1 & ICV_AP1R_EL1_NMI)) {
+        if (i == 0 && cs->nmi_support && (*papr1 & ICV_AP1R_EL1_NMI)) {
             *papr1 &= (~ICV_AP1R_EL1_NMI);
             *nmi = true;
             return 0xff;
@@ -2699,7 +2699,7 @@ static void ich_ap_write(CPUARMState *env, const
ARMCPRegInfo *ri,

     trace_gicv3_ich_ap_write(ri->crm & 1, regno,
gicv3_redist_affid(cs), value);

-    if (cs->gic->nmi_support) {
+    if (cs->nmi_support) {
         cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
     } else {
         cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
@@ -2821,7 +2821,7 @@ static void ich_lr_write(CPUARMState *env, const
ARMCPRegInfo *ri,
     }

     /* Enforce RES0 bit in NMI field when FEAT_GICv3_NMI is not implemented */
-    if (!cs->gic->nmi_support) {
+    if (!cs->nmi_support) {
         value &= ~ICH_LR_EL2_NMI;
     }

The comments and commit message for patch 24 also need tweaking,
because they are written assuming that FEAT_GICv3_NMI means
"NMI support in the GIC proper", not "NMI support in the cpuif".

Since those changes are not too complicated, and I made them
locally anyway since I wanted to confirm that my plan was
workable, my proposal is that I will apply these fixes while
I take this series into target-arm.next for 9.1.

So I've applied this series to target-arm.next with the above
changes (preparatory to doing a pull request tail end of next
week once we release 9.0). Let me know if you'd prefer something
else.

thanks
-- PMM

