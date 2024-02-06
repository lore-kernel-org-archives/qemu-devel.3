Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B47FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWB-0000Xy-Iu; Tue, 06 Feb 2024 08:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW9-0000Ra-Aa
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:41 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008Du-ID
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:40 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so366344f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226174; x=1707830974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tJkH1WKc0d+Tj/MyZyA5jaOYWrI3hG22yiWDaBwTxjc=;
 b=dfdS0QVMhgK0QmhVQr2+v2NnOFWAnWLYlQ26y13jCikV8tGnMkqgEppdgoYAke+nlj
 f37PCRAtXck/CW4KCz2EEjR/XAraZqgH3SOAo0ZG2klaasLIAg5LSCHUVJ94tRStCJT5
 xQ++b4w7nNy4SyvUtDIkfXkAVeD871U7RZAtt2SQBASnrEW6T9ZlojKXQKswFbV1vfiE
 hcnU9Q263hc00V4358lB5Jek2SXKQ23jHCJY2tZbrBvrMvry2fsFGvuipRgDQbEtGsDG
 O74bj2SB6DJbIQX1/9w64luffhFnczOf4w0JAH23mhDeLH6ujfC0+nvQmJZAK69PaFfG
 2Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226174; x=1707830974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJkH1WKc0d+Tj/MyZyA5jaOYWrI3hG22yiWDaBwTxjc=;
 b=EYTf53CfsQl1sMcapnfFJt3LPg1VGD84pXsGPMtHD6J+n/4jyOfVf1101PQgKr6ggB
 5O/ShNcuCOYvUIjX+qbmXgsz5mZ8XykPEoJJs3XKjshDTPru5PcWYuFFnWjfJmpn0CO5
 50u68T160H/73vzex3Tztip2F2XOpmKUHPpuGOKsE3WFJRcYVYFEV199jfu2HOpzwlYj
 SJScwB2IXMuhW1Rjn/qm6WNtfaGx+56fkXwCrXWvqsUSmUEReKlxupBcQ5IdHz3M+j+0
 cXY4C/uGl1ns6cq4ouOuRXH8qydMsFyAnrxjuxM/n6+NvJsh1PFIrbpfbH74a8XX1y45
 oWlQ==
X-Gm-Message-State: AOJu0YzkFLbTt+7HxnB7WvlZtpJ/dvZAdYxnGC/JIw9nw9v5+nwH5K9G
 yv9xB6Jh+tqz7rZaS5sqzdyiKXBztpTZQDstqtNM5RakJh69Ip1dRm75FEiJ9YE=
X-Google-Smtp-Source: AGHT+IHg6/FjIVNMcqM8p6YoGaSzOLiKxDOLAAqWjuB4h3lzIa3fvefg0pWc9LHuT0Hifn9dUM4k7w==
X-Received: by 2002:a05:6000:10cd:b0:33b:304a:cf90 with SMTP id
 b13-20020a05600010cd00b0033b304acf90mr1419851wrx.2.1707226174460; 
 Tue, 06 Feb 2024 05:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUDRJzIWc4Z6aMSmuLC+QdTahm9ynbYjPLaa07GAQ6KxecmjT4Z5RycpfFoeM8zGEV6PVV4O+GK7u0c+CLxA3Q+URtpZJ0=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/13] target/arm: Allow access to SPSR_hyp from hyp mode
Date: Tue,  6 Feb 2024 13:29:22 +0000
Message-Id: <20240206132931.38376-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Architecturally, the AArch32 MSR/MRS to/from banked register
instructions are UNPREDICTABLE for attempts to access a banked
register that the guest could access in a more direct way (e.g.
using this insn to access r8_fiq when already in FIQ mode).  QEMU has
chosen to UNDEF on all of these.

However, for the case of accessing SPSR_hyp from hyp mode, it turns
out that real hardware permits this, with the same effect as if the
guest had directly written to SPSR. Further, there is some
guest code out there that assumes it can do this, because it
happens to work on hardware: an example Cortex-R52 startup code
fragment uses this, and it got copied into various other places,
including Zephyr. Zephyr was fixed to not use this:
 https://github.com/zephyrproject-rtos/zephyr/issues/47330
but other examples are still out there, like the selftest
binary for the MPS3-AN536.

For convenience of being able to run guest code, permit
this UNPREDICTABLE access instead of UNDEFing it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Last time this came up I preferred the "keep QEMU behaviour
as it is, try to get the guest code fixed" approach:
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg899970.html
but as this is the second time I lean a bit more towards
behaving like the hardware.
---
 target/arm/tcg/op_helper.c | 43 ++++++++++++++++++++++++++------------
 target/arm/tcg/translate.c | 19 +++++++++++------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index b5ac26061c7..c199b69fbff 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -570,10 +570,24 @@ static void msr_mrs_banked_exc_checks(CPUARMState *env, uint32_t tgtmode,
      */
     int curmode = env->uncached_cpsr & CPSR_M;
 
-    if (regno == 17) {
-        /* ELR_Hyp: a special case because access from tgtmode is OK */
-        if (curmode != ARM_CPU_MODE_HYP && curmode != ARM_CPU_MODE_MON) {
-            goto undef;
+    if (tgtmode == ARM_CPU_MODE_HYP) {
+        /*
+         * Handle Hyp target regs first because some are special cases
+         * which don't want the usual "not accessible from tgtmode" check.
+         */
+        switch (regno) {
+        case 16 ... 17: /* ELR_Hyp, SPSR_Hyp */
+            if (curmode != ARM_CPU_MODE_HYP && curmode != ARM_CPU_MODE_MON) {
+                goto undef;
+            }
+            break;
+        case 13:
+            if (curmode != ARM_CPU_MODE_MON) {
+                goto undef;
+            }
+            break;
+        default:
+            g_assert_not_reached();
         }
         return;
     }
@@ -604,13 +618,6 @@ static void msr_mrs_banked_exc_checks(CPUARMState *env, uint32_t tgtmode,
         }
     }
 
-    if (tgtmode == ARM_CPU_MODE_HYP) {
-        /* SPSR_Hyp, r13_hyp: accessible from Monitor mode only */
-        if (curmode != ARM_CPU_MODE_MON) {
-            goto undef;
-        }
-    }
-
     return;
 
 undef:
@@ -625,7 +632,12 @@ void HELPER(msr_banked)(CPUARMState *env, uint32_t value, uint32_t tgtmode,
 
     switch (regno) {
     case 16: /* SPSRs */
-        env->banked_spsr[bank_number(tgtmode)] = value;
+        if (tgtmode == (env->uncached_cpsr & CPSR_M)) {
+            /* Only happens for SPSR_Hyp access in Hyp mode */
+            env->spsr = value;
+        } else {
+            env->banked_spsr[bank_number(tgtmode)] = value;
+        }
         break;
     case 17: /* ELR_Hyp */
         env->elr_el[2] = value;
@@ -659,7 +671,12 @@ uint32_t HELPER(mrs_banked)(CPUARMState *env, uint32_t tgtmode, uint32_t regno)
 
     switch (regno) {
     case 16: /* SPSRs */
-        return env->banked_spsr[bank_number(tgtmode)];
+        if (tgtmode == (env->uncached_cpsr & CPSR_M)) {
+            /* Only happens for SPSR_Hyp access in Hyp mode */
+            return env->spsr;
+        } else {
+            return env->banked_spsr[bank_number(tgtmode)];
+        }
     case 17: /* ELR_Hyp */
         return env->elr_el[2];
     case 13:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5fa82497238..f947c62c6be 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2822,13 +2822,20 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
         break;
     case ARM_CPU_MODE_HYP:
         /*
-         * SPSR_hyp and r13_hyp can only be accessed from Monitor mode
-         * (and so we can forbid accesses from EL2 or below). elr_hyp
-         * can be accessed also from Hyp mode, so forbid accesses from
-         * EL0 or EL1.
+         * r13_hyp can only be accessed from Monitor mode, and so we
+         * can forbid accesses from EL2 or below.
+         * elr_hyp can be accessed also from Hyp mode, so forbid
+         * accesses from EL0 or EL1.
+         * SPSR_hyp is supposed to be in the same category as r13_hyp
+         * and UNPREDICTABLE if accessed from anything except Monitor
+         * mode. However there is some real-world code that will do
+         * it because at least some hardware happens to permit the
+         * access. (Notably a standard Cortex-R52 startup code fragment
+         * does this.) So we permit SPSR_hyp from Hyp mode also, to allow
+         * this (incorrect) guest code to run.
          */
-        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 2 ||
-            (s->current_el < 3 && *regno != 17)) {
+        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 2
+            || (s->current_el < 3 && *regno != 16 && *regno != 17)) {
             goto undef;
         }
         break;
-- 
2.34.1


