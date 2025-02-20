Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76C8C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J8-0006ta-BO; Thu, 20 Feb 2025 11:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J6-0006se-T7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J4-0008Ce-7G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so8091805e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068504; x=1740673304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GdYLCzTk7t/ZfdW4wyA25i2F7LmeEPqTCsrdAaQ1lqM=;
 b=MSkRotAS5pE5GS4y4kTbFvYdvRXMJAsEYm5iw+AHx9qPQe7KC4MuLEy5Ej6V1H1M8j
 gm2mxfNF93I9aO+FOXDHTlgBaEilDWua6urY3HfPO/TROP6NpAcZP0kguBGYg6ZtpnLv
 NZG1bYSmuaOP/C5qTzFFmlQ1zUUhoMH56053ZVTQ67dgvk3iH9m7kjbDBdYVt8zr4u6Q
 VlugZHJtwMa30zgoD58tU04bhM/7QjRW2cO7AkKAXVpG2VmaLTBXCGcI8RE+PT6I921e
 WKgA764JovrCq5WrBLiE9fFIONNRteNfmTwxVzTRjuT0KHlzty9ym2s9J7Et9P9w+lWY
 3zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068504; x=1740673304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdYLCzTk7t/ZfdW4wyA25i2F7LmeEPqTCsrdAaQ1lqM=;
 b=Tkg+xca9uICgtk6aD/gXKIcTVgvshkE5b6zlncedb88IanIAfAIiypjW3sK8ognD8q
 cMlJHJ8pp9sNXMYBhhITLIxL6VmzLrrwn00LetDYCwXQTpXdAj2KnxOUzNyAbJ0jtnD4
 8ZqlH5cOGj/KI/9Ot1SdUlIT0iKNcEOtJ6BUXIh4KA4wYkIsrAAtuSzc+pquaQkOF2lN
 wo9vjXrVCJCtlvjFX+vQa0Ky9tvCJFPfArSsPVg1t6sm7JcOpgt6p9KkyrOG9+bPs8o8
 UFLcJ0l04HlJ/goOLDFCacFpKQ0Yd4CIqu+Vd4MMiexofCMEHHqXIWBVISpp0GfwgnZr
 vz5A==
X-Gm-Message-State: AOJu0Yx714cckPEQvZw3zLYwsn1edhyGDFZfLVEHR/eEzXSFAQbrHbEo
 5vEppkvP6zrew3AFg8/6pCVt1Jw8Q7k5VyyojnHX8LYYYyJVTZkSkVtom0rKyVSicigkmFOQtWM
 y
X-Gm-Gg: ASbGncuhXsylbqBXn6KZ8ANvo9yAjegBIPop2r5uUnZ2aRVLNIoxQUsMQ8xqhSOaVwy
 BfDdzM6qvmyQy+dB1kt/J5SRJJklwLcQQg4WKpIoN7Cu1jMQTM2oRRqJ0+WqF1v/w5qIOmqa1sF
 XLe9s7GDm2xjlibEA5F+Zo4/8l5yqjYpL0sZE66shkJ6ZIBpTGLx8pwwU+z7ivFTVOuT5UqlwEG
 psJJGLwxLA9uCYbs9pnqnZmeaL+OrJQ05iLDSxwVkln4xPhacxoH5OoZkNX1TYI03rwsy5eAoTa
 FXW1m3FefcCAdhUXDvKJlA==
X-Google-Smtp-Source: AGHT+IGLSE5ZR2sCgBU60f9aVmagn6xJuf6VYqUgF4UeW6xPv9nNgsi1uFCghNyzMPLQ57ZgbRKJAA==
X-Received: by 2002:a05:600c:5112:b0:439:9c0e:3692 with SMTP id
 5b1f17b1804b1-439a4bdb0f4mr25626755e9.28.1740068503338; 
 Thu, 20 Feb 2025 08:21:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] target/arm: Correct errors in WFI/WFE trapping
Date: Thu, 20 Feb 2025 16:20:55 +0000
Message-ID: <20250220162123.626941-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The code for WFI/WFE trapping has several errors:
 * it wasn't using arm_sctlr(), so it would look at SCTLR_EL1
   even if the CPU was in the EL2&0 translation regime
 * it was raising UNDEF, not Monitor Trap, for traps to
   AArch32 EL3 because of SCR.{TWE,TWI}
 * it was not honouring SCR.{TWE,TWI} when running in
   AArch32 at EL3 not in Monitor mode
 * it checked SCR.{TWE,TWI} even on v7 CPUs which don't have
   those bits

Fix these bugs.

Cc: qemu-stable@nongnu.org
Fixes: b1eced713d99 ("target-arm: Add WFx instruction trap support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-15-peter.maydell@linaro.org
---
 target/arm/tcg/op_helper.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 2230351a8f4..02c375d196d 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -313,15 +313,19 @@ void HELPER(check_bxj_trap)(CPUARMState *env, uint32_t rm)
 }
 
 #ifndef CONFIG_USER_ONLY
-/* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
+/*
+ * Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
  * The function returns the target EL (1-3) if the instruction is to be trapped;
  * otherwise it returns 0 indicating it is not trapped.
+ * For a trap, *excp is updated with the EXCP_* trap type to use.
  */
-static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
+static inline int check_wfx_trap(CPUARMState *env, bool is_wfe, uint32_t *excp)
 {
     int cur_el = arm_current_el(env);
     uint64_t mask;
 
+    *excp = EXCP_UDEF;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         /* M profile cores can never trap WFI/WFE. */
         return 0;
@@ -331,18 +335,9 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
      * WFx instructions being trapped to EL1. These trap bits don't exist in v7.
      */
     if (cur_el < 1 && arm_feature(env, ARM_FEATURE_V8)) {
-        int target_el;
-
         mask = is_wfe ? SCTLR_nTWE : SCTLR_nTWI;
-        if (arm_is_secure_below_el3(env) && !arm_el_is_aa64(env, 3)) {
-            /* Secure EL0 and Secure PL1 is at EL3 */
-            target_el = 3;
-        } else {
-            target_el = 1;
-        }
-
-        if (!(env->cp15.sctlr_el[target_el] & mask)) {
-            return target_el;
+        if (!(arm_sctlr(env, cur_el) & mask)) {
+            return exception_target_el(env);
         }
     }
 
@@ -358,9 +353,12 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
     }
 
     /* We are not trapping to EL1 or EL2; trap to EL3 if SCR_EL3 requires it */
-    if (cur_el < 3) {
+    if (arm_feature(env, ARM_FEATURE_V8) && !arm_is_el3_or_mon(env)) {
         mask = (is_wfe) ? SCR_TWE : SCR_TWI;
         if (env->cp15.scr_el3 & mask) {
+            if (!arm_el_is_aa64(env, 3)) {
+                *excp = EXCP_MON_TRAP;
+            }
             return 3;
         }
     }
@@ -383,7 +381,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     return;
 #else
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
 
     if (cpu_has_work(cs)) {
         /* Don't bother to go into our "low power state" if
@@ -399,7 +398,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
                         target_el);
     }
 
@@ -424,7 +423,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #else
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
-    int target_el = check_wfx_trap(env, false);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
     uint64_t offset = gt_virt_cnt_offset(env);
@@ -441,8 +441,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, false),
-                        target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.43.0


