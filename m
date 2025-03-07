Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399C3C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIO-0000yS-IP; Fri, 07 Mar 2025 10:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIL-0000wP-4o
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZII-0008FX-IV
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:24 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2129292f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360041; x=1741964841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tjmv83nAHErAC/ciev0XLUkQWxcsHmZ1ReYlvJi0IGY=;
 b=Guu0Ak6NFFmQu0ZUku9auCxF27GRuKjZRDKguWgvalHJxLWVrY8CTJ4CfRH5zsdj0Z
 sVgthLXGqKcOxfTO+LLY1Gt14jI+pHSV1XXG3FMFXj/tyTeW8bU3JRra4TtDGz12OBkm
 lw9EQ4sLizEUmKuyHHZ2bXmFgNqZX6k1jca4g80IO1uzz8KhrQcyGe7HUyqb6Tiy5bAA
 7Z1GVD/LLPmlm4U2W66pw8Yqipy1KZSVz2A8AU5Htcyu3MDgnOy2e4mbxS0yNRt4KT3h
 HyOUf8wtNLhR1SJIi3fV0pzqKlQg7l15wf/5rIZV7bDaBVETXkSYRJ0LoW7tfktE21V1
 2b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360041; x=1741964841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjmv83nAHErAC/ciev0XLUkQWxcsHmZ1ReYlvJi0IGY=;
 b=OTx5bNB38sn9tJQe7qgzmJdvoiQRDZDN0D5/KD0IH6YrCwTnTqGtgQLuENeW41WEP1
 Jkx7bsEZw+Ij6JC1HUaOItL2kwaXf5mHUSq3EBnRtJEPbx1a3YJUZN4kq8WkgQyT2u40
 JWjm9ekXnB+zkg3TAfTbfJ3c5k5sTI/Jop0GoxvDALJdExOMeH6gJx1u0Ck4tETnT9UM
 oAg5VKdv6i++Vv82kkEGC8OltNto9Xn/3ir3iOQCz/Ombp8Adfsru1VJFnHoWzZaySHI
 cbR7MjEF+Z3BJm2hbHZtvgRroYjeAxKKgOB6mS/bN2Gneo4EvoDgctKwGo++UH6z9Yv8
 KrGw==
X-Gm-Message-State: AOJu0Yzo1yX4O6wUOARSJC/KRSCeGsTIam3hFuIV4fDquza6dNv0rbpE
 kpQ4RgfLHeDWkFaw5AVF7uVf+MemXGW4/UvessQxDmez5HmFQ7CvgwHPtMYx+mSeApFP6i04/iR
 z
X-Gm-Gg: ASbGncuM4y2iScv9EgxXPQPTFtFMtD0Ce/D+RqQjzZtlHrS98jMj/CMg02z47njeL6d
 kdY1bpY3nGpdqPHakNsQIu8Uz2DbBGxH1wI6huKkGYpZbaGToARgHpo7fTKyxuVCjroFSom9r4p
 LSKnVNv6dhjcqrGbg8sSAX4cAm/K1poQpZ6mFwyAGBmJoDdznKSTVSwHsqm4Nh6M3BwqsFDHmqZ
 U9QJCZSQ+wHwssfU4I0I3SR+DfPF+pc3SpWU6Hho5jJ1nr//1flpv9wawlmg57zKtnohiWZKooW
 7cKivPC4lcVRR1DMBvNdV5kZihjBYNuYvLdMRowaHQmM46ExZtI=
X-Google-Smtp-Source: AGHT+IEh+jo1KriQfa3p7qW9YWfbHuJLVpsEXhwvRrZnQqb57o7H4QKnszqDcH6i6slwLprsIQWDRA==
X-Received: by 2002:a5d:588a:0:b0:38d:d222:ee70 with SMTP id
 ffacd0b85a97d-3913210e1bamr2632600f8f.20.1741360041000; 
 Fri, 07 Mar 2025 07:07:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] target/arm: Refactor handling of timer offset for direct
 register accesses
Date: Fri,  7 Mar 2025 15:06:55 +0000
Message-ID: <20250307150708.3222813-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

When reading or writing the timer registers, sometimes we need to
apply one of the timer offsets.  Specifically, this happens for
direct reads of the counter registers CNTPCT_EL0 and CNTVCT_EL0 (and
their self-synchronized variants CNTVCTSS_EL0 and CNTPCTSS_EL0).  It
also applies for direct reads and writes of the CNT*_TVAL_EL*
registers that provide the 32-bit downcounting view of each timer.

We currently do this with duplicated code in gt_tval_read() and
gt_tval_write() and a special-case in gt_virt_cnt_read() and
gt_cnt_read().  Refactor this so that we handle it all in a single
function gt_direct_access_timer_offset(), to parallel how we handle
the offset for indirect accesses.

The call in the WFIT helper previously to gt_virt_cnt_offset() is
now to gt_direct_access_timer_offset(); this is the correct
behaviour, but it's not immediately obvious that it shouldn't be
considered an indirect access, so we add an explanatory comment.

This commit should make no behavioural changes.

(Cc to stable because the following bugfix commit will
depend on this one.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-6-peter.maydell@linaro.org
---
 target/arm/internals.h     |   5 +-
 target/arm/helper.c        | 103 +++++++++++++++++++------------------
 target/arm/tcg/op_helper.c |   8 ++-
 3 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6ff228f9fd..bb962389192 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1819,9 +1819,10 @@ int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type);
 uint64_t gt_get_countervalue(CPUARMState *env);
 /*
  * Return the currently applicable offset between the system counter
- * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
+ * and the counter for the specified timer, as used for direct register
+ * accesses.
  */
-uint64_t gt_virt_cnt_offset(CPUARMState *env);
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx);
 
 /*
  * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
diff --git a/target/arm/helper.c b/target/arm/helper.c
index acf77793c79..54147d97611 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2455,14 +2455,6 @@ static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
     return 0;
 }
 
-static uint64_t gt_phys_cnt_offset(CPUARMState *env)
-{
-    if (arm_current_el(env) >= 2) {
-        return 0;
-    }
-    return gt_phys_raw_cnt_offset(env);
-}
-
 static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
 {
     /*
@@ -2489,6 +2481,52 @@ static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
     }
 }
 
+uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for direct accesses to the
+     * counter registers CNTPCT and CNTVCT, and for direct accesses
+     * to the CNT*_TVAL registers.
+     *
+     * This isn't exactly the same as the indirect-access offset,
+     * because here we also care about what EL the register access
+     * is being made from.
+     *
+     * This corresponds to the access pseudocode for the registers.
+     */
+    uint64_t hcr;
+
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        if (arm_current_el(env) >= 2) {
+            return 0;
+        }
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
+        switch (arm_current_el(env)) {
+        case 2:
+            hcr = arm_hcr_el2_eff(env);
+            if (hcr & HCR_E2H) {
+                return 0;
+            }
+            break;
+        case 0:
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                return 0;
+            }
+            break;
+        }
+        return env->cp15.cntvoff_el2;
+    case GTIMER_HYP:
+    case GTIMER_SEC:
+    case GTIMER_HYPVIRT:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2561,34 +2599,14 @@ static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_phys_cnt_offset(env);
-}
-
-uint64_t gt_virt_cnt_offset(CPUARMState *env)
-{
-    uint64_t hcr;
-
-    switch (arm_current_el(env)) {
-    case 2:
-        hcr = arm_hcr_el2_eff(env);
-        if (hcr & HCR_E2H) {
-            return 0;
-        }
-        break;
-    case 0:
-        hcr = arm_hcr_el2_eff(env);
-        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
-            return 0;
-        }
-        break;
-    }
-
-    return env->cp15.cntvoff_el2;
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+    return gt_get_countervalue(env) - offset;
 }
 
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    return gt_get_countervalue(env) - offset;
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2609,16 +2627,7 @@ static uint64_t do_tval_read(CPUARMState *env, int timeridx, uint64_t offset)
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = 0;
-
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
     return do_tval_read(env, timeridx, offset);
 }
@@ -2636,16 +2645,8 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = 0;
+    uint64_t offset = gt_direct_access_timer_offset(env, timeridx);
 
-    switch (timeridx) {
-    case GTIMER_VIRT:
-        offset = gt_virt_cnt_offset(env);
-        break;
-    case GTIMER_PHYS:
-        offset = gt_phys_cnt_offset(env);
-        break;
-    }
     do_tval_write(env, timeridx, value, offset);
 }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 02c375d196d..30786fd1ff4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -427,7 +427,13 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
-    uint64_t offset = gt_virt_cnt_offset(env);
+    /*
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
     uint64_t cntvct = cntval - offset;
     uint64_t nexttick;
 
-- 
2.43.0


