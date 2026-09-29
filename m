Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF60CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUex-000753-SQ; Tue, 29 Sep 2026 06:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUev-00072i-At
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:01 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUet-0008BW-N7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:01 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso2492835f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676118; x=1791280918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/h6ElBbh9pFqRgZXgY7SIaYH/shWE9rzk2S+mkE/uto=;
 b=tni35bW1a5xoR0/gtLKjPncsdMU1jXA8tNvIZnTahMLYh2C5aS/Jc1QnY8058Tn2A+
 fK9DzdBIk6ze3vaW2eEkLU/xJF4nQ8fdAovWfrvzYJg43vWKWz5uuyHoB4rdE4D1XZM5
 gAJpKjZkf64T6bWeUoNyTZ+O5sLmx93hzk0REFlXHpxNsYJh/9H1BPpFH0kjMnNPjt+Q
 +40H/byUxRv0YzKF+DZpssi6NNION0bBmqHJFtgBwx/8BwDJNZ+PH4OjzVQbzhrMtxRH
 LGi5t5DO2dfUUjDAuMgONYhmGyM+5UtfsxnUzb9TwQlg40Q5FjpeQNdd6/JkLYHku2TR
 QQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676118; x=1791280918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/h6ElBbh9pFqRgZXgY7SIaYH/shWE9rzk2S+mkE/uto=;
 b=AWROBpuQPj0ZWM6I39zp553t7sRcXnN0pI5e7Wb5dVk9/VIFa9tDE6dy96rCVPw9Vl
 uJOHwlAEpaZaB+S0yAEAJAxORlyZ282R5c1oZMRLBDF8ewMKQeHigPIXl/8RoPsXaYu9
 ZfbrwoV7ASRyJ7c31tw/15MXasXHIgaGxFNzp+h/Q82e9qzPcDPiqTCY6D+xNQJEewNM
 W6B143tnMLfi5pDlXNDdJlLxLjr5fckRZKkLZ/0M2pVYFS1LIe22kzIZ4iTXgMZ05zWY
 jGeZtfvLDHR5zvj7+LxkDdN3kmr+TBBzTEIghkk/VKhWif9RjyrSdAfGfIyQUglAcuIS
 +Bfg==
X-Gm-Message-State: AFq9FYLwxoigUFtBGyDaAG4rasEsLw2cU/Jnvriaaa8WZtwFkgalV0f5
 cRoH83ZQlfiZqsS9uiGiGjK4b/7G3Kb6De6zjza7PKfm+nlRxyHcvVz10x6iftYdNBgYQS0aunu
 MkkSU
X-Gm-Gg: AYBFou2tSbuXz75p0y0bSliLNOYy9b4OY4LHHrKDp2Di7CnxGsIvTMx8rBmrN4bJJIQ
 SWgek8JmDjCkNFt6qMsm89kLi88Bwji0fYf80fwikeVqN0cKYoX9zSOBX4Oi4hMmQ4l8euFBCdt
 hNHuspxrL8isbcY9O3LrYXvrRfICnGYb/uJ9BldxeeusidTG5wcnFZM6SpD1bN4SzaF312HNizl
 4AG2i/yjC38fjFtlh0/xENlLV0XW+x012MOgwFngZ6qPpc6SUcUEG6Jxhu2msXY42lmeXXPe1aq
 lpaOdM0UYCfYmfcaqAcxv6gKX2v8SuSmiav4Zu569s1brILKvqsoi3wXBsLBVhnoxCiHqCEWl3K
 yucESWUimMLBx4GMXHEVPeF5Lr01ks+WTNMPuQuSK5yjdnGH9vqwbM4kZrpVASarWCrQm5xgvrQ
 6y3mDW653SiUG6xuqxGgTtPynok6xGrqsGRexfI9WvkaIhiQ+dj9r1B/YYRGeYA/MgqGHM0vKVv
 FMi8WH8CQ6uLjlibx8MwjyzVVsyFLja4AtmwFHUWXrQ4IC7um2WnzDtxFc5wSrotNOOVoMyCc/t
 AZc=
X-Received: by 2002:a05:6000:40e1:b0:488:5fca:a837 with SMTP id
 ffacd0b85a97d-4887da11182mr22682448f8f.20.1790676117947; 
 Tue, 29 Sep 2026 03:01:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/37] target/arm: Drop uses of reset_ignore for banked AArch32
 registers
Date: Tue, 29 Sep 2026 11:01:10 +0100
Message-ID: <20260929100133.2598676-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Some banked AArch32 cpregs set up a resetfn of arm_cp_reset_ignore.
This is presumably in an expectation that some other AArch64
register will handle resetting the underlying state. However
this isn't true for some of them:

 * TPIDRURO's S bank is in cp15.tpidruro_s and this isn't shared
   with any AArch64 register
 * TPIDRURW's S bank similarly is in cp15.tpidrurw_s, not shared
   with any AArch64 register

Remove the use of arm_cp_reset_ignore here; this means that the state
for the NS versions of these registers will be reset twice, but that
is fine because it will always be to the same value (and the
cp_reg_check_reset() code will assert if we introduce a bug where the
AArch64 and AArch32 regs disagree about the reset value).

For the MAIR0 and MAIR1 banked registers, doing nothing on reset is
OK because they are backed by state that is always covered by the
MAIR_EL1 and MAIR_EL3 AArch64 registers that will always be present
if the AArch32 registers are.  But it's not consistent with how we
handle all the other banked regs, so drop it here too.  Again, the
cp_reg_check_reset() checks will catch any mismatches in what the
reset value should be.

The lack of reset-to-zero for the S banked versions of TPIDRURO and
TPIDRURW is very unlikely to have had any guest visible consquences,
because these registers are architecturally UNKNOWN at reset and so
guest code should be initializing them itself regardless.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe9838b3f6d..2bba059b521 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1072,14 +1072,12 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair0_s),
-                             offsetof(CPUARMState, cp15.mair0_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetof(CPUARMState, cp15.mair0_ns) }, },
     { .name = "MAIR1", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair1_s),
-                             offsetof(CPUARMState, cp15.mair1_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetof(CPUARMState, cp15.mair1_ns) }, },
     { .name = "ISR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 0,
       .fgt = FGT_ISR_EL1,
@@ -1136,8 +1134,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .access = PL0_RW,
       .fgt = FGT_TPIDR_EL0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.tpidrurw_s),
-                             offsetoflow32(CPUARMState, cp15.tpidrurw_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetoflow32(CPUARMState, cp15.tpidrurw_ns) }, },
     { .name = "TPIDRRO_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 3, .crn = 13, .crm = 0,
       .access = PL0_R | PL1_W,
@@ -1148,8 +1145,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .access = PL0_R | PL1_W,
       .fgt = FGT_TPIDRRO_EL0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.tpidruro_s),
-                             offsetoflow32(CPUARMState, cp15.tpidruro_ns) },
-      .resetfn = arm_cp_reset_ignore },
+                             offsetoflow32(CPUARMState, cp15.tpidruro_ns) }, },
     { .name = "TPIDR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 4, .crn = 13, .crm = 0,
       .access = PL1_RW,
-- 
2.43.0


