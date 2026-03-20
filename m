Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF0D1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYd-000339-T5; Fri, 20 Mar 2026 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYY-0002xe-OB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:26 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYV-00064k-A8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:26 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so102808166b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011981; x=1774616781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbP2/wL4u9tNVemn6DPcNDAdbehF4LxwnefobBcYCuw=;
 b=kzFdlJsXAR2vDui2UWLhgSk/aozn0zq8QB3M9UES3V1DcmU/DzI/fyEF9HaAHbysgf
 V0c6Yg84xfc8DlULhL/nQeBZeg//2Nx4/EcNiWLO7bWDgP1QCftgmKNHqFlNFHRLvu/y
 q8GT1KEmDmb/ygDlk0wDj7Ky/6IYiKmutRbFjWkZGYR8wfD9YS7qcfWKA9ZstnBsCP3Q
 KebxOmTj6bUILD1bdO288cuDguQSLUY9/ArOa9jRHPA+7Ot/ybo92uJoL8mt/N0oeJZK
 SS3pa3FQRkz51IUNNy1jTnth7RivZuHTyR1Th8OkjzMMa26njDDEvoLN4CAaxrK11x6W
 EOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011981; x=1774616781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KbP2/wL4u9tNVemn6DPcNDAdbehF4LxwnefobBcYCuw=;
 b=OgfvDC1ZDaJWbfJKoY6jBvdtx+lO5pGSgeLwiFJSiR/bOuRTRDLTgtPtqMbQ+MmZWt
 ounLnZGSr2nT+PAI+b6HX5/QblG0GCC8Sr7NhBtm5Y1E6z+/7fs6/CO1lSXlhQENGTHI
 ff216OVeX9LBI40snXXmNh6bM+vyfff7XgOEbQ2TVVDcf2n6JCeK4VkZUCCrXW4pCLiQ
 S8/VW9CWH4RxRKXwPn5CnAZ5HGRMpCZHi281O0rrpx49iDcHd8n55DdiAkZ/WSBaSDyV
 iK73VzZuI2Jo8Ae2tDtdEmxle808HyWfjgy+MxtUOHMKOR+owjGIl44i7ZyeC6wXq5pa
 5rgQ==
X-Gm-Message-State: AOJu0YxNDtciDJsaah0kUjrq2/Xd+haSUj16n7QBS6KV9B4umBZtnenP
 2BEiHud+wGkPwwicCDtX7fF4FrifpeaOrIWXcuvYBQM9O08xLXV7ewKyKUaCOpCDQw4=
X-Gm-Gg: ATEYQzwyrfJcPdG+FQa7axHCGBSgBkU7jpwRWS4UmEU/n6geYo8Bwr77F6pZekPb1D+
 Mz3D0x4gbeBH/pehuQbTtoBXTOdKnZtAjuw7oSLXYRNoyB7lKJURgzZhPPui4+cS4NdP8DGEVuz
 //R7MQGqWkKCoK0CAZBafNHZKG8twQG9QTuNaN6DPyLM6Y/GkH+4MRq291yZzYBRSmV0hDS9Czo
 h5TyxPbc3lCI+WDluEdm3eSzLccrxVvA96kXif349mGDv3fXGMIZYD+YlFHz7Xv4vAQUhG0XqHS
 IY2TPZqkNYiSXki4Pw4eKKckPuwnm44H1UFlHIBHFSYecjM1Bslhne9Y5uS+U1oPbYdGYhG2txo
 H7uHZyDD5dE/eAGPVE+tZzYGD67ccnu3oFAfnnY76s1IFBtzxAtgE+YiSTfERb2voh8PRnK3HD4
 +YmuuApMlelfwc5nzunNetdYY=
X-Received: by 2002:a17:907:1604:b0:b97:edc1:f9c4 with SMTP id
 a640c23a62f3a-b982f1ed7b2mr242657266b.1.1774011981280; 
 Fri, 20 Mar 2026 06:06:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8c16csm160392766b.16.2026.03.20.06.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E06F55FA49;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 26/35] target/arm: add gt_calc_next_event_stream
Date: Fri, 20 Mar 2026 13:05:57 +0000
Message-ID: <20260320130607.2071996-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Two generic timers (K and H) are capable of generating timer event
stream events. Provide a helper to calculate when the nearest one will
happen. This will eventually be used when implementing WFE/WFET.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h    | 10 ++++++
 target/arm/helper.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..bf6cf74c2e1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1208,6 +1208,16 @@ void arm_gt_sel2vtimer_cb(void *opaque);
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
+/**
+ * gt_calc_next_event_stream() - calculate and arm event stream timer
+ * @env: CPUArmState
+ *
+ * Calculate the next event stream time and return it. Returns -1 if
+ * no event streams are enabled. It is up to the WFE helpers to decide
+ * on the next time.
+ */
+int64_t gt_calc_next_event_stream(CPUARMState *env);
+
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
 #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ba6db46d453..3627ffcdcfd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -25,6 +25,7 @@
 #include "exec/icount.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "system/cpus.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
@@ -2022,6 +2023,90 @@ void arm_gt_hvtimer_cb(void *opaque)
     gt_recalc_timer(cpu, GTIMER_HYPVIRT);
 }
 
+/*
+ * Event Stream events don't do anything apart from wake up sleeping
+ * cores. These helpers calculate the next event stream event time so
+ * the WFE helper can decide when its next wake up tick will be.
+ */
+static int64_t gt_recalc_one_evt(CPUARMState *env, uint32_t control, uint64_t offset)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    bool evnten = FIELD_EX32(control, CNTxCTL, EVNTEN);
+
+    if (evnten) {
+        int evnti = FIELD_EX32(control, CNTxCTL, EVNTI);
+        bool evntis = FIELD_EX32(control, CNTxCTL, EVNTIS);
+        bool evntdir = FIELD_EX32(control, CNTxCTL, EVNTDIR);
+        /*
+         * To figure out when the next event timer should fire we need
+         * to calculate which bit of the counter we want to flip and
+         * which transition counts.
+         *
+         * So we calculate 1 << bit - current lower bits and then add
+         * 1 << bit if the bit needs to flip twice to meet evntdir
+         */
+        int bit = evntis ? evnti + 8 : evnti;
+        uint64_t count = gt_get_countervalue(env) - offset;
+        uint64_t target_bit = BIT_ULL(bit);
+        uint64_t lower_bits = MAKE_64BIT_MASK(0, bit - 1);
+        uint64_t next_tick = target_bit - (count & lower_bits);
+        uint64_t abstick;
+
+        /* do we need to bit flip twice? */
+        if (((count & target_bit) != 0) ^ evntdir) {
+            next_tick += target_bit;
+        }
+
+        /*
+         * Note that the desired next expiry time might be beyond the
+         * signed-64-bit range of a QEMUTimer -- in this case we just
+         * set the timer for as far in the future as possible. When the
+         * timer expires we will reset the timer for any remaining period.
+         */
+        if (uadd64_overflow(next_tick, offset, &abstick)) {
+            abstick = UINT64_MAX;
+        }
+        if (abstick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+            return INT64_MAX;
+        } else {
+            return abstick;
+        }
+    }
+
+    return -1;
+}
+
+int64_t gt_calc_next_event_stream(CPUARMState *env)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t hcr = arm_hcr_el2_eff(env);
+    int64_t next_time = -1;
+    uint64_t offset;
+
+    /* Unless we are missing EL2 this can generate events */
+    if (arm_feature(env, ARM_FEATURE_EL2)) {
+        offset = gt_direct_access_timer_offset(env, GTIMER_PHYS);
+        next_time = gt_recalc_one_evt(env, env->cp15.cnthctl_el2, offset);
+    }
+
+    /* Event stream events from virtual counter enabled? */
+    if (!cpu_isar_feature(aa64_vh, cpu) ||
+        !((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE))) {
+        int64_t next_virt_time;
+        offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+        next_virt_time = gt_recalc_one_evt(env, env->cp15.c14_cntkctl, offset);
+
+        /* is this earlier than the next physical event? */
+        if (next_virt_time > 0) {
+            if (next_time < 0 || next_virt_time < next_time) {
+                next_time = next_virt_time;
+            }
+        }
+    }
+
+    return next_time;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /*
      * Note that CNTFRQ is purely reads-as-written for the benefit
-- 
2.47.3


